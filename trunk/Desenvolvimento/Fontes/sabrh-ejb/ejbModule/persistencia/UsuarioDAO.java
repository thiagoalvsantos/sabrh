package persistencia;

import javax.ejb.Remote;

import entidades.Usuario;

@Remote
public interface UsuarioDAO {
	
	public Usuario pesquisar(Usuario usuario);
	public Boolean autenticar(Usuario usuario);

}
