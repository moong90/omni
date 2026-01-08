package com.brave.thebrave.exception;


import com.brave.thebrave.constants.RETURN_CODE;
import com.brave.thebrave.exception.interfaces.CustomException;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CustomBadCredentialException extends RuntimeException implements CustomException {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	private int returnCode;
	private String returnMessage;

	public CustomBadCredentialException(RETURN_CODE returnCode) {
		super(returnCode.getReturnMessage());
		this.returnCode = returnCode.getReturnCode();
		this.returnMessage = returnCode.getReturnMessage();
	}

	public CustomBadCredentialException(RETURN_CODE returnCode, String returnMessage) {
		super(returnCode.getReturnMessage());
		this.returnCode = returnCode.getReturnCode();
		this.returnMessage = returnMessage;
	}

	@Override
	public int getReturnCode() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void setReturnCode(int returnCode) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String getReturnMessage() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void setReturnMessage(String returnMessage) {
		// TODO Auto-generated method stub
		
	}

}
