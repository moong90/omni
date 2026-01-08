package com.brave.thebrave.api.service;

import com.brave.thebrave.api.request.LoginRequest;
import com.brave.thebrave.api.vo.UserVo;
import com.brave.thebrave.dao.LoginDao;
import com.brave.thebrave.util.AccountUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class LoginService {

    private final LoginDao loginDao;

    private final AccountUtil accountUtil;

    public UserVo loginCheck(LoginRequest loginRequest) {
    	
    	// 사용자 조회
        UserVo user = loginDao.selectUserInfo(loginRequest);
        if (user == null) {
            return null;
        }

        // 계정 잠금 여부 조회
        if ("LOCKED".equalsIgnoreCase(user.getAccountStatus())) {
            return null;
        }
        if ("N".equalsIgnoreCase(user.getUseYn())) {
            return null;
        }

        // 비밀번호 검증
        boolean match = accountUtil.confirmPasswordEcoded(
                loginRequest.getPassword(), user.getPassword());

        if (!match) {
            return null;
        }

    	return user;
    }
}
