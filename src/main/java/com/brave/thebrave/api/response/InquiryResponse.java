package com.brave.thebrave.api.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class InquiryResponse {
	
  private int seq;
  private String type;
  private String name;
  private String email;
  private String tel;
  private String subject;
  private String content;
  private String content2;
  private String regDate;
  private String attachId;
  private String category;
  private String fileName;
  private String filePath;
  private String orgName;
}
