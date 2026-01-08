package com.brave.thebrave.api.controller;

import com.brave.thebrave.api.response.CommonDefaultResponse;
import com.brave.thebrave.api.service.FooterService;
import com.brave.thebrave.api.vo.FooterVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/api/footer")
public class FooterController {
    @Autowired
    private FooterService footerService;

    @RequestMapping(value = "modify", method = RequestMethod.POST)
    @ResponseBody
    public CommonDefaultResponse update(HttpServletRequest request, HttpSession session,
                                        @RequestParam(value = "contents") String contents,
                                        @RequestParam(value = "contents2", required = false) String contents2,
                                        @RequestParam(value = "contents3", required = false) String contents3,
                                        @RequestParam(value = "langType", required = false) String langType
                                        ) throws Exception {
        if (session.getAttribute("loginId") == null) {
            return new CommonDefaultResponse(1007, "로그인이 필요한 기능입니다.");
        }
        try {

            FooterVo footerVo = new FooterVo();

            footerVo.setContents(contents);
            footerVo.setContents2(contents2);
            footerVo.setContents3(contents3);
            footerVo.setLangType(langType);

            footerService.updateFooter(footerVo);

            return new CommonDefaultResponse(200, "success");
        } catch (Exception e) {
            e.printStackTrace();
            return new CommonDefaultResponse(400, e.getMessage());
        }
    }

}
