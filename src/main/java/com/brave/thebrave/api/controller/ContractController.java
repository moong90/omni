package com.brave.thebrave.api.controller;

import com.brave.thebrave.api.request.InquiryRequest;
import com.brave.thebrave.api.response.CommonDefaultResponse;
import com.brave.thebrave.api.service.BoardService;
import com.brave.thebrave.constants.RETURN_CODE;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value = "/api/contract")
public class ContractController {

    private static Logger logger = LoggerFactory.getLogger(ContractController.class);

    @Autowired
    private BoardService boardService;

    @RequestMapping(value = "/save",method = RequestMethod.POST)
    @ResponseBody
    public CommonDefaultResponse save(HttpServletRequest request, HttpSession session,
                                      @RequestParam(value = "name", required = false) String name,
                                      @RequestParam(value = "subject", required = false) String subject,
                                      @RequestParam(value = "email", required = false) String email,
                                      @RequestParam(value = "content", required = false) String content
    ) throws Exception {
        InquiryRequest inquiryRequest = new InquiryRequest();

    	try{
            inquiryRequest.setName(name);
            inquiryRequest.setEmail(email);
            inquiryRequest.setTitle(subject);
            inquiryRequest.setContent(content);
            inquiryRequest.setType("inq");

            // 문의 등록
            boardService.saveInquiryData(inquiryRequest);

            return new CommonDefaultResponse(200,"success");
        }catch (Exception e){
            logger.error("error message: " + e.getMessage());
            return new CommonDefaultResponse(RETURN_CODE.ERROR, "ERR");
        }
    }

}
