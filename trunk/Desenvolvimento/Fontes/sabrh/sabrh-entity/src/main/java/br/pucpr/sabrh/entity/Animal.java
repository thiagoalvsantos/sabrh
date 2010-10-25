/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
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
	@ForeignKey(name = "FK_ANIMAL_PROPRIEDADE")
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

	/** O atributo status. */
	@Enumerated(EnumType.STRING)
	@Column(name = "IN_STATUS", length = 20)
	private TipoStatusFemea status;

	/** O atributo lista classificacao. */
	@OneToMany(mappedBy = "animal", fetch = FetchType.EAGER)
	private List<ClassificacaoLinear> listaClassificacao;

	/**
	 * Get lista classificacao.
	 * 
	 * @return the lista classificacao
	 * @see Animal#listaClassificacao.
	 */
	public List<ClassificacaoLinear> getListaClassificacao() {
		return listaClassificacao;
	}

	/**
	 * Set lista classificacao.
	 * 
	 * @param listaClassificacao
	 *            - lista classificacao.
	 * @see Animal#listaClassificacao.
	 */
	public void setListaClassificacao(
			List<ClassificacaoLinear> listaClassificacao) {
		this.listaClassificacao = listaClassificacao;
	}

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

	/**
	 * Get status.
	 * 
	 * @return the status
	 * @see Animal#status.
	 */
	public TipoStatusFemea getStatus() {
		return status;
	}

	/**
	 * Set status.
	 * 
	 * @param status
	 *            - status.
	 * @see Animal#status.
	 */
	public void setStatus(TipoStatusFemea status) {
		this.status = status;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((apelido == null) ? 0 : apelido.hashCode());
		result = prime * result
				+ ((dataNascimento == null) ? 0 : dataNascimento.hashCode());
		result = prime
				* result
				+ ((listaClassificacao == null) ? 0 : listaClassificacao
						.hashCode());
		result = prime * result + ((mae == null) ? 0 : mae.hashCode());
		result = prime * result + ((nome == null) ? 0 : nome.hashCode());
		result = prime * result + ((pai == null) ? 0 : pai.hashCode());
		result = prime * result
				+ ((propriedade == null) ? 0 : propriedade.hashCode());
		result = prime * result
				+ ((registro == null) ? 0 : registro.hashCode());
		result = prime * result + ((sexo == null) ? 0 : sexo.hashCode());
		result = prime * result + ((status == null) ? 0 : status.hashCode());
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
		Animal other = (Animal) obj;
		if (apelido == null) {
			if (other.apelido != null)
				return false;
		} else if (!apelido.equals(other.apelido))
			return false;
		if (dataNascimento == null) {
			if (other.dataNascimento != null)
				return false;
		} else if (!dataNascimento.equals(other.dataNascimento))
			return false;
		if (listaClassificacao == null) {
			if (other.listaClassificacao != null)
				return false;
		} else if (!listaClassificacao.equals(other.listaClassificacao))
			return false;
		if (mae == null) {
			if (other.mae != null)
				return false;
		} else if (!mae.equals(other.mae))
			return false;
		if (nome == null) {
			if (other.nome != null)
				return false;
		} else if (!nome.equals(other.nome))
			return false;
		if (pai == null) {
			if (other.pai != null)
				return false;
		} else if (!pai.equals(other.pai))
			return false;
		if (propriedade == null) {
			if (other.propriedade != null)
				return false;
		} else if (!propriedade.equals(other.propriedade))
			return false;
		if (registro == null) {
			if (other.registro != null)
				return false;
		} else if (!registro.equals(other.registro))
			return false;
		if (sexo != other.sexo)
			return false;
		if (status != other.status)
			return false;
		return true;
	}
	
	
}
