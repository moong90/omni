package com.brave.thebrave.exception.runtime.common;

import com.brave.thebrave.exception.runtime.BaseBrvRuntimeException;

/**
 * 오류 발생시 오류메세지를 Response 로 제공해야 할 경우
 */
public class NotificationRuntimeBrvException extends BaseBrvRuntimeException {

  private static final long serialVersionUID = 6028257538936975765L;

  /**
   * Constructs a NotificationRuntimeVgtException with the specified detail
   * message.
   * A detail message is a String that describes this particular
   * exception.
   *
   * @param msg the detail message.
   */
  public NotificationRuntimeBrvException(String msg) {
    super(msg);
  }

  /**
   * Creates a {@code NotificationRuntimeVgtException} with the specified
   * detail message and cause.
   *
   * @param message the detail message (which is saved for later retrieval
   *        by the {@link #getMessage()} method).
   * @param cause the cause (which is saved for later retrieval by the
   *        {@link #getCause()} method).  (A {@code null} value is permitted,
   *        and indicates that the cause is nonexistent or unknown.)
   */
  public NotificationRuntimeBrvException(String message, Throwable cause) {
    super(message, cause);
  }
}
