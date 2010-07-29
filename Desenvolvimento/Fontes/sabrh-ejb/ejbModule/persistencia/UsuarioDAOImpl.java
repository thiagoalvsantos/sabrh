/**
 * 
 */
package persistencia;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import entidades.Usuario;

/**
 * @author Thiago
 * 
 */
@Stateless(name = "UsuarioDAO")
public class UsuarioDAOImpl implements UsuarioDAO {

	@PersistenceContext(unitName = "SABRH")
	private EntityManager em;

	/*
	 * (non-Javadoc)
	 * 
	 * @see persistencia.UsuarioDAO#pesquisarUsuario(entidades.Usuario)
	 */
	@Override
	public Usuario pesquisar(Usuario usuario) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Boolean autenticar(Usuario usuario) {
		Usuario result = (Usuario) em.createQuery(
				"select u from USUARIO u where u.TX_LOGIN = "
						+ usuario.getLogin() + " AND u.TX_SENHA = "
						+ usuario.getSenha()).getSingleResult();

		if (result != null) {
			return true;
		}
		
		return false;

	}

	public EntityManager getEm() {
		return em;
	}

	public void setEm(EntityManager em) {
		this.em = em;
	}
	

}
