package br.pucpr.sabrh.business;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;

import br.pucpr.sabrh.entity.Estado;
import br.pucpr.sabrh.persistence.EstadoDAO;
import br.pucpr.sabrh.services.EstadoService;

@Stateless(name = "EstadoService")
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class EstadoBusiness implements EstadoService {

	@EJB
	private EstadoDAO dao;

	public EstadoDAO getDao() {
		return dao;
	}

	public void setDao(EstadoDAO dao) {
		this.dao = dao;
	}

	@Override
	public List<Estado> listarEstados() {

		return dao.listarEstado();
	}

}
