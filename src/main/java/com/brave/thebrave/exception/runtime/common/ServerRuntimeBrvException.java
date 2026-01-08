package com.brave.thebrave.exception.runtime.common;

import com.brave.thebrave.exception.runtime.BaseBrvRuntimeException;

/**
 * <pre>
 * 일반적인 예외 관련 runtime exception
 * </pre>
 */
public class ServerRuntimeBrvException extends BaseBrvRuntimeException {
  
  private static final long serialVersionUID = 6028257538936975765L;

  /**
     * Constructs a ServerVgtException with no detail message.
     */
    public ServerRuntimeBrvException() {
        super();
    }

    /**
     * Constructs a ServerVgtException with the specified detail
     * message.
     * A detail message is a String that describes this particular
     * exception.
     *
     * @param msg the detail message.
     */
    public ServerRuntimeBrvException(String msg) {
        super(msg);
    }

    /**
     * Creates a {@code ServerVgtException} with the specified
     * detail message and cause.
     *
     * @param message the detail message (which is saved for later retrieval
     *        by the {@link #getMessage()} method).
     * @param cause the cause (which is saved for later retrieval by the
     *        {@link #getCause()} method).  (A {@code null} value is permitted,
     *        and indicates that the cause is nonexistent or unknown.)
     */
    public ServerRuntimeBrvException(String message, Throwable cause) {
        super(message, cause);
    }

    /**
     * Creates a {@code ServerVgtException} with the specified cause
     * and a detail message of {@code (cause==null ? null : cause.toString())}
     * (which typically contains the class and detail message of
     * {@code cause}).
     *
     * @param cause the cause (which is saved for later retrieval by the
     *        {@link #getCause()} method).  (A {@code null} value is permitted,
     *        and indicates that the cause is nonexistent or unknown.)
     */
    public ServerRuntimeBrvException(Throwable cause) {
        super(cause);
    }

}
