package com.brave.thebrave.api.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Schema(description = "검색필드 정보")
public class SearchFilterVo extends SearchVo{

    private String searchStr;
	private String searchCode;
    private String searchMat;
    private String searchExt;
    private String selectMat;
    private String language;
	private String searchKey;
	private String searchWord;

    private String sqlWhere;
    private String categoryType;

    private String classType;
    private Integer limit;
    
    private String orderBy;
    
    private String lrCode;
    private String mdCode;
    private String smCode;
    private String langType;
    private String use;

}
