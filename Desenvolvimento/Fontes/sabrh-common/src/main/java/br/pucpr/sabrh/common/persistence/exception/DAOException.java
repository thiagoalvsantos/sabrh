package br.pucpr.sabrh.common.persistence.exception;

/**
 * The Class DAOException.
 */
public class DAOException extends RuntimeException {

    /** The Constant serialVersionUID. */
    private static final long serialVersionUID = 1L;

    /**
     * Construtor da classe DAOException.
     */
    public DAOException() {
        super();
    }

    /**
     * Instantiates a new dAO exception.
     * @param cause
     *            the cause
     */
    public DAOException(Exception cause) {
        super(cause);
    }
}
