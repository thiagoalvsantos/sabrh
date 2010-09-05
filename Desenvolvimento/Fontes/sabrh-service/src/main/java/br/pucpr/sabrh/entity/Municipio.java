package br.pucpr.sabrh.entity;

import java.io.Serializable;

public interface Municipio extends Serializable {
	/**
	 * Get codigo.
	 * 
	 * @return the codigo
	 * @see Municipio#codigo.
	 */
	public int getCodigo();

	/**
	 * Set codigo.
	 * 
	 * @param codigo
	 *            - codigo.
	 * @see Municipio#codigo.
	 */
	public void setCodigo(int codigo);

	/**
	 * Get descricao.
	 * 
	 * @return the descricao
	 * @see Municipio#descricao.
	 */
	public String getDescricao();

	/**
	 * Set descricao.
	 * 
	 * @param descricao
	 *            - descricao.
	 * @see Municipio#descricao.
	 */
	public void setDescricao(String descricao);

	/**
	 * Get estado.
	 * 
	 * @return the estado
	 * @see Municipio#estado.
	 */
	public Estado getEstado();

	/**
	 * Set estado.
	 * 
	 * @param estado
	 *            - estado.
	 * @see Municipio#estado.
	 */
	public void setEstado(Estado estado);
}
