/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.ClassificacaoLinear;

/**
 * Interface ClassificacaoLinearDAO.
 */
@Remote
public interface ClassificacaoLinearDAO {
	
	/**
	 * Pesquisar.
	 * 
	 * @param animal
	 *            - animal
	 * @return list
	 */
	List<ClassificacaoLinear> pesquisar(Animal animal);
	
	/**
	 * Salvar.
	 * 
	 * @param classificacaoLinear
	 *            - classificacao linear
	 * @return classificacao linear
	 */
	ClassificacaoLinear salvar(ClassificacaoLinear classificacaoLinear);
	
	/**
	 * Realiza Excluir.
	 * 
	 * @param classificacaoLinear
	 *            - classificacao linear.
	 */
	void excluir(ClassificacaoLinear classificacaoLinear);
	
}
