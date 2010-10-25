/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.entity;

import java.util.List;

/**
 * Class FiltroAcasalamento.
 */
public class FiltroAcasalamento {

	/** O atributo lista conformacao. */
	private List<String> listaConformacao;

	/** O atributo lista producao. */
	private List<String> listaProducao;

	/** O atributo confiabilidade conformacao. */
	private short confiabilidadeConformacao;

	/** O atributo confiabilidade producao. */
	private short confiabilidadeProducao;

	/** O atributo femea. */
	private Animal femea;

	/**
	 * Get lista conformacao.
	 * 
	 * @return the lista conformacao
	 * @see FiltroAcasalamento#listaConformacao.
	 */
	public List<String> getListaConformacao() {
		return listaConformacao;
	}

	/**
	 * Set lista conformacao.
	 * 
	 * @param listaConformacao
	 *            - lista conformacao.
	 * @see FiltroAcasalamento#listaConformacao.
	 */
	public void setListaConformacao(List<String> listaConformacao) {
		this.listaConformacao = listaConformacao;
	}

	/**
	 * Get lista producao.
	 * 
	 * @return the lista producao
	 * @see FiltroAcasalamento#listaProducao.
	 */
	public List<String> getListaProducao() {
		return listaProducao;
	}

	/**
	 * Set lista producao.
	 * 
	 * @param listaProducao
	 *            - lista producao.
	 * @see FiltroAcasalamento#listaProducao.
	 */
	public void setListaProducao(List<String> listaProducao) {
		this.listaProducao = listaProducao;
	}

	/**
	 * Get confiabilidade conformacao.
	 * 
	 * @return the confiabilidade conformacao
	 * @see FiltroAcasalamento#confiabilidadeConformacao.
	 */
	public short getConfiabilidadeConformacao() {
		return confiabilidadeConformacao;
	}

	/**
	 * Set confiabilidade conformacao.
	 * 
	 * @param confiabilidadeConformacao
	 *            - confiabilidade conformacao.
	 * @see FiltroAcasalamento#confiabilidadeConformacao.
	 */
	public void setConfiabilidadeConformacao(short confiabilidadeConformacao) {
		this.confiabilidadeConformacao = confiabilidadeConformacao;
	}

	/**
	 * Get confiabilidade producao.
	 * 
	 * @return the confiabilidade producao
	 * @see FiltroAcasalamento#confiabilidadeProducao.
	 */
	public short getConfiabilidadeProducao() {
		return confiabilidadeProducao;
	}

	/**
	 * Set confiabilidade producao.
	 * 
	 * @param confiabilidadeProducao
	 *            - confiabilidade producao.
	 * @see FiltroAcasalamento#confiabilidadeProducao.
	 */
	public void setConfiabilidadeProducao(short confiabilidadeProducao) {
		this.confiabilidadeProducao = confiabilidadeProducao;
	}

	/**
	 * Get femea.
	 * 
	 * @return the femea
	 * @see FiltroAcasalamento#femea.
	 */
	public Animal getFemea() {
		return femea;
	}

	/**
	 * Set femea.
	 * 
	 * @param femea
	 *            - femea.
	 * @see FiltroAcasalamento#femea.
	 */
	public void setFemea(Animal femea) {
		this.femea = femea;
	}

}
