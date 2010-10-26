/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.business;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;

import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.FiltroAcasalamento;
import br.pucpr.sabrh.entity.ProvaTouro;
import br.pucpr.sabrh.persistence.ProvaTouroDAO;
import br.pucpr.sabrh.services.AnimalService;
import br.pucpr.sabrh.services.ProvaTouroService;

/**
 * Implementação abstrata da interface de fachada ProvaTouroService.
 * 
 * @author Rony
 * @version 1
 * @see ProvaTouroService
 */
@Stateless(name = "ProvaTouroService")
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class ProvaTouroBusiness implements ProvaTouroService {

	/** O atributo dao. */
	@EJB
	private ProvaTouroDAO dao;

	/** O atributo dao. */
	@EJB
	private AnimalService animalService;

	/**
	 * Get dao.
	 * 
	 * @return the dao
	 * @see ProvaTouroBusiness#dao.
	 */
	public ProvaTouroDAO getDao() {
		return dao;
	}

	/**
	 * Set dao.
	 * 
	 * @param dao
	 *            - dao.
	 * @see ProvaTouroBusiness#dao.
	 */
	public void setDao(ProvaTouroDAO dao) {
		this.dao = dao;
	}

	/**
	 * Get animal service.
	 * 
	 * @return the animal service
	 * @see ProvaTouroBusiness#animalService.
	 */
	public AnimalService getAnimalService() {
		return animalService;
	}

	/**
	 * Set animal service.
	 * 
	 * @param animalService
	 *            - animal service.
	 * @see ProvaTouroBusiness#animalService.
	 */
	public void setAnimalService(AnimalService animalService) {
		this.animalService = animalService;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.services.ProvaTouroService#pesquisar(br.pucpr.sabrh.entity
	 * .Animal)
	 */
	@Override
	public List<ProvaTouro> pesquisar(Animal animal) {
		return dao.pesquisar(animal);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.services.ProvaTouroService#salvar(br.pucpr.sabrh.entity
	 * .ProvaTouro)
	 */
	@Override
	public ProvaTouro salvar(ProvaTouro provaTouro) {
		return dao.salvar(provaTouro);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.services.ProvaTouroService#excluir(br.pucpr.sabrh.entity
	 * .ProvaTouro)
	 */
	@Override
	public void excluir(ProvaTouro provaTouro) {
		dao.excluir(provaTouro);

	}

	@Override
	public List<ProvaTouro> pesquisarReprodutor(
			FiltroAcasalamento filtroAcasalamento) {
		List<ProvaTouro> listaProvaTouro = dao
				.pesquisarReprodutor(filtroAcasalamento);
		List<ProvaTouro> listaResultado = new ArrayList<ProvaTouro>();
		List<ProvaTouro> listaProvaTouroFiltrada = new ArrayList<ProvaTouro>();
		boolean existe=false;
		boolean removido=false;
		
		for (ProvaTouro provaTouro : listaProvaTouro) {
			if (listaProvaTouroFiltrada.isEmpty()){
				listaProvaTouroFiltrada.add(provaTouro);
			}else{
				existe=false;
				removido=false;
				for (ProvaTouro provaTouroFiltrada : listaProvaTouroFiltrada) {
					if (provaTouro.getAnimal().getRegistro().equals(provaTouroFiltrada.getAnimal().getRegistro())){
						existe=true;
						if (provaTouro.getDataUltimaAtualizacao().after(provaTouroFiltrada.getDataUltimaAtualizacao())){
							listaProvaTouroFiltrada.remove(provaTouroFiltrada);
							removido=true;
							break;
						} else {
							if (provaTouro.getCodigo() > provaTouroFiltrada.getCodigo() && provaTouro.getDataUltimaAtualizacao().equals(provaTouroFiltrada.getDataUltimaAtualizacao())){
								listaProvaTouroFiltrada.remove(provaTouroFiltrada);
								removido=true;
								break;
							}
						}
					}
				}
				if ((existe && removido) || !existe)
					listaProvaTouroFiltrada.add(provaTouro);
			}
		}
		
		int contador = 0;
		if (filtroAcasalamento.getFemea() != null) {
			for (ProvaTouro provaTouro : listaProvaTouroFiltrada) {
				// verifica consanguinidade do animal
				if (animalService.verificarConsanguinidade(
						filtroAcasalamento.getFemea(), provaTouro.getAnimal())){
					listaResultado.add(provaTouro);
					contador++;
				}
				if(contador == 3)
					break;
			}
		} else {
			listaResultado = listaProvaTouroFiltrada;
		}
		return listaResultado;
	}

}
