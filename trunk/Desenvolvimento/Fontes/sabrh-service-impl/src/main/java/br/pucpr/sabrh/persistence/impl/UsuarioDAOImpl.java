/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence.impl;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import br.pucpr.sabrh.common.persistence.CrudDAO;
import br.pucpr.sabrh.common.persistence.impl.CrudDAOImpl;
import br.pucpr.sabrh.entity.Usuario;
import br.pucpr.sabrh.entity.UsuarioImpl;
import br.pucpr.sabrh.persistence.UsuarioDAO;

/**
 * Class UsuarioDAOImpl.
 */
@Stateless
public class UsuarioDAOImpl implements UsuarioDAO {

	/** O atributo entity manager. */
	@PersistenceContext(unitName = "SABRH")
	private EntityManager entityManager;

	/**
	 * Get entity manager.
	 * 
	 * @return the entity manager
	 * @see UsuarioDAOImpl#entityManager.
	 */
	public EntityManager getEntityManager() {
		return entityManager;
	}

	/**
	 * Set entity manager.
	 * 
	 * @param entityManager
	 *            - entity manager.
	 * @see UsuarioDAOImpl#entityManager.
	 */
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	public CrudDAO<Usuario, Long> getUsuarioDAO() {
		return new CrudDAOImpl<Usuario, Long>(UsuarioImpl.class, getEntityManager());
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.persistence.UsuarioDAO#autenticar(br.pucpr.br.entity.Usuario
	 * )
	 */
	@Override
	public Usuario autenticar(Usuario usuario) throws NoResultException {

		Query q = entityManager
				.createQuery("SELECT u FROM Usuario u WHERE u.login = ?1 AND u.senha = ?2");
		q.setParameter(1, usuario.getLogin());
		q.setParameter(2, usuario.getSenha());
		try {
			Usuario result = (Usuario) q.getSingleResult();

			return result;
		} catch (NoResultException e) {
			throw new NoResultException(
					"Erro ao autenticar usuário. \nUsuário não autorizado");
		} catch (Exception e) {
			return null;
		}
	}

}
