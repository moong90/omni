package com.brave.thebrave.api.controller;

import com.brave.thebrave.api.response.CommonDefaultResponse;
import com.brave.thebrave.api.service.BoardService;
import com.brave.thebrave.util.AccountUtil;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 관리자 게시판 데이터 API 처리 제어를 하는 Controller
 */
@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/api/board")
public class BoardController {

    protected Logger logger = LoggerFactory.getLogger(this.getClass());

    private final BoardService boardService;
    private final AccountUtil accountUtil;
    
    /**
     * 문의 내용 삭제
     * @param request
     * @param session
     * @param seq
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deleteInquiry", method = RequestMethod.POST)
    @ResponseBody
    public CommonDefaultResponse deleteInquiry(HttpServletRequest request, HttpSession session,
            @RequestParam(value = "seq[]") List<Integer> seq) throws Exception {
		try {
			for (Integer id : seq) {
				boardService.deleteInquiry(id);
			}
			return new CommonDefaultResponse(200, "success");
		} catch (Exception e) {
			e.printStackTrace();
			return new CommonDefaultResponse(400, "bad_request");
		}
	}
}
