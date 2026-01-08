package com.brave.thebrave.api.controller;

import com.brave.thebrave.api.request.*;
import com.brave.thebrave.api.response.CommonDefaultResponse;
import com.brave.thebrave.api.service.AdminService;
import com.brave.thebrave.constants.RETURN_CODE;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 관리자 Action 처리 API 제어를 하는 Controller
 */
@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/api/admin")
public class AdminController {

    protected Logger logger = LoggerFactory.getLogger(this.getClass());

    private final AdminService service;

    /**
     * 문의 답변 저장
     * @param request
     * @param session
     * @param content2
     * @param seq
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/inquiry/saveAnswer",method = RequestMethod.POST)
    @ResponseBody
    public CommonDefaultResponse saveAnswer(HttpServletRequest request, HttpSession session,
                                      @RequestParam(value = "content2", required = false) String content2,
                                      @RequestParam(value = "seq") String seq
    ) throws Exception {

    	try{
            InquiryRequest inquiryRequest = new InquiryRequest();
            
            inquiryRequest.setSeq(Integer.parseInt(seq));
            inquiryRequest.setContent2(content2);
            // 문의 등록
            service.saveAnswerInquiry(inquiryRequest);

            return new CommonDefaultResponse(200,"success");
        }catch (Exception e){
            return new CommonDefaultResponse(RETURN_CODE.ERROR, "ERR");
        }
    }
}
