package com.brave.thebrave.api.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Schema(description = "메인컨텐츠 정보")
public class MainContentsVo {

    private String seq;
    private String contents;
    private String contentsEng;
    private String contentsJpn;
    private String contentsVt;
    private String contentsCn;
    private String regDate;
    private String modiDate;
}
