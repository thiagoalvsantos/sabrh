/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.business;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;

import br.pucpr.sabrh.entity.Estado;
import br.pucpr.sabrh.entity.Municipio;
import br.pucpr.sabrh.persistence.MunicipioDAO;
import br.pucpr.sabrh.services.MunicipioService;

/**
 * Implementação abstrata da interface de fachada MunicipioService.
 * 
 * @author Thiago
 * @version 1
 * @see MunicipioService
 */
@Stateless(name = "MunicipioService")
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class MunicipioBusiness implements MunicipioService {

	/** O atributo dao. */
	@EJB
	private MunicipioDAO dao;

	/**
	 * Get dao.
	 * 
	 * @return the dao
	 * @see MunicipioBusiness#dao.
	 */
	public MunicipioDAO getDao() {
		return dao;
	}

	/**
	 * Set dao.
	 * 
	 * @param dao
	 *            - dao.
	 * @see MunicipioBusiness#dao.
	 */
	public void setDao(MunicipioDAO dao) {
		this.dao = dao;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see br.pucpr.sabrh.services.MunicipioService#listarMunicipios()
	 */
	@Override
	public List<Municipio> listarMunicipios() {
		return dao.listarMunicipios();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.services.MunicipioService#listarMunicipios(br.pucpr.sabrh
	 * .entity.Estado)
	 */
	@Override
	public List<Municipio> listarMunicipios(Estado estado) {
		return dao.listarMunicipios(estado);
	}

}
