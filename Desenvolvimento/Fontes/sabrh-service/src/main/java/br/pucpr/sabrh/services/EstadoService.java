package br.pucpr.sabrh.services;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Estado;

@Remote
public interface EstadoService {

	List<Estado> listarEstados();
}
