package com.brave.thebrave.api.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

/**
 * 컨텐츠 정보를 관리하는 VO
 */
@Getter
@Setter
@Schema(description = "컨텐츠 정보")
public class ContentVo {

    @Schema(description = "컨텐츠 SEQ")
    private Integer contentsSeq;

    @Schema(description = "컨텐츠 국문")
    private String contents;

    @Schema(description = "컨텐츠 영문")
    private String contentsEng;

    @Schema(description = "컨텐츠 베트남")
    private String contentsVt;

    @Schema(description = "컨텐츠 일본")
    private String contentsJpn;
    
    @Schema(description = "컨텐츠 중국")
    private String contentsCn;

    @Schema(description = "등록일")
    private String regDate;

    @Schema(description = "메뉴 SEQ")
    private String menuSeq;

    @Schema(description = "언어타입")
    private String langType;

}
