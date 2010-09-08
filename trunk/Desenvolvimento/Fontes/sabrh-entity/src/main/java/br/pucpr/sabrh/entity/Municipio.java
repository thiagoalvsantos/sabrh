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

	public void setEstado(Estado estado) {
		this.estado = estado;
	}

}
