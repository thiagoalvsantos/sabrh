package br.pucpr.sabrh.entity;

import java.io.Serializable;

public interface Estado extends Serializable {
	
	/**
	 * Get sigla.
	 * 
	 * @return the sigla
	 * @see Estado#sigla.
	 */
	public String getSigla() ;

	/**
	 * Set sigla.
	 * 
	 * @param sigla
	 *            - sigla.
	 * @see Estado#sigla.
	 */
	public void setSigla(String sigla);

	/**
	 * Get descricao.
	 * 
	 * @return the descricao
	 * @see Estado#descricao.
	 */
	public String getDescricao() ;

	/**
	 * Set descricao.
	 * 
	 * @param descricao
	 *            - descricao.
	 * @see Estado#descricao.
	 */
	public void setDescricao(String descricao);


}
