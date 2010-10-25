/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.business;

import java.util.Date;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;

import br.pucpr.sabrh.entity.Acasalamento;
import br.pucpr.sabrh.persistence.AcasalamentoDAO;
import br.pucpr.sabrh.services.AcasalamentoService;

/**
 * Implementação abstrata da interface de fachada AcasalamentoService.
 * 
 * @author Thiago
 * @version 1
 * @see AcasalamentoService
 */
@Stateless(name = "AcasalamentoService")
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class AcasalamentoBusiness implements AcasalamentoService {

	/** O atributo dao. */
	@EJB
	private AcasalamentoDAO dao;

	/**
	 * Get dao.
	 * 
	 * @return the dao
	 * @see AcasalamentoBusiness#dao.
	 */
	public AcasalamentoDAO getDao() {
		return dao;
	}

	/**
	 * Set dao.
	 * 
	 * @param dao
	 *            - dao.
	 * @see AcasalamentoBusiness#dao.
	 */
	public void setDao(AcasalamentoDAO dao) {
		this.dao = dao;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.services.AcasalamentoService#salvar(br.pucpr.sabrh.entity
	 * .Acasalamento)
	 */
	@Override
	public Acasalamento salvar(Acasalamento acasalamento) {
		// TODO Auto-generated method stub
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.services.AcasalamentoService#pesquisar(br.pucpr.sabrh.
	 * entity.Acasalamento, java.util.Date, java.util.Date)
	 */
	@Override
	public List<Acasalamento> pesquisar(Acasalamento acasalamento,
			Date dataInicio, Date dataFim) {
		return dao.pesquisar(acasalamento, dataInicio, dataFim);
	}

}
