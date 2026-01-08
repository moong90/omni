package com.brave.thebrave.exception.runtime.common;

import com.brave.thebrave.exception.runtime.BaseBrvRuntimeException;

/**
 * Service class 에서 발생한 오류
 */
public class ServiceRuntimeBrvException extends BaseBrvRuntimeException {

  private static final long serialVersionUID = 6028257538936975765L;

  /**
   * Constructs a ServiceRuntimeVgtException with no detail message.
   */
  public ServiceRuntimeBrvException() {
    super();
  }

  /**
   * Constructs a ServiceRuntimeVgtException with the specified detail
   * message.
   * A detail message is a String that describes this particular
   * exception.
   *
   * @param msg the detail message.
   */
  public ServiceRuntimeBrvException(String msg) {
    super(msg);
  }

  /**
   * Creates a {@code ServiceRuntimeVgtException} with the specified
   * detail message and cause.
   *
   * @param message the detail message (which is saved for later retrieval
   *        by the {@link #getMessage()} method).
   * @param cause the cause (which is saved for later retrieval by the
   *        {@link #getCause()} method).  (A {@code null} value is permitted,
   *        and indicates that the cause is nonexistent or unknown.)
   */
  public ServiceRuntimeBrvException(String message, Throwable cause) {
    super(message, cause);
  }

  /**
   * Creates a {@code ServiceRuntimeVgtException} with the specified cause
   * and a detail message of {@code (cause==null ? null : cause.toString())}
   * (which typically contains the class and detail message of
   * {@code cause}).
   *
   * @param cause the cause (which is saved for later retrieval by the
   *        {@link #getCause()} method).  (A {@code null} value is permitted,
   *        and indicates that the cause is nonexistent or unknown.)
   */
  public ServiceRuntimeBrvException(Throwable cause) {
    super(cause);
  }
}
