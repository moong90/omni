package com.brave.thebrave.api.controller;

import com.brave.thebrave.api.request.LoginRequest;
import com.brave.thebrave.api.response.CommonDefaultResponse;
import com.brave.thebrave.api.service.LoginService;
import com.brave.thebrave.api.vo.UserVo;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.mail.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value = "/api/auth")
public class LoginController {

    protected Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private LoginService loginService;

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ApiOperation(httpMethod = "POST", value = "로그인API")
    @ResponseBody
    public CommonDefaultResponse login(HttpServletRequest request, HttpSession session, @RequestBody LoginRequest loginRequest) {

        try {
            UserVo userVo = loginService.loginCheck(loginRequest);
            if (userVo != null) {
                session.setAttribute("loginId", userVo.getUserId());
                session.setAttribute("loginName", userVo.getUserName());
            } else {
                return new CommonDefaultResponse(1112, "아이디 혹은 비밀번호를 잘못 입력하셨습니다.");
            }
            return new CommonDefaultResponse(200, "success");
        } catch (Exception e) {
            e.printStackTrace();
            return new CommonDefaultResponse(400, "bad_request");
        }
    }

    @RequestMapping(value = "/loginout", method = RequestMethod.POST)
    @ApiOperation(httpMethod = "POST", value = "로그아웃API")
    @ResponseBody
    public CommonDefaultResponse loginout(HttpServletRequest request, HttpSession session, @RequestBody LoginRequest loginRequest) {

        try {
            session.removeAttribute("loginId");
            session.removeAttribute("loginName");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.invalidate();
        }
        return new CommonDefaultResponse(200, "success");
    }

}
