/**
 * Todos os direitos reservados a Unicamp.
 * @autor : Dayani - Charles Viegas
 *        Data Criação: 13/07/2010 12:07:13
 * @version: $id$
 */
package br.pucpr.sabrh.common.logging;

import java.io.PrintWriter;
import java.io.StringWriter;

/**
 * Classe utilitária para maninpulação de exceções, normalmente será utilizada
 * pela camada Web para criar o "goleiro" de exceções.
 * 
 * @author <a href="mailto:dayani.oliveira@sigma.com.br">Dayani de Oliveira</a>
 */
public final class ExceptionUtils {

	/**
	 * Construtor da classe ExceptionUtils.
	 */
	private ExceptionUtils() {
	}

	/**
	 * Retorna o stackTrace da exceção.
	 * 
	 * @param t
	 *            exceção.
	 * @return String o stackTrace da exceção.
	 */
	public static String getStackTrace(Throwable t) {
		StringWriter stringWriter = new StringWriter();
		PrintWriter printWriter = new PrintWriter(stringWriter);
		t.printStackTrace(printWriter);
		return stringWriter.getBuffer().toString();
	}

	/**
	 * Obtem a exceção mais aninhada.
	 * 
	 * @param t
	 * @return
	 */
	public static Throwable getInnermostThrowable(Throwable t) {
		while ((t.getCause() != null) && (!t.getCause().equals(t))) {
			t = t.getCause();
		}
		return t;
	}
}
