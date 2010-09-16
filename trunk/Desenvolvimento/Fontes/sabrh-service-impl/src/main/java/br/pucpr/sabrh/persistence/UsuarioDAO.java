/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Usuario;

/**
 * The Interface UsuarioDAO.
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
	Usuario autenticar(Usuario usuario) throws Exception;

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
	Usuario inserir(Usuario usuario) throws Exception;

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
