/*
 * Todos os direitos reservados a TR Consulting.
 */
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

/**
 * Class ClassificacaoLinear.
 */
@Entity
@Table(name = "TB_CLASSIFICACAO_LINEAR")
public class ClassificacaoLinear implements Serializable {

	/** O atributo serial version uid. */
	private static final long serialVersionUID = -1390325109395475133L;

	/** O atributo codigo. */
	@Id
	@Column(name = "CODIGO")
	private long codigo;

	/** O atributo animal. */
	@ManyToOne(targetEntity = Animal.class)
	@JoinColumn(name = "CD_ANIMAL", referencedColumnName = "TX_REGISTRO", nullable = false)
	@ForeignKey(name = "FK_CLASSIFICACAO_ANIMAL")
	private Animal animal;

	/** O atributo data classificacao. */
	@Temporal(value = TemporalType.DATE)
	@Column(name = "DT_CLASSIFICACAO", nullable = false)
	private Date dataClassificacao;

	/** O atributo lactacao. */
	@Column(name = "VL_LACTACAO", nullable = false)
	private short lactacao;

	// /////////////////////////
	//
	// Força Leiteira
	//
	// /////////////////////////

	/** O atributo estatura. */
	@Column(name = "VL_ESTATURA", nullable = false)
	private short estatura;

	/** O atributo nivelamento nivel superior. */
	@Column(name = "VL_NIV_NIVEL_SUP", nullable = false)
	private short nivelamentoNivelSuperior;

	/** O atributo largura peito. */
	@Column(name = "VL_LARGURA_PEITO", nullable = false)
	private short larguraPeito;

	/** O atributo profundidade corporal. */
	@Column(name = "VL_PROFUNDIDADE_CORPORAL", nullable = false)
	private short profundidadeCorporal;

	/** O atributo angulosidade. */
	@Column(name = "VL_ANGULOSIDADE", nullable = false)
	private short angulosidade;

	/** O atributo escore corporal. */
	@Column(name = "VL_ESCORE_CORPORAL", nullable = false)
	private short escoreCorporal;

	/** O atributo pontuacao forca leiteira. */
	@Column(name = "VL_PONT_FORCA_LEITEIRA", nullable = false)
	private short pontuacaoForcaLeiteira;

	// /////////////////////////
	//
	// Garupa
	//
	// /////////////////////////

	/** O atributo angulo garupa. */
	@Column(name = "VL_ANGULO_GARUPA", nullable = false)
	private short anguloGarupa;

	/** O atributo largura garupa. */
	@Column(name = "VL_LARGURA_GARUPA", nullable = false)
	private short larguraGarupa;

	/** O atributo forca lombo. */
	@Column(name = "VL_FORCA_LOMBO", nullable = false)
	private short forcaLombo;

	/** O atributo pontuacao garupa. */
	@Column(name = "VL_PONT_GARUPA", nullable = false)
	private short pontuacaoGarupa;

	// /////////////////////////
	//
	// Pernas & Pés
	//
	// /////////////////////////

	/** O atributo angulo casco. */
	@Column(name = "VL_ANGULO_CASCO", nullable = false)
	private short anguloCasco;

	/** O atributo profundidade talao. */
	@Column(name = "VL_PROFUND_TALAO", nullable = false)
	private short profundidadeTalao;

	/** O atributo qualidade ossea. */
	@Column(name = "VL_QUALIDADE_OSSEA", nullable = false)
	private short qualidadeOssea;

	/** O atributo pernas post vista lateral. */
	@Column(name = "VL_PERNAS_POST_LATERAL", nullable = false)
	private short pernasPostVistaLateral;

	/** O atributo pernas post vista post. */
	@Column(name = "VL_PERNAS_POST_POST", nullable = false)
	private short pernasPostVistaPost;

	/** O atributo pontucao pernas pes. */
	@Column(name = "VL_PONT_PERNAS_PES", nullable = false)
	private short pontuacaoPernasPes;

	// /////////////////////////
	//
	// Sistema Mamário
	//
	// /////////////////////////

	/** O atributo profundidade ubere. */
	@Column(name = "VL_PROFUND_UBERE", nullable = false)
	private short profundidadeUbere;

	/** O atributo textura ubere. */
	@Column(name = "VL_TEXTURA_UBERE", nullable = false)
	private short texturaUbere;

	/** O atributo ligamento medio. */
	@Column(name = "VL_LIGAMENTO_MEDIO", nullable = false)
	private short ligamentoMedio;

	/** O atributo insercao ubere anterior. */
	@Column(name = "VL_INSERCAO_UBERE_ANT", nullable = false)
	private short insercaoUbereAnterior;

	/** O atributo colocacao tetos anteriores. */
	@Column(name = "VL_COLOC_TETOS_ANT", nullable = false)
	private short colocacaoTetosAnteriores;

	/** O atributo altura ubere posterior. */
	@Column(name = "VL_ALTURA_UBERE_POST", nullable = false)
	private short alturaUberePosterior;

	/** O atributo largura ubere posterior. */
	@Column(name = "VL_LARGURA_UBERE_POST", nullable = false)
	private short larguraUberePosterior;

	/** O atributo colocacao tetos posteriores. */
	@Column(name = "VL_COLOCACAO_TETOS_POST", nullable = false)
	private short colocacaoTetosPosteriores;

	/** O atributo comprimento tetos. */
	@Column(name = "VL_COMPRIMENTO_TETOS", nullable = false)
	private short comprimentoTetos;

	/** O atributo pontuacao sistema mamario. */
	@Column(name = "VL_PONT_SISTEMA_MAMARIO", nullable = false)
	private short pontuacaoSistemaMamario;

	/** O atributo pontuacao final. */
	@Column(name = "VL_PONT_FINAL", nullable = false)
	private short pontuacaoFinal;

	/** O atributo classificacao final. */
	@Column(name = "TX_CLASS_FINAL", length = 3, nullable = false)
	private String classificacaoFinal;

	/**
	 * Get codigo.
	 * 
	 * @return the codigo
	 * @see ClassificacaoLinear#codigo.
	 */
	public long getCodigo() {
		return codigo;
	}

	/**
	 * Set codigo.
	 * 
	 * @param codigo
	 *            - codigo.
	 * @see ClassificacaoLinear#codigo.
	 */
	public void setCodigo(long codigo) {
		this.codigo = codigo;
	}

	/**
	 * Get animal.
	 * 
	 * @return the animal
	 * @see ClassificacaoLinear#animal.
	 */
	public Animal getAnimal() {
		return animal;
	}

	/**
	 * Set animal.
	 * 
	 * @param animal
	 *            - animal.
	 * @see ClassificacaoLinear#animal.
	 */
	public void setAnimal(Animal animal) {
		this.animal = animal;
	}

	/**
	 * Get data classificacao.
	 * 
	 * @return the data classificacao
	 * @see ClassificacaoLinear#dataClassificacao.
	 */
	public Date getDataClassificacao() {
		return dataClassificacao;
	}

	/**
	 * Set data classificacao.
	 * 
	 * @param dataClassificacao
	 *            - data classificacao.
	 * @see ClassificacaoLinear#dataClassificacao.
	 */
	public void setDataClassificacao(Date dataClassificacao) {
		this.dataClassificacao = dataClassificacao;
	}

	/**
	 * /** Get estatura.
	 * 
	 * @return the estatura
	 * @see ClassificacaoLinear#estatura.
	 */
	public short getEstatura() {
		return estatura;
	}

	/**
	 * Get lactacao.
	 * 
	 * @return the lactacao
	 * @see ClassificacaoLinear#lactacao.
	 */
	public short getLactacao() {
		return lactacao;
	}

	/**
	 * Set lactacao.
	 * 
	 * @param lactacao
	 *            - lactacao.
	 * @see ClassificacaoLinear#lactacao.
	 */
	public void setLactacao(short lactacao) {
		this.lactacao = lactacao;
	}

	/**
	 * Set estatura.
	 * 
	 * @param estatura
	 *            - estatura.
	 * @see ClassificacaoLinear#estatura.
	 */
	public void setEstatura(short estatura) {
		this.estatura = estatura;
	}

	/**
	 * Get nivelamento nivel superior.
	 * 
	 * @return the nivelamento nivel superior
	 * @see ClassificacaoLinear#nivelamentoNivelSuperior.
	 */
	public short getNivelamentoNivelSuperior() {
		return nivelamentoNivelSuperior;
	}

	/**
	 * Set nivelamento nivel superior.
	 * 
	 * @param nivelamentoNivelSuperior
	 *            - nivelamento nivel superior.
	 * @see ClassificacaoLinear#nivelamentoNivelSuperior.
	 */
	public void setNivelamentoNivelSuperior(short nivelamentoNivelSuperior) {
		this.nivelamentoNivelSuperior = nivelamentoNivelSuperior;
	}

	/**
	 * Get largura peito.
	 * 
	 * @return the largura peito
	 * @see ClassificacaoLinear#larguraPeito.
	 */
	public short getLarguraPeito() {
		return larguraPeito;
	}

	/**
	 * Set largura peito.
	 * 
	 * @param larguraPeito
	 *            - largura peito.
	 * @see ClassificacaoLinear#larguraPeito.
	 */
	public void setLarguraPeito(short larguraPeito) {
		this.larguraPeito = larguraPeito;
	}

	/**
	 * Get profundidade corporal.
	 * 
	 * @return the profundidade corporal
	 * @see ClassificacaoLinear#profundidadeCorporal.
	 */
	public short getProfundidadeCorporal() {
		return profundidadeCorporal;
	}

	/**
	 * Set profundidade corporal.
	 * 
	 * @param profundidadeCorporal
	 *            - profundidade corporal.
	 * @see ClassificacaoLinear#profundidadeCorporal.
	 */
	public void setProfundidadeCorporal(short profundidadeCorporal) {
		this.profundidadeCorporal = profundidadeCorporal;
	}

	/**
	 * Get angulosidade.
	 * 
	 * @return the angulosidade
	 * @see ClassificacaoLinear#angulosidade.
	 */
	public short getAngulosidade() {
		return angulosidade;
	}

	/**
	 * Set angulosidade.
	 * 
	 * @param angulosidade
	 *            - angulosidade.
	 * @see ClassificacaoLinear#angulosidade.
	 */
	public void setAngulosidade(short angulosidade) {
		this.angulosidade = angulosidade;
	}

	/**
	 * Get escore corporal.
	 * 
	 * @return the escore corporal
	 * @see ClassificacaoLinear#escoreCorporal.
	 */
	public short getEscoreCorporal() {
		return escoreCorporal;
	}

	/**
	 * Set escore corporal.
	 * 
	 * @param escoreCorporal
	 *            - escore corporal.
	 * @see ClassificacaoLinear#escoreCorporal.
	 */
	public void setEscoreCorporal(short escoreCorporal) {
		this.escoreCorporal = escoreCorporal;
	}

	/**
	 * Get pontuacao forca leiteira.
	 * 
	 * @return the pontuacao forca leiteira
	 * @see ClassificacaoLinear#pontuacaoForcaLeiteira.
	 */
	public short getPontuacaoForcaLeiteira() {
		return pontuacaoForcaLeiteira;
	}

	/**
	 * Set pontuacao forca leiteira.
	 * 
	 * @param pontuacaoForcaLeiteira
	 *            - pontuacao forca leiteira.
	 * @see ClassificacaoLinear#pontuacaoForcaLeiteira.
	 */
	public void setPontuacaoForcaLeiteira(short pontuacaoForcaLeiteira) {
		this.pontuacaoForcaLeiteira = pontuacaoForcaLeiteira;
	}

	/**
	 * Get angulo garupa.
	 * 
	 * @return the angulo garupa
	 * @see ClassificacaoLinear#anguloGarupa.
	 */
	public short getAnguloGarupa() {
		return anguloGarupa;
	}

	/**
	 * Set angulo garupa.
	 * 
	 * @param anguloGarupa
	 *            - angulo garupa.
	 * @see ClassificacaoLinear#anguloGarupa.
	 */
	public void setAnguloGarupa(short anguloGarupa) {
		this.anguloGarupa = anguloGarupa;
	}

	/**
	 * Get largura garupa.
	 * 
	 * @return the largura garupa
	 * @see ClassificacaoLinear#larguraGarupa.
	 */
	public short getLarguraGarupa() {
		return larguraGarupa;
	}

	/**
	 * Set largura garupa.
	 * 
	 * @param larguraGarupa
	 *            - largura garupa.
	 * @see ClassificacaoLinear#larguraGarupa.
	 */
	public void setLarguraGarupa(short larguraGarupa) {
		this.larguraGarupa = larguraGarupa;
	}

	/**
	 * Get forca lombo.
	 * 
	 * @return the forca lombo
	 * @see ClassificacaoLinear#forcaLombo.
	 */
	public short getForcaLombo() {
		return forcaLombo;
	}

	/**
	 * Set forca lombo.
	 * 
	 * @param forcaLombo
	 *            - forca lombo.
	 * @see ClassificacaoLinear#forcaLombo.
	 */
	public void setForcaLombo(short forcaLombo) {
		this.forcaLombo = forcaLombo;
	}

	/**
	 * Get pontuacao garupa.
	 * 
	 * @return the pontuacao garupa
	 * @see ClassificacaoLinear#pontuacaoGarupa.
	 */
	public short getPontuacaoGarupa() {
		return pontuacaoGarupa;
	}

	/**
	 * Set pontuacao garupa.
	 * 
	 * @param pontuacaoGarupa
	 *            - pontuacao garupa.
	 * @see ClassificacaoLinear#pontuacaoGarupa.
	 */
	public void setPontuacaoGarupa(short pontuacaoGarupa) {
		this.pontuacaoGarupa = pontuacaoGarupa;
	}

	/**
	 * Get angulo casco.
	 * 
	 * @return the angulo casco
	 * @see ClassificacaoLinear#anguloCasco.
	 */
	public short getAnguloCasco() {
		return anguloCasco;
	}

	/**
	 * Set angulo casco.
	 * 
	 * @param anguloCasco
	 *            - angulo casco.
	 * @see ClassificacaoLinear#anguloCasco.
	 */
	public void setAnguloCasco(short anguloCasco) {
		this.anguloCasco = anguloCasco;
	}

	/**
	 * Get profundidade talao.
	 * 
	 * @return the profundidade talao
	 * @see ClassificacaoLinear#profundidadeTalao.
	 */
	public short getProfundidadeTalao() {
		return profundidadeTalao;
	}

	/**
	 * Set profundidade talao.
	 * 
	 * @param profundidadeTalao
	 *            - profundidade talao.
	 * @see ClassificacaoLinear#profundidadeTalao.
	 */
	public void setProfundidadeTalao(short profundidadeTalao) {
		this.profundidadeTalao = profundidadeTalao;
	}

	/**
	 * Get qualidade ossea.
	 * 
	 * @return the qualidade ossea
	 * @see ClassificacaoLinear#qualidadeOssea.
	 */
	public short getQualidadeOssea() {
		return qualidadeOssea;
	}

	/**
	 * Set qualidade ossea.
	 * 
	 * @param qualidadeOssea
	 *            - qualidade ossea.
	 * @see ClassificacaoLinear#qualidadeOssea.
	 */
	public void setQualidadeOssea(short qualidadeOssea) {
		this.qualidadeOssea = qualidadeOssea;
	}

	/**
	 * Get pernas post vista lateral.
	 * 
	 * @return the pernas post vista lateral
	 * @see ClassificacaoLinear#pernasPostVistaLateral.
	 */
	public short getPernasPostVistaLateral() {
		return pernasPostVistaLateral;
	}

	/**
	 * Set pernas post vista lateral.
	 * 
	 * @param pernasPostVistaLateral
	 *            - pernas post vista lateral.
	 * @see ClassificacaoLinear#pernasPostVistaLateral.
	 */
	public void setPernasPostVistaLateral(short pernasPostVistaLateral) {
		this.pernasPostVistaLateral = pernasPostVistaLateral;
	}

	/**
	 * Get pernas post vista post.
	 * 
	 * @return the pernas post vista post
	 * @see ClassificacaoLinear#pernasPostVistaPost.
	 */
	public short getPernasPostVistaPost() {
		return pernasPostVistaPost;
	}

	/**
	 * Set pernas post vista post.
	 * 
	 * @param pernasPostVistaPost
	 *            - pernas post vista post.
	 * @see ClassificacaoLinear#pernasPostVistaPost.
	 */
	public void setPernasPostVistaPost(short pernasPostVistaPost) {
		this.pernasPostVistaPost = pernasPostVistaPost;
	}

	/**
	 * Get ponatucao pernas pes.
	 * 
	 * @return the pontuacao pernas pes
	 * @see ClassificacaoLinear#pontuacaoPernasPes.
	 */
	public short getPontuacaoPernasPes() {
		return pontuacaoPernasPes;
	}

	/**
	 * Set pontuacao pernas pes.
	 * 
	 * @param pontuacaoPernasPes
	 *            - pontucao pernas pes.
	 * @see ClassificacaoLinear#pontuacaoPernasPes.
	 */
	public void setPontuacaoPernasPes(short pontuacaoPernasPes) {
		this.pontuacaoPernasPes = pontuacaoPernasPes;
	}

	/**
	 * Get profundidade ubere.
	 * 
	 * @return the profundidade ubere
	 * @see ClassificacaoLinear#profundidadeUbere.
	 */
	public short getProfundidadeUbere() {
		return profundidadeUbere;
	}

	/**
	 * Set profundidade ubere.
	 * 
	 * @param profundidadeUbere
	 *            - profundidade ubere.
	 * @see ClassificacaoLinear#profundidadeUbere.
	 */
	public void setProfundidadeUbere(short profundidadeUbere) {
		this.profundidadeUbere = profundidadeUbere;
	}

	/**
	 * Get textura ubere.
	 * 
	 * @return the textura ubere
	 * @see ClassificacaoLinear#texturaUbere.
	 */
	public short getTexturaUbere() {
		return texturaUbere;
	}

	/**
	 * Set textura ubere.
	 * 
	 * @param texturaUbere
	 *            - textura ubere.
	 * @see ClassificacaoLinear#texturaUbere.
	 */
	public void setTexturaUbere(short texturaUbere) {
		this.texturaUbere = texturaUbere;
	}

	/**
	 * Get ligamento medio.
	 * 
	 * @return the ligamento medio
	 * @see ClassificacaoLinear#ligamentoMedio.
	 */
	public short getLigamentoMedio() {
		return ligamentoMedio;
	}

	/**
	 * Set ligamento medio.
	 * 
	 * @param ligamentoMedio
	 *            - ligamento medio.
	 * @see ClassificacaoLinear#ligamentoMedio.
	 */
	public void setLigamentoMedio(short ligamentoMedio) {
		this.ligamentoMedio = ligamentoMedio;
	}

	/**
	 * Get insercao ubere anterior.
	 * 
	 * @return the insercao ubere anterior
	 * @see ClassificacaoLinear#insercaoUbereAnterior.
	 */
	public short getInsercaoUbereAnterior() {
		return insercaoUbereAnterior;
	}

	/**
	 * Set insercao ubere anterior.
	 * 
	 * @param insercaoUbereAnterior
	 *            - insercao ubere anterior.
	 * @see ClassificacaoLinear#insercaoUbereAnterior.
	 */
	public void setInsercaoUbereAnterior(short insercaoUbereAnterior) {
		this.insercaoUbereAnterior = insercaoUbereAnterior;
	}

	/**
	 * Get colocacao tetos anteriores.
	 * 
	 * @return the colocacao tetos anteriores
	 * @see ClassificacaoLinear#colocacaoTetosAnteriores.
	 */
	public short getColocacaoTetosAnteriores() {
		return colocacaoTetosAnteriores;
	}

	/**
	 * Set colocacao tetos anteriores.
	 * 
	 * @param colocacaoTetosAnteriores
	 *            - colocacao tetos anteriores.
	 * @see ClassificacaoLinear#colocacaoTetosAnteriores.
	 */
	public void setColocacaoTetosAnteriores(short colocacaoTetosAnteriores) {
		this.colocacaoTetosAnteriores = colocacaoTetosAnteriores;
	}

	/**
	 * Get altura ubere posterior.
	 * 
	 * @return the altura ubere posterior
	 * @see ClassificacaoLinear#alturaUberePosterior.
	 */
	public short getAlturaUberePosterior() {
		return alturaUberePosterior;
	}

	/**
	 * Set altura ubere posterior.
	 * 
	 * @param alturaUberePosterior
	 *            - altura ubere posterior.
	 * @see ClassificacaoLinear#alturaUberePosterior.
	 */
	public void setAlturaUberePosterior(short alturaUberePosterior) {
		this.alturaUberePosterior = alturaUberePosterior;
	}

	/**
	 * Get largura ubere posterior.
	 * 
	 * @return the largura ubere posterior
	 * @see ClassificacaoLinear#larguraUberePosterior.
	 */
	public short getLarguraUberePosterior() {
		return larguraUberePosterior;
	}

	/**
	 * Set largura ubere posterior.
	 * 
	 * @param larguraUberePosterior
	 *            - largura ubere posterior.
	 * @see ClassificacaoLinear#larguraUberePosterior.
	 */
	public void setLarguraUberePosterior(short larguraUberePosterior) {
		this.larguraUberePosterior = larguraUberePosterior;
	}

	/**
	 * Get colocacao tetos posteriores.
	 * 
	 * @return the colocacao tetos posteriores
	 * @see ClassificacaoLinear#colocacaoTetosPosteriores.
	 */
	public short getColocacaoTetosPosteriores() {
		return colocacaoTetosPosteriores;
	}

	/**
	 * Set colocacao tetos posteriores.
	 * 
	 * @param colocacaoTetosPosteriores
	 *            - colocacao tetos posteriores.
	 * @see ClassificacaoLinear#colocacaoTetosPosteriores.
	 */
	public void setColocacaoTetosPosteriores(short colocacaoTetosPosteriores) {
		this.colocacaoTetosPosteriores = colocacaoTetosPosteriores;
	}

	/**
	 * Get comprimento tetos.
	 * 
	 * @return the comprimento tetos
	 * @see ClassificacaoLinear#comprimentoTetos.
	 */
	public short getComprimentoTetos() {
		return comprimentoTetos;
	}

	/**
	 * Set comprimento tetos.
	 * 
	 * @param comprimentoTetos
	 *            - comprimento tetos.
	 * @see ClassificacaoLinear#comprimentoTetos.
	 */
	public void setComprimentoTetos(short comprimentoTetos) {
		this.comprimentoTetos = comprimentoTetos;
	}

	/**
	 * Get pontuacao sistema mamario.
	 * 
	 * @return the pontuacao sistema mamario
	 * @see ClassificacaoLinear#pontuacaoSistemaMamario.
	 */
	public short getPontuacaoSistemaMamario() {
		return pontuacaoSistemaMamario;
	}

	/**
	 * Set pontuacao sistema mamario.
	 * 
	 * @param pontuacaoSistemaMamario
	 *            - pontuacao sistema mamario.
	 * @see ClassificacaoLinear#pontuacaoSistemaMamario.
	 */
	public void setPontuacaoSistemaMamario(short pontuacaoSistemaMamario) {
		this.pontuacaoSistemaMamario = pontuacaoSistemaMamario;
	}

	/**
	 * Get pontuacao final.
	 * 
	 * @return the pontuacao final
	 * @see ClassificacaoLinear#pontuacaoFinal.
	 */
	public short getPontuacaoFinal() {
		return pontuacaoFinal;
	}

	/**
	 * Set pontuacao final.
	 * 
	 * @param pontuacaoFinal
	 *            - pontuacao final.
	 * @see ClassificacaoLinear#pontuacaoFinal.
	 */
	public void setPontuacaoFinal(short pontuacaoFinal) {
		this.pontuacaoFinal = pontuacaoFinal;
	}

	/**
	 * Get classificacao final.
	 * 
	 * @return the classificacao final
	 * @see ClassificacaoLinear#classificacaoFinal.
	 */
	public String getClassificacaoFinal() {
		return classificacaoFinal;
	}

	/**
	 * Set classificacao final.
	 * 
	 * @param classificacaoFinal
	 *            - classificacao final.
	 * @see ClassificacaoLinear#classificacaoFinal.
	 */
	public void setClassificacaoFinal(String classificacaoFinal) {
		this.classificacaoFinal = classificacaoFinal;
	}

}
