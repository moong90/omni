package com.brave.thebrave.dao;

import com.brave.thebrave.api.request.LoginRequest;
import com.brave.thebrave.api.vo.UserVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDao {

    @Autowired
    SqlSession sqlSession;

    /**
     * 유저정보 조회
     * @param loginRequest
     * @return
     */
    public UserVo selectUserInfo(LoginRequest loginRequest) {
        return sqlSession.selectOne("login.selectUserInfo", loginRequest);
    }

}
