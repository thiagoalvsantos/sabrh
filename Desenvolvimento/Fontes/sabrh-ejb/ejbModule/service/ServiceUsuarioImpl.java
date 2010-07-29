package service;

import javax.ejb.EJB;
import javax.ejb.Stateless;

import persistencia.UsuarioDAO;
import entidades.Usuario;

@Stateless(name = "ServiceUsuario")
public class ServiceUsuarioImpl implements ServiceUsuario {

	@EJB(name = "UsuarioDAO")
	private UsuarioDAO dao;

	@Override
	public boolean Autenticar(Usuario usuario) {

		return dao.autenticar(usuario);

	}

	public UsuarioDAO getDao() {
		return dao;
	}

	public void setDao(UsuarioDAO dao) {
		this.dao = dao;
	}
	

}
