package com.brave.thebrave.dao;

import com.brave.thebrave.api.request.InquiryRequest;
import com.brave.thebrave.api.response.InquiryResponse;
import com.brave.thebrave.api.vo.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BoardDao {

    @Autowired
    SqlSession sqlSession;
    
    /**
     * 문의 저장
     * @param inquiryRequest
     */
    public void saveInquiryData(InquiryRequest inquiryRequest) {
        sqlSession.insert("board.saveInquiryData" , inquiryRequest);
    }
    
    /**
     * 문의 리스트
     * @return
     */
    public List<InquiryResponse> getInquiryList() {
        return sqlSession.selectList("board.getInquiryList");
    }
    
    /**
     * 문의 상세 보기
     * @param seq
     * @return
     */
    public InquiryResponse getInquiryOne(String seq) {
        return sqlSession.selectOne("board.getInquiryOne", seq);
    }
    
    /**
     * 문의 삭제
     * @param id
     * @return
     */
	public int deleteInquiry(Integer id) {
		return sqlSession.delete("board.deleteInquiry", id);
	}

    public int countInquiry(SearchFilterVo params) {
        return sqlSession.selectOne("board.countInquiry", params);
    }

    public List<InquiryResponse> getPagingInquiry(SearchFilterVo params) {
        return sqlSession.selectList("board.getPagingInquiry", params);
    }
}
