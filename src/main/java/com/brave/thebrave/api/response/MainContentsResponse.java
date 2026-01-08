package com.brave.thebrave.api.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Schema(description = "메인컨텐츠 응답정보")
public class MainContentsResponse {

    @Schema(description = "일련번호")
    private String seq;

    @Schema(description = "컨텐츠 한국어")
    private String contents;

    @Schema(description = "컨텐츠 영어")
    private String contentsEng;

    @Schema(description = "컨텐츠 일본어")
    private String contentsJpn;

    @Schema(description = "컨텐츠 베트남어")
    private String contentsVt;

    @Schema(description = "등록일")
    private String regDate;

    @Schema(description = "수정일")
    private String modiDate;
}
