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
@Entity
@Table(name = "TB_ESTADO")
public class Estado implements Serializable {

	/** SerialVersionUID */
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((descricao == null) ? 0 : descricao.hashCode());
		result = prime * result + ((sigla == null) ? 0 : sigla.hashCode());
		return result;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Estado other = (Estado) obj;
		if (descricao == null) {
			if (other.descricao != null)
				return false;
		} else if (!descricao.equals(other.descricao))
			return false;
		if (sigla == null) {
			if (other.sigla != null)
				return false;
		} else if (!sigla.equals(other.sigla))
			return false;
		return true;
	}

}
