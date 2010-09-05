/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.services;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Usuario;

/**
 * The Interface UsuarioService.
 */
@Remote
public interface UsuarioService {

	/**
	 * Autenticar.
	 * 
	 * @param usuario
	 *            the usuario
	 * @return true, if successful
	 */
	public Usuario autenticar(Usuario usuario);

	public Usuario buscarUsuario(Usuario usuario);

	public Usuario inserirUsuario(Usuario usuario);

	public boolean excluirUsuario(Usuario usuario);

	public Usuario alterarUsuario(Usuario usuario);

	public List<Usuario> listarUsuarios();

}
