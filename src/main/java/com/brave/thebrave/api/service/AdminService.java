package com.brave.thebrave.api.service;

import com.brave.thebrave.api.request.*;
import com.brave.thebrave.api.response.InquiryResponse;
import com.brave.thebrave.api.vo.SearchFilterVo;
import com.brave.thebrave.dao.AdminDao;
import com.brave.thebrave.util.paging.Pagination;
import com.brave.thebrave.util.paging.PagingResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminService {

    private final AdminDao dao;
    private final BoardService boardService;

	/**
	 * 문의 답변 저장
	 * @param inquiryRequest
	 */
    public void saveAnswerInquiry(InquiryRequest inquiryRequest) {
    	dao.saveAnswerInquiry(inquiryRequest);
    }
    
    /**
	 * 문의 리스트 페이징
	 * @param request
	 * @return
	 */
	public PagingResponse<InquiryResponse> inquiryPagingList(SearchFilterVo request) {
		int count = dao.countInquiry(request);
		if (count < 1) {
			return new PagingResponse<>(Collections.emptyList(), null);
		}

		Pagination pagination = new Pagination(count, request);
		request.setPagination(pagination);

		List<InquiryResponse> list = dao.inquiryPagingList(request);
		return new PagingResponse<>(list, pagination);
	}
}
