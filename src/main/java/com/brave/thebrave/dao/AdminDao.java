package com.brave.thebrave.dao;

import com.brave.thebrave.api.request.*;
import com.brave.thebrave.api.response.InquiryResponse;
import com.brave.thebrave.api.vo.SearchFilterVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AdminDao {

    @Autowired
    SqlSession sqlSession;

	/**
	 * 문의 답변 저장
	 * @param inquiryRequest
	 */
    public void saveAnswerInquiry(InquiryRequest inquiryRequest) {
        sqlSession.update("admin.saveAnswerInquiry" , inquiryRequest);
    }

	/**
	 * 문의 리스트 카운팅
	 * @param params
	 * @return
	 */
	public int countInquiry(SearchFilterVo params) {
		return sqlSession.selectOne("admin.countInquiry", params);
	}
	
	/**
	 * 문의 리스트 페이징
	 * @param filter
	 * @return
	 */
	public List<InquiryResponse> inquiryPagingList(SearchFilterVo filter) {
		return sqlSession.selectList("admin.inquiryPagingList", filter);
	}
}
