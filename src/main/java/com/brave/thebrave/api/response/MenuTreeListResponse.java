package com.brave.thebrave.api.response;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@ApiModel
public class MenuTreeListResponse {
    @ApiModelProperty(name="menuName", notes="메뉴명")
    private String menuName;

    @ApiModelProperty(name="menuName2", notes="메뉴명_2")
    private String menuName2;

    @ApiModelProperty(name="menuName3", notes="메뉴명_3")
    private String menuName3;

    @ApiModelProperty(name="menuSeq", notes = "메뉴ID")
    private Integer menuSeq;

    @ApiModelProperty(name = "parent", notes = "상위메뉴ID")
    private Integer parent;

    @ApiModelProperty(name="lvl", notes="메뉴단계")
    private String lvl;

    @ApiModelProperty( name = "useYn", notes = "사용여부")
    private String useYn;

    @ApiModelProperty( name = "level", notes = "메뉴정렬")
    private Integer level;

    @ApiModelProperty( name="urlname", notes = "urlname")
    private String urlname;

    @ApiModelProperty( name="parentUrlname", notes = "부모URLNAME")
    private String parentUrlname;

    @ApiModelProperty( name="childCnt", notes = "자식메뉴갯수")
    private String childCnt;
    
    @ApiModelProperty(name="fullPath", notes = "fullPath")
	private String fullPath;

    @ApiModelProperty( name="depth", notes = "DEPTH")
    private String depth;

    @ApiModelProperty( name="regDate", notes = "등록일")
    private String regDate;

    @ApiModelProperty( name="modiDate", notes = "최종수정일")
    private String modiDate;

    private String langType;
}
