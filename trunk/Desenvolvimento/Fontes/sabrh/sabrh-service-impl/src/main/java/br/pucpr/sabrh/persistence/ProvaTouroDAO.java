/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.FiltroAcasalamento;
import br.pucpr.sabrh.entity.ProvaTouro;

/**
 * Interface ProvaTouroDAO.
 */
@Remote
public interface ProvaTouroDAO {

	/**
	 * Pesquisar.
	 * 
	 * @param animal
	 *            - animal
	 * @return prova touro
	 */
	List<ProvaTouro> pesquisar(Animal animal);

	/**
	 * Salvar.
	 * 
	 * @param provaTouro
	 *            - prova touro
	 * @return prova touro
	 */
	ProvaTouro salvar(ProvaTouro provaTouro);

	/**
	 * Realiza Excluir.
	 * 
	 * @param provaTouro
	 *            - prova touro.
	 */
	void excluir(ProvaTouro provaTouro);

	/**
	 * Pesquisar reprodutor.
	 * 
	 * @param filtroAcasalamento
	 *            - filtro acasalamento
	 * @return list
	 */
	List<ProvaTouro> pesquisarReprodutor(FiltroAcasalamento filtroAcasalamento);
}
