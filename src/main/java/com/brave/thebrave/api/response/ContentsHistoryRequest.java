package com.brave.thebrave.api.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Schema(description = "컨텐츠 히스토리 요청 정보")
public class ContentsHistoryRequest {

  @Schema(description = "컨텐츠 히스토리 SEQ", required = false, example = "1")
  private String contentsHisSeq;


}
