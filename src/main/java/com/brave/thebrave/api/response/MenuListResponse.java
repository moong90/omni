package com.brave.thebrave.api.response;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@ApiModel
public class MenuListResponse{

	@ApiModelProperty( name = "menuSeq", notes = "메뉴ID")
	private Integer menuSeq;

	@ApiModelProperty( name = "parent", notes = "상위메뉴ID")
	private Integer parent;

	@ApiModelProperty( name = "depth", notes = "메뉴단계")
	private Integer depth;

	@ApiModelProperty( name = "level", notes = "메뉴정렬")
	private Integer level;

	@ApiModelProperty( name = "menuName", notes = "메뉴명")
	private String menuName;

	@ApiModelProperty( name = "menuName2", notes = "메뉴명2")
	private String menuName2;

	@ApiModelProperty( name = "menuName3", notes = "메뉴명3")
	private String menuName3;

	@ApiModelProperty( name = "menuType", notes = "메뉴타입")
	private String menuType;

	@ApiModelProperty( name = "useYn", notes = "사용여부")
	private String useYn;

	@ApiModelProperty( name = "categorySeq", notes = "게시판seq")
	private Integer categorySeq;

	@ApiModelProperty( name = "contentsSeq", notes = "컨텐츠seq")
	private Integer contentsSeq;

	@ApiModelProperty( name = "link", notes = "메뉴링크")
	private String link;

	@ApiModelProperty( name = "regDate", notes = "날짜")
	private String regDate;

	@ApiModelProperty(name="urlname",notes="urlname")
	private String urlname;
	
	@ApiModelProperty(name="parentName", notes = "parentName")
	private String parentName;

	@ApiModelProperty(name="parentUrlname", notes = "부모URLNAME")
	private String parentUrlname;

	@ApiModelProperty(name="rootUrlname", notes = "최상위URLNAME")
	private String rootUrlname;
	
	@ApiModelProperty(name="fullPath", notes = "fullPath")
	private String fullPath;

	private String seoYn;
	private String seoTitle;
	private String seoDesc;
	private String seoImg;
	private String seoUrl;
	private String seoKeyword;

}
