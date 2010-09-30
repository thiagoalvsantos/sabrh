/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.entity;

/**
 * Enum TipoStatus.
 */
public enum TipoStatus {

	/** O atributo ATIVO. */
	ATIVO('a', "Ativo"), 
	
	
	/** O atributo INATIVO. */
	INATIVO('i', "Inativo");

	/** O atributo codigo. */
	@SuppressWarnings("unused")
	private final char codigo;
	
	/** O atributo descrição do(a) TipoStatus. */
	private final String descricao;

	/**
	 * Codigo.
	 * 
	 * @return char
	 */
	@SuppressWarnings("unused")
	private char codigo() {
		return this.codigo();
	}

	/**
	 * Descricao.
	 * 
	 * @return string
	 */
	@SuppressWarnings("unused")
	private String descricao() {
		return this.descricao;
	}

	/**
	 * Construtor da classe TipoStatus.
	 * 
	 * @param codigo
	 *            - codigo.
	 * @param descricao
	 *            - descricao.
	 */
	private TipoStatus(char codigo, String descricao) {
		this.codigo = codigo;
		this.descricao = descricao;
	}

}
