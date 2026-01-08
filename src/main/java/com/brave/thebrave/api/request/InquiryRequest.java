package com.brave.thebrave.api.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class InquiryRequest {

	private int seq;
	private String type;
	private String title;
	private String name;
	private String email;
	private String content;
	private String content2;
	private String regdate;
	private Integer attachId;
	private String fileName;
	private String filePath;
	private String category;
	private String tel;
}
