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
 * Class ProvaTouro.
 */
@Entity
@Table(name = "TB_PROVA_TOURO")
public class ProvaTouro implements Serializable {

	/** O atributo serial version uid. */
	private static final long serialVersionUID = -7113525652890605408L;

	/** O atributo codigo. */
	@Id
	@Column(name = "CODIGO")
	private long codigo;

	/** O atributo animal. */
	@ManyToOne(targetEntity = Animal.class)
	@JoinColumn(name = "CD_ANIMAL", referencedColumnName = "TX_REGISTRO", nullable = false)
	@ForeignKey(name = "FK_PROVA_TOURO")
	private Animal animal;

	/** O atributo preco. */
	@Column(name = "VL_PRECO", nullable = false)
	private float preco;

	/** O atributo data ultima atualizacao. */
	@Temporal(value = TemporalType.DATE)
	@Column(name = "DT_ULTIMA_ATUALIZACAO", nullable = false)
	private Date dataUltimaAtualizacao;

	// /////////////////////////
	//
	// Produção
	//
	// /////////////////////////

	/** O atributo quantidade filhas. */
	@Column(name = "VL_QUANT_FILHAS", nullable = false)
	private short quantidadeFilhas;

	/** O atributo proteina. */
	@Column(name = "PC_PROTEINA", nullable = false)
	private short proteina;

	/** O atributo gordura. */
	@Column(name = "PC_GORDURA", nullable = false)
	private short gordura;

	/** O atributo quilo leite. */
	@Column(name = "KG_LEITE", nullable = false)
	private float quiloLeite;

	// /////////////////////////
	//
	// Força Leiteira
	//
	// /////////////////////////

	/** O atributo estatura. */
	@Column(name = "VL_ESTATURA", nullable = false)
	private short estatura;

	/** O atributo largura peito. */
	@Column(name = "VL_LARGURA_PEITO", nullable = false)
	private short larguraPeito;

	/** O atributo profundidade corporal. */
	@Column(name = "VL_PROFUNDIDADE_CORPORAL", nullable = false)
	private short profundidadeCorporal;

	/** O atributo angulosidade. */
	@Column(name = "VL_ANGULOSIDADE", nullable = false)
	private short angulosidade;

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

	// /////////////////////////
	//
	// Pernas & Pés
	//
	// /////////////////////////

	/** O atributo angulo casco. */
	@Column(name = "VL_ANGULO_CASCO", nullable = false)
	private short anguloCasco;

	/** O atributo pernas post vista lateral. */
	@Column(name = "VL_PERNAS_POST_LATERAL", nullable = false)
	private short pernasPostVistaLateral;

	/** O atributo pernas post vista post. */
	@Column(name = "VL_PERNAS_POST_POST", nullable = false)
	private short pernasPostVistaPost;

	/** O atributo pontucao pernas pes. */
	@Column(name = "VL_PONT_PERNAS_PES", nullable = false)
	private short pontucaoPernasPes;

	// /////////////////////////
	//
	// Sistema Mamário
	//
	// /////////////////////////

	/** O atributo insercao ubere anterior. */
	@Column(name = "VL_INSERCAO_UBERE_ANT", nullable = false)
	private short insercaoUbereAnterior;

	/** O atributo ligamento medio. */
	@Column(name = "VL_LIGAMENTO_MEDIO", nullable = false)
	private short ligamentoMedio;

	/** O atributo altura ubere posterior. */
	@Column(name = "VL_ALTURA_UBERE_POST", nullable = false)
	private short alturaUberePosterior;

	/** O atributo largura ubere posterior. */
	@Column(name = "VL_LARGURA_UBERE_POST", nullable = false)
	private short larguraUberePosterior;

	/** O atributo profundidade ubere. */
	@Column(name = "VL_PROFUND_UBERE", nullable = false)
	private short profundidadeUbere;

	/** O atributo colocacao tetos anteriores. */
	@Column(name = "VL_COLOC_TETOS_ANT", nullable = false)
	private short colocacaoTetosAnteriores;

	/** O atributo colocacao tetos posteriores. */
	@Column(name = "VL_COLOCACAO_TETOS_POST", nullable = false)
	private short colocacaoTetosPosteriores;

	/** O atributo comprimento tetos. */
	@Column(name = "VL_COMPRIMENTO_TETOS", nullable = false)
	private short comprimentoTetos;

	/** O atributo confiabilidade producao. */
	@Column(name = "PC_CONFIABILIDADE_PRODUCAO", nullable = false)
	private short confiabilidadeProducao;

	/** O atributo confiabilidade conformacao. */
	@Column(name = "PC_CONFIABILIDADE_CONFORMACAO", nullable = false)
	private short confiabilidadeConformacao;

	/**
	 * Get codigo.
	 * 
	 * @return the codigo
	 * @see ProvaTouro#codigo.
	 */
	public long getCodigo() {
		return codigo;
	}

	/**
	 * Set codigo.
	 * 
	 * @param codigo
	 *            - codigo.
	 * @see ProvaTouro#codigo.
	 */
	public void setCodigo(long codigo) {
		this.codigo = codigo;
	}

	/**
	 * Get animal.
	 * 
	 * @return the animal
	 * @see ProvaTouro#animal.
	 */
	public Animal getAnimal() {
		return animal;
	}

	/**
	 * Set animal.
	 * 
	 * @param animal
	 *            - animal.
	 * @see ProvaTouro#animal.
	 */
	public void setAnimal(Animal animal) {
		this.animal = animal;
	}

	/**
	 * Get preco.
	 * 
	 * @return the preco
	 * @see ProvaTouro#preco.
	 */
	public float getPreco() {
		return preco;
	}

	/**
	 * Set preco.
	 * 
	 * @param preco
	 *            - preco.
	 * @see ProvaTouro#preco.
	 */
	public void setPreco(float preco) {
		this.preco = preco;
	}

	/**
	 * Get data ultima atualizacao.
	 * 
	 * @return the data ultima atualizacao
	 * @see ProvaTouro#dataUltimaAtualizacao.
	 */
	public Date getDataUltimaAtualizacao() {
		return dataUltimaAtualizacao;
	}

	/**
	 * Set data ultima atualizacao.
	 * 
	 * @param dataUltimaAtualizacao
	 *            - data ultima atualizacao.
	 * @see ProvaTouro#dataUltimaAtualizacao.
	 */
	public void setDataUltimaAtualizacao(Date dataUltimaAtualizacao) {
		this.dataUltimaAtualizacao = dataUltimaAtualizacao;
	}

	/**
	 * Get quantidade filhas.
	 * 
	 * @return the quantidade filhas
	 * @see ProvaTouro#quantidadeFilhas.
	 */
	public short getQuantidadeFilhas() {
		return quantidadeFilhas;
	}

	/**
	 * Set quantidade filhas.
	 * 
	 * @param quantidadeFilhas
	 *            - quantidade filhas.
	 * @see ProvaTouro#quantidadeFilhas.
	 */
	public void setQuantidadeFilhas(short quantidadeFilhas) {
		this.quantidadeFilhas = quantidadeFilhas;
	}

	/**
	 * Get proteina.
	 * 
	 * @return the proteina
	 * @see ProvaTouro#proteina.
	 */
	public short getProteina() {
		return proteina;
	}

	/**
	 * Set proteina.
	 * 
	 * @param proteina
	 *            - proteina.
	 * @see ProvaTouro#proteina.
	 */
	public void setProteina(short proteina) {
		this.proteina = proteina;
	}

	/**
	 * Get gordura.
	 * 
	 * @return the gordura
	 * @see ProvaTouro#gordura.
	 */
	public short getGordura() {
		return gordura;
	}

	/**
	 * Set gordura.
	 * 
	 * @param gordura
	 *            - gordura.
	 * @see ProvaTouro#gordura.
	 */
	public void setGordura(short gordura) {
		this.gordura = gordura;
	}

	/**
	 * Get quilo leite.
	 * 
	 * @return the quilo leite
	 * @see ProvaTouro#quiloLeite.
	 */
	public float getQuiloLeite() {
		return quiloLeite;
	}

	/**
	 * Set quilo leite.
	 * 
	 * @param quiloLeite
	 *            - quilo leite.
	 * @see ProvaTouro#quiloLeite.
	 */
	public void setQuiloLeite(float quiloLeite) {
		this.quiloLeite = quiloLeite;
	}

	/**
	 * Get estatura.
	 * 
	 * @return the estatura
	 * @see ProvaTouro#estatura.
	 */
	public short getEstatura() {
		return estatura;
	}

	/**
	 * Set estatura.
	 * 
	 * @param estatura
	 *            - estatura.
	 * @see ProvaTouro#estatura.
	 */
	public void setEstatura(short estatura) {
		this.estatura = estatura;
	}

	/**
	 * Get largura peito.
	 * 
	 * @return the largura peito
	 * @see ProvaTouro#larguraPeito.
	 */
	public short getLarguraPeito() {
		return larguraPeito;
	}

	/**
	 * Set largura peito.
	 * 
	 * @param larguraPeito
	 *            - largura peito.
	 * @see ProvaTouro#larguraPeito.
	 */
	public void setLarguraPeito(short larguraPeito) {
		this.larguraPeito = larguraPeito;
	}

	/**
	 * Get profundidade corporal.
	 * 
	 * @return the profundidade corporal
	 * @see ProvaTouro#profundidadeCorporal.
	 */
	public short getProfundidadeCorporal() {
		return profundidadeCorporal;
	}

	/**
	 * Set profundidade corporal.
	 * 
	 * @param profundidadeCorporal
	 *            - profundidade corporal.
	 * @see ProvaTouro#profundidadeCorporal.
	 */
	public void setProfundidadeCorporal(short profundidadeCorporal) {
		this.profundidadeCorporal = profundidadeCorporal;
	}

	/**
	 * Get angulosidade.
	 * 
	 * @return the angulosidade
	 * @see ProvaTouro#angulosidade.
	 */
	public short getAngulosidade() {
		return angulosidade;
	}

	/**
	 * Set angulosidade.
	 * 
	 * @param angulosidade
	 *            - angulosidade.
	 * @see ProvaTouro#angulosidade.
	 */
	public void setAngulosidade(short angulosidade) {
		this.angulosidade = angulosidade;
	}

	/**
	 * Get angulo garupa.
	 * 
	 * @return the angulo garupa
	 * @see ProvaTouro#anguloGarupa.
	 */
	public short getAnguloGarupa() {
		return anguloGarupa;
	}

	/**
	 * Set angulo garupa.
	 * 
	 * @param anguloGarupa
	 *            - angulo garupa.
	 * @see ProvaTouro#anguloGarupa.
	 */
	public void setAnguloGarupa(short anguloGarupa) {
		this.anguloGarupa = anguloGarupa;
	}

	/**
	 * Get largura garupa.
	 * 
	 * @return the largura garupa
	 * @see ProvaTouro#larguraGarupa.
	 */
	public short getLarguraGarupa() {
		return larguraGarupa;
	}

	/**
	 * Set largura garupa.
	 * 
	 * @param larguraGarupa
	 *            - largura garupa.
	 * @see ProvaTouro#larguraGarupa.
	 */
	public void setLarguraGarupa(short larguraGarupa) {
		this.larguraGarupa = larguraGarupa;
	}

	/**
	 * Get angulo casco.
	 * 
	 * @return the angulo casco
	 * @see ProvaTouro#anguloCasco.
	 */
	public short getAnguloCasco() {
		return anguloCasco;
	}

	/**
	 * Set angulo casco.
	 * 
	 * @param anguloCasco
	 *            - angulo casco.
	 * @see ProvaTouro#anguloCasco.
	 */
	public void setAnguloCasco(short anguloCasco) {
		this.anguloCasco = anguloCasco;
	}

	/**
	 * Get pernas post vista lateral.
	 * 
	 * @return the pernas post vista lateral
	 * @see ProvaTouro#pernasPostVistaLateral.
	 */
	public short getPernasPostVistaLateral() {
		return pernasPostVistaLateral;
	}

	/**
	 * Set pernas post vista lateral.
	 * 
	 * @param pernasPostVistaLateral
	 *            - pernas post vista lateral.
	 * @see ProvaTouro#pernasPostVistaLateral.
	 */
	public void setPernasPostVistaLateral(short pernasPostVistaLateral) {
		this.pernasPostVistaLateral = pernasPostVistaLateral;
	}

	/**
	 * Get pernas post vista post.
	 * 
	 * @return the pernas post vista post
	 * @see ProvaTouro#pernasPostVistaPost.
	 */
	public short getPernasPostVistaPost() {
		return pernasPostVistaPost;
	}

	/**
	 * Set pernas post vista post.
	 * 
	 * @param pernasPostVistaPost
	 *            - pernas post vista post.
	 * @see ProvaTouro#pernasPostVistaPost.
	 */
	public void setPernasPostVistaPost(short pernasPostVistaPost) {
		this.pernasPostVistaPost = pernasPostVistaPost;
	}

	/**
	 * Get pontucao pernas pes.
	 * 
	 * @return the pontucao pernas pes
	 * @see ProvaTouro#pontucaoPernasPes.
	 */
	public short getPontucaoPernasPes() {
		return pontucaoPernasPes;
	}

	/**
	 * Set pontucao pernas pes.
	 * 
	 * @param pontucaoPernasPes
	 *            - pontucao pernas pes.
	 * @see ProvaTouro#pontucaoPernasPes.
	 */
	public void setPontucaoPernasPes(short pontucaoPernasPes) {
		this.pontucaoPernasPes = pontucaoPernasPes;
	}

	/**
	 * Get insercao ubere anterior.
	 * 
	 * @return the insercao ubere anterior
	 * @see ProvaTouro#insercaoUbereAnterior.
	 */
	public short getInsercaoUbereAnterior() {
		return insercaoUbereAnterior;
	}

	/**
	 * Set insercao ubere anterior.
	 * 
	 * @param insercaoUbereAnterior
	 *            - insercao ubere anterior.
	 * @see ProvaTouro#insercaoUbereAnterior.
	 */
	public void setInsercaoUbereAnterior(short insercaoUbereAnterior) {
		this.insercaoUbereAnterior = insercaoUbereAnterior;
	}

	/**
	 * Get ligamento medio.
	 * 
	 * @return the ligamento medio
	 * @see ProvaTouro#ligamentoMedio.
	 */
	public short getLigamentoMedio() {
		return ligamentoMedio;
	}

	/**
	 * Set ligamento medio.
	 * 
	 * @param ligamentoMedio
	 *            - ligamento medio.
	 * @see ProvaTouro#ligamentoMedio.
	 */
	public void setLigamentoMedio(short ligamentoMedio) {
		this.ligamentoMedio = ligamentoMedio;
	}

	/**
	 * Get altura ubere posterior.
	 * 
	 * @return the altura ubere posterior
	 * @see ProvaTouro#alturaUberePosterior.
	 */
	public short getAlturaUberePosterior() {
		return alturaUberePosterior;
	}

	/**
	 * Set altura ubere posterior.
	 * 
	 * @param alturaUberePosterior
	 *            - altura ubere posterior.
	 * @see ProvaTouro#alturaUberePosterior.
	 */
	public void setAlturaUberePosterior(short alturaUberePosterior) {
		this.alturaUberePosterior = alturaUberePosterior;
	}

	/**
	 * Get largura ubere posterior.
	 * 
	 * @return the largura ubere posterior
	 * @see ProvaTouro#larguraUberePosterior.
	 */
	public short getLarguraUberePosterior() {
		return larguraUberePosterior;
	}

	/**
	 * Set largura ubere posterior.
	 * 
	 * @param larguraUberePosterior
	 *            - largura ubere posterior.
	 * @see ProvaTouro#larguraUberePosterior.
	 */
	public void setLarguraUberePosterior(short larguraUberePosterior) {
		this.larguraUberePosterior = larguraUberePosterior;
	}

	/**
	 * Get profundidade ubere.
	 * 
	 * @return the profundidade ubere
	 * @see ProvaTouro#profundidadeUbere.
	 */
	public short getProfundidadeUbere() {
		return profundidadeUbere;
	}

	/**
	 * Set profundidade ubere.
	 * 
	 * @param profundidadeUbere
	 *            - profundidade ubere.
	 * @see ProvaTouro#profundidadeUbere.
	 */
	public void setProfundidadeUbere(short profundidadeUbere) {
		this.profundidadeUbere = profundidadeUbere;
	}

	/**
	 * Get colocacao tetos anteriores.
	 * 
	 * @return the colocacao tetos anteriores
	 * @see ProvaTouro#colocacaoTetosAnteriores.
	 */
	public short getColocacaoTetosAnteriores() {
		return colocacaoTetosAnteriores;
	}

	/**
	 * Set colocacao tetos anteriores.
	 * 
	 * @param colocacaoTetosAnteriores
	 *            - colocacao tetos anteriores.
	 * @see ProvaTouro#colocacaoTetosAnteriores.
	 */
	public void setColocacaoTetosAnteriores(short colocacaoTetosAnteriores) {
		this.colocacaoTetosAnteriores = colocacaoTetosAnteriores;
	}

	/**
	 * Get colocacao tetos posteriores.
	 * 
	 * @return the colocacao tetos posteriores
	 * @see ProvaTouro#colocacaoTetosPosteriores.
	 */
	public short getColocacaoTetosPosteriores() {
		return colocacaoTetosPosteriores;
	}

	/**
	 * Set colocacao tetos posteriores.
	 * 
	 * @param colocacaoTetosPosteriores
	 *            - colocacao tetos posteriores.
	 * @see ProvaTouro#colocacaoTetosPosteriores.
	 */
	public void setColocacaoTetosPosteriores(short colocacaoTetosPosteriores) {
		this.colocacaoTetosPosteriores = colocacaoTetosPosteriores;
	}

	/**
	 * Get comprimento tetos.
	 * 
	 * @return the comprimento tetos
	 * @see ProvaTouro#comprimentoTetos.
	 */
	public short getComprimentoTetos() {
		return comprimentoTetos;
	}

	/**
	 * Set comprimento tetos.
	 * 
	 * @param comprimentoTetos
	 *            - comprimento tetos.
	 * @see ProvaTouro#comprimentoTetos.
	 */
	public void setComprimentoTetos(short comprimentoTetos) {
		this.comprimentoTetos = comprimentoTetos;
	}

	/**
	 * Get confiabilidade producao.
	 * 
	 * @return the confiabilidade producao
	 * @see ProvaTouro#confiabilidadeProducao.
	 */
	public short getConfiabilidadeProducao() {
		return confiabilidadeProducao;
	}

	/**
	 * Set confiabilidade producao.
	 * 
	 * @param confiabilidadeProducao
	 *            - confiabilidade producao.
	 * @see ProvaTouro#confiabilidadeProducao.
	 */
	public void setConfiabilidadeProducao(short confiabilidadeProducao) {
		this.confiabilidadeProducao = confiabilidadeProducao;
	}

	/**
	 * Get confiabilidade conformacao.
	 * 
	 * @return the confiabilidade conformacao
	 * @see ProvaTouro#confiabilidadeConformacao.
	 */
	public short getConfiabilidadeConformacao() {
		return confiabilidadeConformacao;
	}

	/**
	 * Set confiabilidade conformacao.
	 * 
	 * @param confiabilidadeConformacao
	 *            - confiabilidade conformacao.
	 * @see ProvaTouro#confiabilidadeConformacao.
	 */
	public void setConfiabilidadeConformacao(short confiabilidadeConformacao) {
		this.confiabilidadeConformacao = confiabilidadeConformacao;
	}

}