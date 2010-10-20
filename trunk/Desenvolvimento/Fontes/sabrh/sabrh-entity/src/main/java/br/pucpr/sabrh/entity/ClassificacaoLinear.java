package br.pucpr.sabrh.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.ForeignKey;

@Entity
@Table(name = "TB_CLASSIFICACAO_LINEAR")
public class ClassificacaoLinear implements Serializable {

	private static final long serialVersionUID = -1390325109395475133L;

	@Id
	@Column(name = "CODIGO")
	private long codigo;

	@ManyToOne(targetEntity = Animal.class)
	@JoinColumn(name = "CD_ANIMAL", referencedColumnName = "TX_REGISTRO", nullable = false)
	@ForeignKey(name = "FK_CLASSIFICACAO_ANIMAL")
	private Animal animal;

	@Temporal(value = TemporalType.DATE)
	@Column(name = "DT_CLASSIFICACAO", nullable = false)
	private Date dataClassificacao;

	@Temporal(value = TemporalType.DATE)
	@Column(name = "DT_PARTO", nullable = false)
	private Date dataParto;

	// /////////////////////////
	//
	// Força Leiteira
	//
	// /////////////////////////

	@Column(name = "VL_ESTATURA", nullable = false)
	private short estatura;
	@Column(name = "VL_NIV_NIVEL_SUP", nullable = false)
	private short nivelamentoNivelSuperior;
	@Column(name = "VL_LARGURA_PEITO", nullable = false)
	private short larguraPeito;
	@Column(name = "VL_PROFUNDIDADE_CORPORAL", nullable = false)
	private short profundidadeCorporal;
	@Column(name = "VL_ANGULOSIDADE", nullable = false)
	private short angulosidade;
	@Column(name = "VL_ESCORE_CORPORAL", nullable = false)
	private short escoreCorporal;

	@Column(name = "VL_PONT_FORCA_LEITEIRA", nullable = false)
	private short pontuacaoForcaLeiteira;

	// /////////////////////////
	//
	// Garupa
	//
	// /////////////////////////

	@Column(name = "VL_ANGULO_GARUPA", nullable = false)
	private short anguloGarupa;
	@Column(name = "VL_LARGURA_GARUPA", nullable = false)
	private short larguraGarupa;
	@Column(name = "VL_FORCA_LOMBO", nullable = false)
	private short forcaLombo;

	@Column(name = "VL_PONT_GARUPA", nullable = false)
	private short pontuacaoGarupa;

	// /////////////////////////
	//
	// Pernas & Pés
	//
	// /////////////////////////

	@Column(name = "VL_ANGULO_CASCO", nullable = false)
	private short anguloCasco;
	@Column(name = "VL_PROFUND_TALAO", nullable = false)
	private short profundidadeTalao;
	@Column(name = "VL_QUALIDADE_OSSEA", nullable = false)
	private short qualidadeOssea;
	@Column(name = "VL_PERNAS_POST_LATERAL", nullable = false)
	private short pernasPostVistaLateral;
	@Column(name = "VL_PERNAS_POST_POST", nullable = false)
	private short pernasPostVistaPost;

	@Column(name = "VL_PONT_PERNAS_PES", nullable = false)
	private short pontucaoPernasPes;

	// /////////////////////////
	//
	// Sistema Mamário
	//
	// /////////////////////////

	@Column(name = "VL_PROFUND_UBERE", nullable = false)
	private short profundidadeUbere;
	@Column(name = "VL_TEXTURA_UBERE", nullable = false)
	private short texturaUbere;
	@Column(name = "VL_LIGAMENTO_MEDIO", nullable = false)
	private short ligamentoMedio;
	@Column(name = "VL_INSERCAO_UBERE_ANT", nullable = false)
	private short insercaoUbereAnterior;
	@Column(name = "VL_COLOC_TETOS_ANT", nullable = false)
	private short colocacaoTetosAnteriores;
	@Column(name = "VL_ALTURA_UBERE_POST", nullable = false)
	private short alturaUberePosterior;
	@Column(name = "VL_LARGURA_UBERE_POST", nullable = false)
	private short larguraUberePosterior;
	@Column(name = "VL_COLOCACAO_TETOS_POST", nullable = false)
	private short colocacaoTetosPosteriores;
	@Column(name = "VL_COMPRIMENTO_TETOS", nullable = false)
	private short comprimentoTetos;

	@Column(name = "VL_PONT_SISTEMA_MAMARIO", nullable = false)
	private short pontuacaoSistemaMamario;

	@Column(name = "VL_PONT_FINAL", nullable = false)
	private short pontuacaoFinal;

}
