package com.brave.thebrave.api.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Schema(description = "Footer 정보")
public class FooterVo {

    @Schema(description = "내용")
    private String contents;
    
    @Schema(description = "내용2")
    private String contents2;

    @Schema(description = "내용3")
    private String contents3;

    @Schema(description = "등록일")
    private String regDate;

    @Schema(description = "언어타입")
    private String langType;
}
