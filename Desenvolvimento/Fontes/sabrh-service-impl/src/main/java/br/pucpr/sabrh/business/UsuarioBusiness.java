/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.business;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;

import br.pucpr.sabrh.entity.Usuario;
import br.pucpr.sabrh.persistence.UsuarioDAO;
import br.pucpr.sabrh.services.UsuarioService;

/**
 * Implementação abstrata da interface de fachada UsuarioService.
 * 
 * @author Thiago
 * @version 1
 * @see UsuarioService
 */
@Stateless(name = "UsuarioService")
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class UsuarioBusiness implements UsuarioService {

	/** O atributo usuario dao. */
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
	@Override
	public Usuario autenticar(Usuario usuario) throws Exception {

		return usuarioDAO.autenticar(usuario);

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.services.UsuarioService#buscarUsuario(br.pucpr.sabrh.entity
	 * .Usuario)
	 */
	@Override
	public Usuario buscarUsuario(Usuario usuario) {
		// TODO Implementar busca de usuário
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.services.UsuarioService#inserirUsuario(br.pucpr.sabrh.
	 * entity.Usuario)
	 */
	@Override
	public Usuario inserirUsuario(Usuario usuario) throws Exception {

		usuarioDAO.inserir(usuario);
		return null;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.services.UsuarioService#excluirUsuario(br.pucpr.sabrh.
	 * entity.Usuario)
	 */
	@Override
	public boolean excluirUsuario(Usuario usuario) {
		// TODO Implementar exclusão de usuário
		return true;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.services.UsuarioService#alterarUsuario(br.pucpr.sabrh.
	 * entity.Usuario)
	 */
	@Override
	public Usuario alterarUsuario(Usuario usuario) {
		// TODO Implementar alteração de usuário
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see br.pucpr.sabrh.services.UsuarioService#listarUsuarios()
	 */
	@Override
	public List<Usuario> listarUsuarios() throws Exception {
		return usuarioDAO.listar();
	}

}
