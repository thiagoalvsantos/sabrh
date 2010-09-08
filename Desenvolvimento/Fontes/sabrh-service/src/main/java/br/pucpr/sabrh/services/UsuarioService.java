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
	 * Buscar usuario.
	 * 
	 * @param usuario
	 *            - usuario
	 * @return usuario
	 */
	public Usuario buscarUsuario(Usuario usuario);

	/**
	 * Inserir usuario.
	 * 
	 * @param usuario
	 *            - usuario
	 * @return usuario
	 */
	public Usuario inserirUsuario(Usuario usuario) throws Exception;

	/**
	 * Excluir usuario.
	 * 
	 * @param usuario
	 *            - usuario.
	 * @return verdadeiro, se bem sucedido.
	 */
	public boolean excluirUsuario(Usuario usuario);

	/**
	 * Alterar usuario.
	 * 
	 * @param usuario
	 *            - usuario
	 * @return usuario
	 */
	public Usuario alterarUsuario(Usuario usuario);

	/**
	 * Listar usuarios.
	 * 
	 * @return list
	 * @throws Exception
	 *             the exception
	 */
	public List<Usuario> listarUsuarios() throws Exception;

}
