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
import br.pucpr.sabrh.entity.EventoAcasalamento;
import br.pucpr.sabrh.persistence.AcasalamentoDAO;
import br.pucpr.sabrh.persistence.EventoAcasalamentoDAO;
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

	/** O atributo dao acasalamento dao. */
	@EJB
	private AcasalamentoDAO daoAcasalamentoDAO;

	/** O atributo evento acasalamento dao. */
	@EJB
	private EventoAcasalamentoDAO eventoAcasalamentoDAO;

	/**
	 * Get evento acasalamento dao.
	 * 
	 * @return the evento acasalamento dao
	 * @see AcasalamentoBusiness#eventoAcasalamentoDAO.
	 */
	public EventoAcasalamentoDAO getEventoAcasalamentoDAO() {
		return eventoAcasalamentoDAO;
	}

	/**
	 * Set evento acasalamento dao.
	 * 
	 * @param eventoAcasalamentoDAO
	 *            - evento acasalamento dao.
	 * @see AcasalamentoBusiness#eventoAcasalamentoDAO.
	 */
	public void setEventoAcasalamentoDAO(
			EventoAcasalamentoDAO eventoAcasalamentoDAO) {
		this.eventoAcasalamentoDAO = eventoAcasalamentoDAO;
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
		return daoAcasalamentoDAO.salvar(acasalamento);
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
		return daoAcasalamentoDAO.pesquisar(acasalamento, dataInicio, dataFim);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.services.AcasalamentoService#salvarEvento(br.pucpr.sabrh
	 * .entity.EventoAcasalamento)
	 */
	@Override
	public EventoAcasalamento salvarEvento(EventoAcasalamento eventoAcasalamento) {
		return eventoAcasalamentoDAO.salvar(eventoAcasalamento);
	}

	/**
	 * Set dao acasalamento dao.
	 * 
	 * @param daoAcasalamentoDAO
	 *            - dao acasalamento dao.
	 * @see AcasalamentoBusiness#daoAcasalamentoDAO.
	 */
	public void setDaoAcasalamentoDAO(AcasalamentoDAO daoAcasalamentoDAO) {
		this.daoAcasalamentoDAO = daoAcasalamentoDAO;
	}

	/**
	 * Get dao acasalamento dao.
	 * 
	 * @return the dao acasalamento dao
	 * @see AcasalamentoBusiness#daoAcasalamentoDAO.
	 */
	public AcasalamentoDAO getDaoAcasalamentoDAO() {
		return daoAcasalamentoDAO;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.services.AcasalamentoService#pesquisarEvento(br.pucpr.
	 * sabrh.entity.Acasalamento)
	 */
	@Override
	public List<EventoAcasalamento> pesquisarEvento(Acasalamento acasalamento) {
		return eventoAcasalamentoDAO.pesquisar(acasalamento);
	}

}
