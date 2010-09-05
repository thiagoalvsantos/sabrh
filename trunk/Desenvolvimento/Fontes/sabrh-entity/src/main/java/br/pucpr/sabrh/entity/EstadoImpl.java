/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Class Estado.
 */
@Entity(name="Estado")
@Table(name = "TB_ESTADO")
public class EstadoImpl implements Estado, Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8990519106816482238L;

	/** O atributo sigla. */
	@Id
	@Column(name = "TX_SIGLA", length = 2, nullable = false)
	private String sigla;

	/** O atributo descrição do(a) Estado. */
	@Column(name = "TX_DESCRICAO", length = 30, nullable = false)
	private String descricao;

	/**
	 * Get sigla.
	 * 
	 * @return the sigla
	 * @see Estado#sigla.
	 */
	public String getSigla() {
		return sigla;
	}

	/**
	 * Set sigla.
	 * 
	 * @param sigla
	 *            - sigla.
	 * @see Estado#sigla.
	 */
	public void setSigla(String sigla) {
		this.sigla = sigla;
	}

	/**
	 * Get descricao.
	 * 
	 * @return the descricao
	 * @see Estado#descricao.
	 */
	public String getDescricao() {
		return descricao;
	}

	/**
	 * Set descricao.
	 * 
	 * @param descricao
	 *            - descricao.
	 * @see Estado#descricao.
	 */
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

}
