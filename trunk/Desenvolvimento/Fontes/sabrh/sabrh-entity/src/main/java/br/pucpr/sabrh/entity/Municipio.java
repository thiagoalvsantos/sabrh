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

import org.hibernate.annotations.ForeignKey;

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

	/**
	 * Get codigo.
	 * 
	 * @return the codigo
	 * @see Municipio#codigo.
	 */
	public int getCodigo() {
		return codigo;
	}

	/**
	 * Set codigo.
	 * 
	 * @param codigo
	 *            - codigo.
	 * @see Municipio#codigo.
	 */
	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}

	/**
	 * Get descricao.
	 * 
	 * @return the descricao
	 * @see Municipio#descricao.
	 */
	public String getDescricao() {
		return descricao;
	}

	/**
	 * Set descricao.
	 * 
	 * @param descricao
	 *            - descricao.
	 * @see Municipio#descricao.
	 */
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	/**
	 * Get estado.
	 * 
	 * @return the estado
	 * @see Municipio#estado.
	 */
	public Estado getEstado() {
		return estado;
	}

	/**
	 * Set estado.
	 * 
	 * @param estado
	 *            - estado.
	 * @see Municipio#estado.
	 */
	public void setEstado(Estado estado) {
		this.estado = estado;
	}

}
