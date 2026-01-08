package com.brave.thebrave.api.service;

import com.brave.thebrave.api.response.ContentsHistoryResponse;
import com.brave.thebrave.api.vo.ContentVo;
import com.brave.thebrave.api.vo.ContentsHistoryVo;
import com.brave.thebrave.dao.ContentDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ContentService {
    private final ContentDao contentDao;

    public int saveContent(ContentVo contentVo) { return contentDao.saveContent(contentVo); }

    public ContentVo selectContent(int contents_seq) { return  contentDao.selectContent(contents_seq); }

    /**
     * 컨텐츠 히스토리 저장
     * @param contentVo
     * @return
     */
    public int insertContentHistory(ContentsHistoryVo contentVo) {
        return contentDao.insertContentHistory(contentVo);
    }

    /**
     * 컨텐츠 존재 여부 체크
     * @param vo
     * @return
     */
    public ContentVo isContentsExisting(ContentVo vo) {
        return contentDao.isContentsExisting(vo);
    }

    /**
     * 컨텐츠 수정
     * @param contentVo
     * @return
     */
    public int updateContents(ContentVo contentVo) {
        return contentDao.updateContents(contentVo);
    }

    /**
     * 컨텐츠 등록
     * @param contentVo
     * @return
     */
    public int insertContents(ContentVo contentVo) {
        return contentDao.insertContents(contentVo);
    }

    /**
     * 컨텐츠 히스토리 조회
     * @param menuSeq
     * @return
     */
      public List<ContentsHistoryVo> selectContentHistoryList(String menuSeq) {
          return contentDao.selectContentHistoryList(menuSeq);
      }

    /**
     * 컨텐츠 히스토리 정보 조회
     * @param contestsHisSeq
     * @return
     */
    public ContentsHistoryResponse getContentsHistoryInfo(String contestsHisSeq) {
        return contentDao.getContentsHistoryInfo(contestsHisSeq);
    }

    /**
     * 컨텐츠 히스토리 삭제
     * @param contentsHisSeq
     * @return
     */
    public int deleteContentsHistory(String contentsHisSeq) {
        return contentDao.deleteContentsHistory(contentsHisSeq);
    }

    /**
     * 컨텐츠 히스토리 저장 여부
      * @param contentVo
     * @return
     */
    public ContentVo isHistoryContentsExisting(ContentVo contentVo) {
        return contentDao.isHistoryContentsExisting(contentVo);
    }
}
