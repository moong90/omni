package com.brave.thebrave.api.service;

import com.brave.thebrave.api.vo.FooterVo;
import com.brave.thebrave.dao.FooterDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class FooterService {
    private final FooterDao footerDao;

    public FooterVo selectFooterOne(){
    	return footerDao.selectFooter();
    }

    public int updateFooter(FooterVo footerVo){
        return footerDao.updateFooter(footerVo);
    }
}
