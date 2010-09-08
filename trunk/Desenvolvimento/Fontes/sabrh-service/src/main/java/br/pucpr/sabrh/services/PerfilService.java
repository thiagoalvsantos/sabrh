package br.pucpr.sabrh.services;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.TipoPerfil;

@Remote
public interface PerfilService {

	List<TipoPerfil> listarPerfil();
}
