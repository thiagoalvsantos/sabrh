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
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.ForeignKey;

/**
 * Class Propriedade.
 */
@Entity
@Table(name = "TB_PROPRIEDADE")
public class Propriedade implements Serializable {

	/** SerialVersionUID */
	private static final long serialVersionUID = 3586035303430645327L;

	/** O atributo codigo. */
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(initialValue = 0, sequenceName = "SEQ_PROPRIEDADE", name = "codigo_propriedade")
	@Column(name = "CD_PROPRIEDADE", length = 8)
	private long codigo;

	/** O atributo proprietario. */
	@ManyToOne(targetEntity = Usuario.class)
	@JoinColumn(name = "CD_PROPRIETARIO", referencedColumnName = "CD_CODIGO")
	@ForeignKey(name = "FK_PROPRIEDADE_PROPRIETARIO")
	private Usuario proprietario;

	/** O atributo nome. */
	@Column(name = "TX_NOME", nullable = false, length = 100)
	private String nome;

	/** O atributo municipio. */
	@ManyToOne(targetEntity = Municipio.class)
	@JoinColumn(name = "CD_MUNICIPIO", referencedColumnName = "CD_CODIGO")
	@ForeignKey(name = "FK_PROPRIEDADE_MUNICIPIO")
	private Municipio municipio;

	/** O atributo telefone. */
	@Column(name = "TX_TELEFONE", nullable = false, length = 10)
	private String telefone;

	/**
	 * Get codigo.
	 * 
	 * @return the codigo
	 * @see Propriedade#codigo.
	 */
	public long getCodigo() {
		return codigo;
	}

	/**
	 * Set codigo.
	 * 
	 * @param codigo
	 *            - codigo.
	 * @see Propriedade#codigo.
	 */
	public void setCodigo(long codigo) {
		this.codigo = codigo;
	}

	/**
	 * Get proprietario.
	 * 
	 * @return the proprietario
	 * @see Propriedade#proprietario.
	 */
	public Usuario getProprietario() {
		return proprietario;
	}

	/**
	 * Set proprietario.
	 * 
	 * @param proprietario
	 *            - proprietario.
	 * @see Propriedade#proprietario.
	 */
	public void setProprietario(Usuario proprietario) {
		this.proprietario = proprietario;
	}

	/**
	 * Get nome.
	 * 
	 * @return the nome
	 * @see Propriedade#nome.
	 */
	public String getNome() {
		return nome;
	}

	/**
	 * Set nome.
	 * 
	 * @param nome
	 *            - nome.
	 * @see Propriedade#nome.
	 */
	public void setNome(String nome) {
		this.nome = nome;
	}

	/**
	 * Get municipio.
	 * 
	 * @return the municipio
	 * @see Propriedade#municipio.
	 */
	public Municipio getMunicipio() {
		return municipio;
	}

	/**
	 * Set municipio.
	 * 
	 * @param municipio
	 *            - municipio.
	 * @see Propriedade#municipio.
	 */
	public void setMunicipio(Municipio municipio) {
		this.municipio = municipio;
	}

	/**
	 * Get telefone.
	 * 
	 * @return the telefone
	 * @see Propriedade#telefone.
	 */
	public String getTelefone() {
		return telefone;
	}

	/**
	 * Set telefone.
	 * 
	 * @param telefone
	 *            - telefone.
	 * @see Propriedade#telefone.
	 */
	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}

}
