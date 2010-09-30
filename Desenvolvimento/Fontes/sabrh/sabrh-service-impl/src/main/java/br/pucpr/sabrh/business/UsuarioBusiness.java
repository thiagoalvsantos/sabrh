/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.business;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;

import br.pucpr.br.entity.Usuario;
import br.pucpr.sabrh.persistence.UsuarioDAO;
import br.pucpr.sabrh.services.UsuarioService;

/**
 * Implementacao abstrata da interface de fachada UsuarioService.
 * 
 * @author Thiago
 * @version 1
 * @see UsuarioService
 */
@Stateless(name = "UsuarioService")
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class UsuarioBusiness implements UsuarioService {

	@EJB
	private UsuarioDAO usuarioDAO;

	/**
	 * @return the usuarioDAO
	 */
	public UsuarioDAO getUsuarioDAO() {
		return usuarioDAO;
	}

	/**
	 * @param usuarioDAO
	 *            the usuarioDAO to set
	 */
	public void setUsuarioDAO(UsuarioDAO usuarioDAO) {
		this.usuarioDAO = usuarioDAO;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.services.UsuarioService#autenticar(br.pucpr.br.entity.
	 * Usuario)
	 */
	public Usuario autenticar(Usuario usuario) {

		return usuarioDAO.autenticar(usuario);
	}

}
