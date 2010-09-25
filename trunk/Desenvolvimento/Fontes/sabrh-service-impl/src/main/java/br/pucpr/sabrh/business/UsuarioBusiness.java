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
	 * br.pucpr.sabrh.services.UsuarioService#inserirUsuario(br.pucpr.sabrh.
	 * entity.Usuario)
	 */
	@Override
	public Usuario inserir(Usuario usuario) throws Exception {

		return usuarioDAO.salvar(usuario);

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see br.pucpr.sabrh.services.UsuarioService#listarUsuarios()
	 */
	@Override
	public List<Usuario> listar() throws Exception {
		return usuarioDAO.listar();
	}

	@Override
	public List<Usuario> pesquisar(Usuario usuario) throws Exception {

		return usuarioDAO.pesquisar(usuario);
	}

}