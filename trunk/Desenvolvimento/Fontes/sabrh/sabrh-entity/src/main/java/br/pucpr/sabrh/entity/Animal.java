/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.ForeignKey;

/**
 * Class Animal.
 */
@Entity
@Table(name = "TB_ANIMAL")
public class Animal implements Serializable {

	/** O atributo serial version uid. */
	private static final long serialVersionUID = -4037212053725524957L;

	/** O atributo registro. */
	@Id
	@Column(name = "TX_REGISTRO", length = 20, nullable = false)
	private String registro;

	/** O atributo nome. */
	@Column(name = "TX_NOME", length = 255, nullable = false)
	private String nome;

	/** O atributo apelido. */
	@Column(name = "TX_APELIDO", length = 50, nullable = false)
	private String apelido;

	/** O atributo propriedade. */
	@ManyToOne(targetEntity = Propriedade.class)
	@JoinColumn(name = "CD_PROPRIEDADE", referencedColumnName = "CD_PROPRIEDADE")
	@ForeignKey(name = "FK_ANIMA_PROPRIEDADE")
	private Propriedade propriedade;

	/** O atributo pai. */
	@ManyToOne(targetEntity = Animal.class)
	@JoinColumn(name = "TX_REGISTRO_PAI", referencedColumnName = "TX_REGISTRO")
	@ForeignKey(name = "FK_ANIMAL_PAI")
	private Animal pai;

	/** O atributo mae. */
	@ManyToOne(targetEntity = Animal.class)
	@JoinColumn(name = "TX_REGISTRO_MAE", referencedColumnName = "TX_REGISTRO")
	@ForeignKey(name = "FK_ANIMAL_MAE")
	private Animal mae;

	/** O atributo data nascimento. */
	@Column(name = "DT_NASCIMENTO", nullable = false)
	@Temporal(TemporalType.DATE)
	private Date dataNascimento;

	/** O atributo sexo. */
	@Column(name = "TX_SEXO", nullable = false)
	@Enumerated(EnumType.STRING)
	private TipoSexoAnimal sexo;

	/**
	 * Get registro.
	 * 
	 * @return the registro
	 * @see Animal#registro.
	 */
	public String getRegistro() {
		return registro;
	}

	/**
	 * Set registro.
	 * 
	 * @param registro
	 *            - registro.
	 * @see Animal#registro.
	 */
	public void setRegistro(String registro) {
		this.registro = registro;
	}

	/**
	 * Get nome.
	 * 
	 * @return the nome
	 * @see Animal#nome.
	 */
	public String getNome() {
		return nome;
	}

	/**
	 * Set nome.
	 * 
	 * @param nome
	 *            - nome.
	 * @see Animal#nome.
	 */
	public void setNome(String nome) {
		this.nome = nome;
	}

	/**
	 * Get apelido.
	 * 
	 * @return the apelido
	 * @see Animal#apelido.
	 */
	public String getApelido() {
		return apelido;
	}

	/**
	 * Set apelido.
	 * 
	 * @param apelido
	 *            - apelido.
	 * @see Animal#apelido.
	 */
	public void setApelido(String apelido) {
		this.apelido = apelido;
	}

	/**
	 * Get propriedade.
	 * 
	 * @return the propriedade
	 * @see Animal#propriedade.
	 */
	public Propriedade getPropriedade() {
		return propriedade;
	}

	/**
	 * Set propriedade.
	 * 
	 * @param propriedade
	 *            - propriedade.
	 * @see Animal#propriedade.
	 */
	public void setPropriedade(Propriedade propriedade) {
		this.propriedade = propriedade;
	}

	/**
	 * Get pai.
	 * 
	 * @return the pai
	 * @see Animal#pai.
	 */
	public Animal getPai() {
		return pai;
	}

	/**
	 * Set pai.
	 * 
	 * @param pai
	 *            - pai.
	 * @see Animal#pai.
	 */
	public void setPai(Animal pai) {
		this.pai = pai;
	}

	/**
	 * Get mae.
	 * 
	 * @return the mae
	 * @see Animal#mae.
	 */
	public Animal getMae() {
		return mae;
	}

	/**
	 * Set mae.
	 * 
	 * @param mae
	 *            - mae.
	 * @see Animal#mae.
	 */
	public void setMae(Animal mae) {
		this.mae = mae;
	}

	/**
	 * Get data nascimento.
	 * 
	 * @return the data nascimento
	 * @see Animal#dataNascimento.
	 */
	public Date getDataNascimento() {
		return dataNascimento;
	}

	/**
	 * Set data nascimento.
	 * 
	 * @param dataNascimento
	 *            - data nascimento.
	 * @see Animal#dataNascimento.
	 */
	public void setDataNascimento(Date dataNascimento) {
		this.dataNascimento = dataNascimento;
	}

	/**
	 * Get sexo.
	 * 
	 * @return the sexo
	 * @see Animal#sexo.
	 */
	public TipoSexoAnimal getSexo() {
		return sexo;
	}

	/**
	 * Set sexo.
	 * 
	 * @param sexo
	 *            - sexo.
	 * @see Animal#sexo.
	 */
	public void setSexo(TipoSexoAnimal sexo) {
		this.sexo = sexo;
	}

}
