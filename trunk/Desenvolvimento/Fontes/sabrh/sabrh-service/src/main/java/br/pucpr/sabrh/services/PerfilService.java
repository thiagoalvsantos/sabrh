/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.services;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.TipoPerfil;

/**
 * Interface de serviço da camada core relacionado ao componente Perfil.
 * 
 * @author Thiago
 * @version 1
 */
@Remote
public interface PerfilService {

	/**
	 * Listar perfil.
	 * 
	 * @return list
	 */
	List<TipoPerfil> listarPerfil();
}
