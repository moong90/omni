package com.brave.thebrave.dao;

import com.brave.thebrave.api.response.ContentsHistoryResponse;
import com.brave.thebrave.api.vo.ContentVo;
import com.brave.thebrave.api.vo.ContentsHistoryVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ContentDao {
    @Autowired
    SqlSession sqlSession;

    public int saveContent(ContentVo contentVo) {
        return sqlSession.insert("content.saveContent", contentVo);
    }

    public ContentVo selectContent(int contents_seq){
        return sqlSession.selectOne("content.selectContent", contents_seq);
    }

    /**
     * 컨텐츠 히스토리 저장
     * @param contentVo
     * @return
     */
    public int insertContentHistory(ContentsHistoryVo contentVo) {
        return sqlSession.insert("content.insertContentHistory", contentVo);
    }

    /**
     * 컨텐츠 등록 여부 체크
     * @param vo
     * @return
     */
    public ContentVo isContentsExisting(ContentVo vo) {
        return sqlSession.selectOne("content.isContentsExisting", vo);
    }

    /**
     * 컨텐츠 수정
     * @param contentVo
     * @return
     */
    public int updateContents(ContentVo contentVo) {
        return sqlSession.insert("content.updateContents", contentVo);
    }

    /**
     * 컨텐츠 등록
     * @param contentVo
     * @return
     */
    public int insertContents(ContentVo contentVo) {
        return sqlSession.insert("content.insertContents", contentVo);
    }

    /**
     * 컨텐츠 히스토리 조회
     * @param menuSeq
     * @return
     */
    public List<ContentsHistoryVo> selectContentHistoryList(String menuSeq) {
        return sqlSession.selectList("content.selectContentHistoryList", menuSeq);
    }

    /**
     * 컨텐츠 히스토리 정보 조회
     * @param contestsHisSeq
     * @return
     */
    public ContentsHistoryResponse getContentsHistoryInfo(String contestsHisSeq) {
        return sqlSession.selectOne("content.getContentsHistoryInfo", contestsHisSeq);
    }

    /**
     * 컨텐츠 히스토리 삭제
     * @param contentsHisSeq
     * @return
     */
    public int deleteContentsHistory(String contentsHisSeq) {
        return sqlSession.delete("content.deleteContentsHistory", contentsHisSeq);
    }

    /**
     * 컨텐츠 히스토리 저장 여부
     * @param contentVo
     * @return
     */
    public ContentVo isHistoryContentsExisting(ContentVo contentVo) {
        return sqlSession.selectOne("content.isHistoryContentsExisting", contentVo);
    }
}
