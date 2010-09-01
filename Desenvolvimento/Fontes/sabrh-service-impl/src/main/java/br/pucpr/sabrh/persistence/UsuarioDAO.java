/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence;

import javax.ejb.Remote;

import br.pucpr.br.entity.Usuario;

/**
 * The Interface UsuarioDAO.
 */
@Remote(UsuarioDAO.class)
public interface UsuarioDAO {
	
	/**
	 * Autenticar.
	 * 
	 * @param usuario
	 *            the usuario
	 * @return true, if successful
	 */
	Usuario autenticar(Usuario usuario);

}
