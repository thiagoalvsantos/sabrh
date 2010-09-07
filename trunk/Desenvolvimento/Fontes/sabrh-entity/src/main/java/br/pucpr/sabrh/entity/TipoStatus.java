/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.entity;

public enum TipoStatus {

	ATIVO('a', "Ativo"), INATIVO('i', "Inativo");

	private final char codigo;
	private final String descricao;

	private char codigo() {
		return this.codigo();
	}

	private String descricao() {
		return this.descricao;
	}

	// método que define as constantes
	private TipoStatus(char codigo, String descricao) {
		this.codigo = codigo;
		this.descricao = descricao;
	}

}
