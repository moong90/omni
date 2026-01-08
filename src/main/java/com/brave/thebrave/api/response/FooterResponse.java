package com.brave.thebrave.api.response;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@ApiModel
public class FooterResponse {
    @ApiModelProperty(name="seq", notes="seq")
    private Integer seq;
    @ApiModelProperty(name="contents", notes="contents")
    private String contents;
    @ApiModelProperty(name="contents2", notes = "contents2")
    private String contents2;
    @ApiModelProperty(name="contents3", notes = "contents3")
    private String contents3;
}
