/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Usuario;

/**
 * Interface UsuarioDAO.
 */
@Remote
public interface UsuarioDAO {

	/**
	 * Autenticar.
	 * 
	 * @param usuario
	 *            the usuario
	 * @return true, if successful
	 */
	Usuario autenticar(Usuario usuario);

	/**
	 * Listar.
	 * 
	 * @return list
	 * @throws Exception
	 *             the exception
	 */
	List<Usuario> listar() throws Exception;

	/**
	 * Inserir.
	 * 
	 * @param usuario
	 *            - usuario
	 * @return usuario
	 * @throws Exception
	 *             the exception
	 */
	Usuario salvar(Usuario usuario);

	/**
	 * Pesquisar.
	 * 
	 * @param usuario
	 *            - usuario
	 * @return list
	 * @throws Exception
	 *             the exception
	 */
	List<Usuario> pesquisar(Usuario usuario) throws Exception;

}
