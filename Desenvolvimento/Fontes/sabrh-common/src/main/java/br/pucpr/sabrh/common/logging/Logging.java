/**
 * Todos os direitos reservados a Unicamp.
 * @autor : Dayani - Charles Viegas
 *        Data Criação: 13/07/2010 12:07:23
 * @version: $id$
 */
package br.pucpr.sabrh.common.logging;

import org.apache.log4j.Logger;

/**
 * Classe utilitária para manipular os logs da aplicação
 * @author <a href="mailto:dayani.oliveira@sigma.com.br">Dayani de Oliveira</a>
 * @version 1.0
 */
public class Logging {

    /**
     * Nome configurado para o appender RESUMIDO
     */
    private static final String DIGEST = "DIGEST";

    /** Instância real do logger GERAL */
    private Logger logger = null;

    /** Instância do logger RESUMIDO */
    private Logger loggerDigest = null;

    /**
     * getters and setters
     */
    public void setLogger(Logger mlogger) {
        this.logger = mlogger;
    }

    /**
     * Set logger digest.
     * @param mloggerDigest
     *            - mlogger digest.
     * @see Logging#loggerDigest.
     */
    public void setLoggerDigest(Logger mloggerDigest) {
        this.loggerDigest = mloggerDigest;
    }

    /**
     * Retorna a instância do Logger. O parâmetro deste método deve ser
     * <b>getClass().getName()</b>.
     * @param className
     *            Nome da classe que está querendo o Logger
     * @return Instância do Logger
     */
    public static Logging getLogger(String className) {
        Logging result = new Logging();
        result.setLogger(org.apache.log4j.Logger.getLogger(className));
        result.setLoggerDigest(Logger.getLogger(DIGEST));
        return result;
    }

    /**
     * Escreve uma informação de debug no log, caso o debug esteja habilitado.
     * @param object
     *            Mensagem que deve ser escrita.
     */
    public void debug(Object object, Object... params) {
        if (logger.isDebugEnabled()) {
            logger.debug(formatLogMessage(object, params));
        }

    }

    /**
     * Escreve uma informação de debug no log, caso o debug esteja habilitado.
     * @param object
     *            - Mensagem que deve ser escrita
     * @param t
     *            - Exceção que também deve ser logada
     */
    public void debug(Object object, Throwable t, Object... params) {

        if (logger.isDebugEnabled()) {
            logger.debug(formatLogMessage(object, params), t);

            if (t instanceof RuntimeException) {
                this.loggerDigest.debug(formatLogMessage(object, params),
                    ExceptionUtils.getInnermostThrowable(t));
            }

        }
    }

    /**
     * Escreve uma informação de erro no log.
     * @param object
     *            - Mensagem que deve ser escrita
     */
    public void error(Object object, Object... params) {
        logger.error(formatLogMessage(object, params));
    }

    /**
     * Escreve uma mensagem do tipo ERROR no log, caso o erro esteja habilitado
     * @param object
     *            - Mensagem do tipo ERROR a ser escrita
     */
    public void error(Object object, Throwable t, Object... params) {
        logger.error(formatLogMessage(object, params), t);

        if (t instanceof RuntimeException) {
            this.loggerDigest.error(formatLogMessage(object, params),
                ExceptionUtils.getInnermostThrowable(t));
        }
    }

    /**
     * Escreve uma mensagem do tipo INFO no log, caso o info esteja habilitado
     * @param object
     *            - Mensagem do tipo INFO a ser escrita
     */
    public void info(Object object, Object... params) {
        if (logger.isInfoEnabled()) {
            logger.info(formatLogMessage(object, params));
        }

    }

    /**
     * Escreve uma mensagem do tipo INFO no log, caso o info esteja habilitado
     * @param object
     *            - Mensagem do tipo INFO a ser escrita
     */
    public void info(Object object, Throwable t, Object... params) {

        if (logger.isInfoEnabled()) {
            logger.info(formatLogMessage(object, params), t);

            if (t instanceof RuntimeException) {
                this.loggerDigest.info(formatLogMessage(object, params),
                    ExceptionUtils.getInnermostThrowable(t));
            }

        }
    }

    /**
     * Escreve uma mensagem do tipo WARN no log, caso o info esteja habilitado
     * @param object
     *            - Mensagem do tipo WARN a ser escrita
     */

    public void warn(Object object, Object... params) {
        logger.warn(formatLogMessage(object, params));
    }

    /**
     * Escreve uma mensagem do tipo WARN no log, caso o info esteja habilitado
     * @param object
     *            - Mensagem do tipo WARN a ser escrita
     */

    public void warn(Object object, Throwable t, Object... params) {
        logger.warn(formatLogMessage(object, params), t);

        if (t instanceof RuntimeException) {
            this.loggerDigest.warn(formatLogMessage(object, params),
                ExceptionUtils.getInnermostThrowable(t));
        }
    }

    /**
     * Verifica se o debug está habilitado.
     */
    public boolean isDebugEnabled() {
        return logger.isDebugEnabled();
    }

    /**
     * Verifica se a escrita de mensagens do tipo INFO está ativada.
     * @return Se a escrita do tipo INFO está ativada
     */
    public boolean isInfoEnabled() {
        return logger.isInfoEnabled();
    }

    /**
     * Exemplo:
     * log.debug("Creating new order for user: #0 product: #1 quantity: #2",
     * user.username(), product.name(), quantity);
     */
    private static String formatLogMessage(Object msg, Object... params) {
        if (msg == null) {
            return null;
        }
        String str = msg.toString();
        if (params != null) {
            for (Object p : params) {
                if (p != null) {
                    str = str.replaceFirst("#\\d+", p.toString());
                }
            }
        }
        return str;
    }
}
