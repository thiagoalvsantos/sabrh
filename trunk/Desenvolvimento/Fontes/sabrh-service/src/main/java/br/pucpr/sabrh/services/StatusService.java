package br.pucpr.sabrh.services;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.TipoStatus;

@Remote
public interface StatusService {

	List<TipoStatus> listarStatus();
}
