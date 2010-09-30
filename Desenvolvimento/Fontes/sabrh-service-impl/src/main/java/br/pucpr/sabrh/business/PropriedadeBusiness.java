/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.business;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;

import br.pucpr.sabrh.entity.Propriedade;
import br.pucpr.sabrh.persistence.PropriedadeDAO;
import br.pucpr.sabrh.services.PropriedadeService;

/**
 * Implementação abstrata da interface de fachada PropriedadeService.
 * 
 * @author Thiago
 * @version 1
 * @see PropriedadeService
 */
@Stateless(name = "PropriedadeService")
public class PropriedadeBusiness implements PropriedadeService {

	/** O atributo propriedade dao. */
	@EJB
	PropriedadeDAO propriedadeDAO;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.services.PropriedadeService#listar(br.pucpr.sabrh.entity
	 * .Propriedade)
	 */
	@Override
	public List<Propriedade> pesquisar(Propriedade propriedade) {

		return propriedadeDAO.listar(propriedade);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.services.PropriedadeService#salvar(br.pucpr.sabrh.entity
	 * .Propriedade)
	 */
	@Override
	public Propriedade salvar(Propriedade propriedade) {

		return propriedadeDAO.salvar(propriedade);
	}

}
