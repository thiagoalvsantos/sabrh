/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence;

import javax.ejb.Remote;
import javax.persistence.NoResultException;

import br.pucpr.sabrh.common.persistence.CrudDAO;
import br.pucpr.sabrh.entity.Usuario;

/**
 * The Interface UsuarioDAO.
 */
@Remote(UsuarioDAO.class)
public interface UsuarioDAO {

	CrudDAO<Usuario, Long> getUsuarioDAO();

	/**
	 * Autenticar.
	 * 
	 * @param usuario
	 *            the usuario
	 * @return true, if successful
	 */
	Usuario autenticar(Usuario usuario) throws NoResultException;

}
