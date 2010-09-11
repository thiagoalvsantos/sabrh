/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.entity;

/**
 * Enum TipoPerfil.
 */
public enum TipoPerfil {

	/** O atributo ADMINISTRADOR. */
	ADMINISTRADOR('a', "Administrador"),

	/** O atributo ESPECIALISTA. */
	ESPECIALISTA('e', "Especialista"),

	/** O atributo PRODUTOR. */
	PRODUTOR('p', "Produtor");

	/** O atributo codigo. */
	@SuppressWarnings("unused")
	private final char codigo;

	/** O atributo descrição do(a) TipoPerfil. */
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
	private String descricao() {
		return this.descricao;
	}

	// método que define as constantes
	/**
	 * Construtor da classe TipoPerfil.
	 * 
	 * @param codigo
	 *            - codigo.
	 * @param descricao
	 *            - descricao.
	 */
	private TipoPerfil(char codigo, String descricao) {
		this.codigo = codigo;
		this.descricao = descricao;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Enum#toString()
	 */
	@Override
	public String toString() {
		return this.descricao;
	}

	/**
	 * From string.
	 * 
	 * @param string
	 *            - string
	 * @return tipo perfil
	 */
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
