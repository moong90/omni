package com.brave.thebrave.api.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Schema(description = "메뉴 정보")
public class MenuVo{
	
	private Integer menuSeq;
	private Integer parent;
	private Integer depth;
	private Integer level;
	private String urlname;
	private String parentUrlname;
	private String menuName;
	private String menuName2;
	private String menuName3;
	private String menuType;
	private String useYn;
	private Integer categorySeq;
	private Integer contentsSeq;
	private Integer contentsSeq2;
	private Integer contentsSeq3;
	private String link;
	private String regDate;
	private String modiDate;
	private String contents;
	private String contents2;
	private String contents3;
	private String visualCode;
	private String visualCode2;
	private String visualCode3;
	private String seoYn;
	private String seoTitle;
	private String seoDesc;
	private String seoImg;
	private String seoUrl;
	private String seoKeyword;
	private String parentName;
	private String rootName;
	private String rootSeq;
	private String parentMenuName;
	private String langType;

	private String direction;
}