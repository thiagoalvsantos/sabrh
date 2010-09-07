/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Class Municipio.
 */
@Entity
@Table(name = "TB_MUNICIPIO")
public class Municipio implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3953099658164851068L;

	/** O atributo codigo. */
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE)
	@Column(name = "CD_CODIGO", nullable = false)
	private int codigo;

	/** O atributo descrição do(a) Municipio. */
	@Column(name = "TX_DESCRICAO", length = 100, nullable = false)
	private String descricao;

	/** O atributo estado. */
	@ManyToOne(targetEntity = Estado.class)
	@JoinColumn(name = "TX_ESTADO", referencedColumnName = "TX_SIGLA")
	private Estado estado;

	public int getCodigo() {
		return codigo;
	}

	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public Estado getEstado() {
		return estado;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + codigo;
		result = prime * result
				+ ((descricao == null) ? 0 : descricao.hashCode());
		result = prime * result + ((estado == null) ? 0 : estado.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Municipio other = (Municipio) obj;
		if (codigo != other.codigo)
			return false;
		if (descricao == null) {
			if (other.descricao != null)
				return false;
		} else if (!descricao.equals(other.descricao))
			return false;
		if (estado == null) {
			if (other.estado != null)
				return false;
		} else if (!estado.equals(other.estado))
			return false;
		return true;
	}

	public void setEstado(Estado estado) {
		this.estado = estado;
	}

}
