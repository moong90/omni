package com.brave.thebrave.dao;

import com.brave.thebrave.api.vo.FooterVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FooterDao {
    @Autowired
    SqlSession sqlSession;

    public FooterVo selectFooter(){
        return sqlSession.selectOne("footer.selectFooterOne");
    }

    public int updateFooter(FooterVo footerVo){
        return sqlSession.update("footer.saveFooterUpdate", footerVo);
    }
}
