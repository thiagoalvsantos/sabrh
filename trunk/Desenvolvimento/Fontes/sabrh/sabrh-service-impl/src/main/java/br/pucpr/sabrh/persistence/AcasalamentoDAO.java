/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence;

import java.util.Date;
import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Acasalamento;

/**
 * Interface AcasalamentoDAO.
 */
@Remote
public interface AcasalamentoDAO {

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
	public List<Acasalamento> pesquisar(Acasalamento acasalamento,
			Date dataInicio, Date dataFim);
	
	/**
	 * Salvar.
	 * 
	 * @param acasalamento
	 *            - acasalamento
	 * @return acasalamento
	 */
	public Acasalamento salvar(Acasalamento acasalamento);
}
