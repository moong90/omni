package com.brave.thebrave.exception;

public class BaseBrvException extends Exception{

  public BaseBrvException() {
    super();
  }

  public BaseBrvException(String msg) {
    super(msg);
  }

  public BaseBrvException(String msg, Throwable cause) {
    super(msg, cause);
  }

  public BaseBrvException(Throwable cause) {
    super(cause);
  }
}
