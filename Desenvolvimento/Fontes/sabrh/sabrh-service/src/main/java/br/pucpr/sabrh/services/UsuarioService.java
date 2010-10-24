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
	public Usuario inserir(Usuario usuario) throws Exception;

	/**
	 * Criptografar senha do usuario.
	 * 
	 * @param usuario
	 *            - usuario
	 * @return usuario
	 */
	public String criptografar(String senha1, String senha2) throws Exception;

	/**
	 * Listar usuarios.
	 * 
	 * @return list
	 * @throws Exception
	 *             the exception
	 */
	public List<Usuario> listar() throws Exception;

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

	/**
	 * Pesquisar cpf.
	 * 
	 * @param cpf
	 *            - cpf.
	 * @return verdadeiro, se bem sucedido.
	 * @throws Exception
	 *             the exception
	 */
	public boolean pesquisarCPF(String cpf) throws Exception;

	/**
	 * Pesquisar login.
	 * 
	 * @param login
	 *            - login.
	 * @return verdadeiro, se bem sucedido.
	 * @throws Exception
	 *             the exception
	 */
	public boolean pesquisarLogin(String login) throws Exception;

}
