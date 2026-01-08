package com.brave.thebrave.api.response;


import com.brave.thebrave.constants.RETURN_CODE;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.Data;

@Data
@JsonNaming(PropertyNamingStrategy.SnakeCaseStrategy.class)
public class CommonDefaultResponse<T> {
	private int returnCode;
	private String returnMessage;
	private boolean result;
	private T response;

	public CommonDefaultResponse(RETURN_CODE returnCode) {
		this.returnCode = returnCode.getReturnCode();
		this.returnMessage = returnCode.getReturnMessage();
	}

	public CommonDefaultResponse(RETURN_CODE returnCode, T response) {
		this.returnCode = returnCode.getReturnCode();
		this.returnMessage = returnCode.getReturnMessage();
		this.response = response;
	}

	public CommonDefaultResponse(int returnCode, String returnMessage) {
		this.returnCode = returnCode;
		this.returnMessage = returnMessage;
	}

	public CommonDefaultResponse(int returnCode, String returnMessage, boolean result) {
		this.returnCode = returnCode;
		this.returnMessage = returnMessage;
		this.result = result;
	}
	
	public CommonDefaultResponse(int returnCode, String returnMessage, T response) {
	    this.returnCode = returnCode;
	    this.returnMessage = returnMessage;
	    this.response = response;
	}
}
