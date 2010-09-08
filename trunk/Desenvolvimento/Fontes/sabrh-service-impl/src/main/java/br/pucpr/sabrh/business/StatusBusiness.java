package br.pucpr.sabrh.business;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.Stateless;

import org.apache.commons.collections.CollectionUtils;

import br.pucpr.sabrh.entity.TipoStatus;
import br.pucpr.sabrh.services.StatusService;

@Stateless(name = "StatusService")
public class StatusBusiness implements StatusService {

	@Override
	public List<TipoStatus> listarStatus() {
		ArrayList<TipoStatus> tipoStatus = new ArrayList<TipoStatus>();
		CollectionUtils.addAll(tipoStatus, TipoStatus.values());
		return tipoStatus;
	}

}
