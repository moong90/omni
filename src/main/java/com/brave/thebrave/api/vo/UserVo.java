package com.brave.thebrave.api.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Schema(description = "회원 정보")
public class UserVo {

	private String userId;
	private String userName;
	private String password;
	private String email;
	private String phone;
	private String phone1;
	private String phone2;
	private String phone3;
	private String useYn;
	private String regDate;
	private String modiDate;
	private Integer groupId;
	private String groupName;
	private String address1;
	private String address2;
	private String address3;
	private String address;
	
	private String accountStatus;
	private Integer passwordFailCount;
	private String consentPrivacyYn;
	private String optInEmailYn;
	private String lastLogin;
	private String withdrawnDate;
}
