package com.brave.thebrave.api.service;

import com.brave.thebrave.api.request.InquiryRequest;
import com.brave.thebrave.api.response.InquiryResponse;
import com.brave.thebrave.api.vo.*;
import com.brave.thebrave.dao.BoardDao;
import com.brave.thebrave.util.paging.Pagination;
import com.brave.thebrave.util.paging.PagingResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
public class BoardService {

    private final BoardDao boardDao;

	/**
     * 문의 저장
     * @param inquiryRequest
     */
    public void saveInquiryData(InquiryRequest inquiryRequest) {
        boardDao.saveInquiryData(inquiryRequest);
    }
    
    /**
     * 문의 리스트
     * @return
     */
    public List<InquiryResponse> getInquiryList() {
        return boardDao.getInquiryList();
    }
    
    /**
     * 문의 상세 보기
     * @param seq
     * @return
     */
    public InquiryResponse getInquiryOne(String seq) {
        return boardDao.getInquiryOne(seq);
    }
    
    /**
     * 문의 삭제
     * @param id
     * @return
     */
	public int deleteInquiry(Integer id) {
		return boardDao.deleteInquiry(id);
	}

    public PagingResponse<InquiryResponse> getPagingInquiry(SearchFilterVo params) {
        int count = boardDao.countInquiry(params);
        if (count<1){
            return new PagingResponse<>(Collections.emptyList(), null);
        }

        Pagination pagination = new Pagination(count,params);
        params.setPagination(pagination);

        List<InquiryResponse> list = boardDao.getPagingInquiry(params);
        return new PagingResponse<>(list, pagination);
    }

}
