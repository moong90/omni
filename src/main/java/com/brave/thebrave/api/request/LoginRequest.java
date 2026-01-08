package com.brave.thebrave.api.request;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@ApiModel
public class LoginRequest {

    @ApiModelProperty(value = "userId", notes = "사용자ID")
    private String userId;

    @ApiModelProperty(value = "password", notes = "비밀번호")
    private String password;

    
    
}
