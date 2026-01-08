package com.brave.thebrave.api.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Schema(description = "컨텐츠 히스토리 응답 정보")
public class ContentsHistoryResponse {

  @Schema(description = "컨텐츠 히스토리 SEQ")
  private String contentsHisSeq;

  @Schema(description = "컨텐츠 SEQ")
  private String contentsSeq;

  @Schema(description = "컨텐츠 내용")
  private String contents;

  @Schema(description = "등록일")
  private String regDate;

  @Schema(description = "언어")
  private String langName;
}
