/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.services;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Usuario;

/**
 * Interface de serviço da camada core relacionado ao componente Usuario.
 * 
 * @author Thiago
 * @version 1
 */
@Remote
public interface UsuarioService {

	/**
	 * Autenticar.
	 * 
	 * @param usuario
	 *            - usuario
	 * @return usuario
	 * @throws Exception
	 *             the exception
	 */
	public Usuario autenticar(Usuario usuario) throws Exception;

	/**
	 * Inserir usuario.
	 * 
	 * @param usuario
	 *            - usuario
	 * @return usuario
	 */
	public Usuario inserirUsuario(Usuario usuario) throws Exception;

	/**
	 * Listar usuarios.
	 * 
	 * @return list
	 * @throws Exception
	 *             the exception
	 */
	public List<Usuario> listarUsuarios() throws Exception;

	/**
	 * Pesquisar usuarios.
	 * 
	 * @param usuario
	 *            - usuario
	 * @return list
	 * @throws Exception
	 *             the exception
	 */
	public List<Usuario> pesquisar(Usuario usuario) throws Exception;

}
