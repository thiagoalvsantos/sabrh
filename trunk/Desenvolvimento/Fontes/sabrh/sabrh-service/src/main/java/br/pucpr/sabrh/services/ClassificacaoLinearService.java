/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.services;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.ClassificacaoLinear;

/**
 * Interface de serviço da camada core relacionado ao componente
 * ClassificacaoLinear.
 * 
 * @author Rony
 * @version 1
 */
@Remote
public interface ClassificacaoLinearService {
	
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

}
