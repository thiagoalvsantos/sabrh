package br.pucpr.sabrh.entity;

public enum TipoPerfil {
	ADMINISTRADOR('a', "Administrador"), ESPECIALISTA('e', "Especialista"), PRODUTOR(
			'p', "Produtor");

	private final char codigo;
	private final String descricao;

	private char codigo() {
		return this.codigo();
	}

	private String descricao() {
		return this.descricao;
	}

	// método que define as constantes
	private TipoPerfil(char codigo, String descricao) {
		this.codigo = codigo;
		this.descricao = descricao;
	}
}
