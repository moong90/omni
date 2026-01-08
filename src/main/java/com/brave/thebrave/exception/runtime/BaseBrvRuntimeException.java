package com.brave.thebrave.exception.runtime;

public class BaseBrvRuntimeException extends RuntimeException{

  public BaseBrvRuntimeException() {
    super();
  }

  public BaseBrvRuntimeException(String msg) {
    super(msg);
  }

  public BaseBrvRuntimeException(String msg, Throwable cause) {
    super(msg, cause);
  }

  public BaseBrvRuntimeException(Throwable cause) {
    super(cause);
  }
}
