/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.services;

import javax.ejb.Remote;

import br.pucpr.br.entity.Usuario;

/**
 * The Interface UsuarioService.
 */
@Remote
public interface UsuarioService {

	/**
	 * Autenticar.
	 * 
	 * @param usuario
	 *            the usuario
	 * @return true, if successful
	 */
	public Usuario autenticar(Usuario usuario);

}
