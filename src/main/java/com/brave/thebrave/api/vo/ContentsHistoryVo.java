package com.brave.thebrave.api.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

/**
 * 컨텐츠 History를 관리하는 VO
 */
@Getter
@Setter
@Schema(description = "컨텐츠 히스토리 정보")
public class ContentsHistoryVo {

    @Schema(description = "컨텐츠 히스토리 SEQ")
    private String contentsHisSeq;

    @Schema(description = "컨텐츠 SEQ")
    private String contentsSeq;

    @Schema(description = "컨텐츠 내용")
    private String contents;

    @Schema(description = "등록일")
    private String regDate;

    @Schema(description = "언어타입")
    private String langType;

    @Schema(description = "언어명")
    private String langName;
}
