/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.services;

import java.util.Date;
import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Acasalamento;

/**
 * Interface de serviço da camada core relacionado ao componente Acasalamento.
 * 
 * @author Thiago
 * @version 1
 */
@Remote
public interface AcasalamentoService {

	/**
	 * Salvar.
	 * 
	 * @param acasalamento
	 *            - acasalamento
	 * @return acasalamento
	 */
	Acasalamento salvar(Acasalamento acasalamento);
	
	/**
	 * Pesquisar.
	 * 
	 * @param acasalamento
	 *            - acasalamento
	 * @param dataInicio
	 *            - data inicio
	 * @param dataFim
	 *            - data fim
	 * @return list
	 */
	List<Acasalamento> pesquisar(Acasalamento acasalamento,Date dataInicio,Date dataFim);
}
