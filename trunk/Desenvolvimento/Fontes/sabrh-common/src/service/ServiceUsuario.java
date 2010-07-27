package service;

import javax.ejb.Remote;

import entidades.Usuario;

@Remote
public interface ServiceUsuario {
	
	public boolean Autenticar(Usuario usuario);

}
