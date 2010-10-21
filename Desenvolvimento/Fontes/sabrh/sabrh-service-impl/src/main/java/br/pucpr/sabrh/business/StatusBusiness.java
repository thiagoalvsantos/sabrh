/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.business;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.Stateless;

import org.apache.commons.collections.CollectionUtils;

import br.pucpr.sabrh.entity.TipoStatus;
import br.pucpr.sabrh.entity.TipoStatusFemea;
import br.pucpr.sabrh.services.StatusService;

/**
 * Implementação abstrata da interface de fachada StatusService.
 * 
 * @author Rony
 * @version 1
 * @see StatusService
 */
@Stateless(name = "StatusService")
public class StatusBusiness implements StatusService {

	/* (non-Javadoc)
	 * @see br.pucpr.sabrh.services.StatusService#listarStatusUsuario()
	 */
	@Override
	public List<TipoStatus> listarStatusUsuario() {
		ArrayList<TipoStatus> tipoStatus = new ArrayList<TipoStatus>();
		CollectionUtils.addAll(tipoStatus, TipoStatus.values());
		return tipoStatus;
	}

	/* (non-Javadoc)
	 * @see br.pucpr.sabrh.services.StatusService#listarStatusFemea()
	 */
	@Override
	public List<TipoStatusFemea> listarStatusFemea() {
		ArrayList<TipoStatusFemea> tipoStatusFemea = new ArrayList<TipoStatusFemea>();
		CollectionUtils.addAll(tipoStatusFemea, TipoStatusFemea.values());
		return tipoStatusFemea;
	}

}
