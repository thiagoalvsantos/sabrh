package br.pucpr.sabrh.entity;

public enum TipoPerfil {
	ADMINISTRADOR('a', "Administrador"), ESPECIALISTA('e', "Especialista"), PRODUTOR(
			'p', "Produtor");

	@SuppressWarnings("unused")
	private final char codigo;
	private final String descricao;

	@SuppressWarnings("unused")
	private char codigo() {
		return this.codigo();
	}

	@SuppressWarnings("unused")
	private String descricao() {
		return this.descricao;
	}

	// método que define as constantes
	private TipoPerfil(char codigo, String descricao) {
		this.codigo = codigo;
		this.descricao = descricao;
	}

	@Override
	public String toString() {
		return this.descricao;
	}

	public static TipoPerfil fromString(String string) {
		TipoPerfil[] perfils = TipoPerfil.values();
		for (TipoPerfil tipoPerfil : perfils) {
			if (tipoPerfil.descricao().equals(string)) {
				return tipoPerfil;
			}
		}
		return null;
	}

}
