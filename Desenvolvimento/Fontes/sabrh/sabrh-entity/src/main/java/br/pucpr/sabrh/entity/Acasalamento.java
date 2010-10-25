package br.pucpr.sabrh.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.ForeignKey;

@Entity
@Table(name = "TB_ACASALAMENTO")
public class Acasalamento implements Serializable {

	private static final long serialVersionUID = 4998414438143675965L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(initialValue = 1, sequenceName = "SEQ_ACASALAMENTO", name = "codigo")
	@Column(name = "CD_CODIGO", length = 8)
	private int codigo;
	
	@ManyToOne(targetEntity = Animal.class)
	@JoinColumn(name = "TX_PAI", referencedColumnName = "TX_REGISTRO",nullable=false)
	@ForeignKey(name = "FK_ACASALAMENTO_PAI")
	private Animal macho;
	
	@ManyToOne(targetEntity = Animal.class)
	@JoinColumn(name = "TX_MAE", referencedColumnName = "TX_REGISTRO",nullable=false)
	@ForeignKey(name = "FK_ACASALAMENTO_MAE")
	private Animal femea;
	
	@ManyToOne(targetEntity = Animal.class)
	@JoinColumn(name = "TX_CRIA", referencedColumnName = "TX_REGISTRO")
	@ForeignKey(name = "FK_ACASALAMENTO_PAI")
	private Animal cria;
	
	@Column(name = "DT_ACASALAMENTO", nullable = false)
	@Temporal(TemporalType.DATE)
	private Date dataAcasalamento;
	
	@Enumerated(EnumType.STRING)
	@Column(name = "ST_STATUS", length = 20, nullable = false)
	private TipoAcasalamento tipoAcasalamento;

	
	@ManyToOne(targetEntity = ClassificacaoLinear.class)
	@JoinColumn(name = "CD_CLASSIFICACAO", referencedColumnName = "CD_CODIGO")
	@ForeignKey(name = "FK_ACASALAMENTO_CLASSIFICACAO")
	private ClassificacaoLinear classificacaoLinear;
	
	
	@ManyToOne(targetEntity = ProvaTouro.class)
	@JoinColumn(name = "CD_PROVA_TOURO", referencedColumnName = "CD_CODIGO")
	@ForeignKey(name = "FK_ACASALAMENTO_PROVA_TOURO")
	private ProvaTouro provaTouro;

	public int getCodigo() {
		return codigo;
	}

	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}

	public Animal getMacho() {
		return macho;
	}

	public void setMacho(Animal macho) {
		this.macho = macho;
	}

	public Animal getFemea() {
		return femea;
	}

	public void setFemea(Animal femea) {
		this.femea = femea;
	}

	public Animal getCria() {
		return cria;
	}

	public void setCria(Animal cria) {
		this.cria = cria;
	}

	public Date getDataAcasalamento() {
		return dataAcasalamento;
	}

	public void setDataAcasalamento(Date dataAcasalamento) {
		this.dataAcasalamento = dataAcasalamento;
	}

	public TipoAcasalamento getTipoAcasalamento() {
		return tipoAcasalamento;
	}

	public void setTipoAcasalamento(TipoAcasalamento tipoAcasalamento) {
		this.tipoAcasalamento = tipoAcasalamento;
	}

	public ClassificacaoLinear getClassificacaoLinear() {
		return classificacaoLinear;
	}

	public void setClassificacaoLinear(ClassificacaoLinear classificacaoLinear) {
		this.classificacaoLinear = classificacaoLinear;
	}

	public ProvaTouro getProvaTouro() {
		return provaTouro;
	}

	public void setProvaTouro(ProvaTouro provaTouro) {
		this.provaTouro = provaTouro;
	}

}