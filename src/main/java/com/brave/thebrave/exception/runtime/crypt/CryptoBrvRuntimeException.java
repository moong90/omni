package com.brave.thebrave.exception.runtime.crypt;

import com.brave.thebrave.exception.runtime.BaseBrvRuntimeException;

/**
 * <pre>
 * 암호화 Encode 처리 관련 runtime exception
 * </pre>
 */
public class CryptoBrvRuntimeException extends BaseBrvRuntimeException {
  
  private static final long serialVersionUID = 6028257538936975765L;

  /**
     * Constructs a CryptoVgtRuntimeException with no detail message.
     */
    public CryptoBrvRuntimeException() {
        super();
    }

    /**
     * Constructs a CryptoVgtRuntimeException with the specified detail
     * message.
     * A detail message is a String that describes this particular
     * exception.
     *
     * @param msg the detail message.
     */
    public CryptoBrvRuntimeException(String msg) {
        super(msg);
    }

    /**
     * Creates a {@code CryptoVgtRuntimeException} with the specified
     * detail message and cause.
     *
     * @param message the detail message (which is saved for later retrieval
     *        by the {@link #getMessage()} method).
     * @param cause the cause (which is saved for later retrieval by the
     *        {@link #getCause()} method).  (A {@code null} value is permitted,
     *        and indicates that the cause is nonexistent or unknown.)
     */
    public CryptoBrvRuntimeException(String message, Throwable cause) {
        super(message, cause);
    }

    /**
     * Creates a {@code CryptoVgtRuntimeException} with the specified cause
     * and a detail message of {@code (cause==null ? null : cause.toString())}
     * (which typically contains the class and detail message of
     * {@code cause}).
     *
     * @param cause the cause (which is saved for later retrieval by the
     *        {@link #getCause()} method).  (A {@code null} value is permitted,
     *        and indicates that the cause is nonexistent or unknown.)
     */
    public CryptoBrvRuntimeException(Throwable cause) {
        super(cause);
    }
}
