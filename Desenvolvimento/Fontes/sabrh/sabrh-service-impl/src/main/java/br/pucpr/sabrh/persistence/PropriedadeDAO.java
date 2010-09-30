/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Propriedade;

/**
 * Interface PropriedadeDAO.
 */
@Remote
public interface PropriedadeDAO {

	/**
	 * Listar.
	 * 
	 * @param propriedade
	 *            - propriedade
	 * @return list
	 */
	List<Propriedade> listar(Propriedade propriedade);

	/**
	 * Salvar.
	 * 
	 * @param propriedade
	 *            - propriedade
	 * @return propriedade
	 */
	Propriedade salvar(Propriedade propriedade);
}
