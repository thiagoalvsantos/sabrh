/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence.impl;

import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import br.pucpr.sabrh.entity.Usuario;
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.persistence.UsuarioDAO#autenticar(br.pucpr.br.entity.Usuario
	 * )
	 */
	@Override
	public Usuario autenticar(Usuario usuario) throws NoResultException {

		Session s = (Session) entityManager.getDelegate();
		Criteria c = s.createCriteria(Usuario.class);
		c.add(Example.create(usuario));

		try {
			Usuario result = (Usuario) c.uniqueResult();

			return result;
		} catch (NoResultException e) {
			throw new NoResultException(
					"Erro ao autenticar usuário. \nUsuário não autorizado");
		} catch (Exception e) {
			return null;
		}

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Usuario> listar() throws Exception {
		Session session = (Session) entityManager.getDelegate();
		return session.createCriteria(Usuario.class).list();

	}

	@Override
	public Usuario inserir(Usuario usuario) throws Exception {

		return entityManager.merge(usuario);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Usuario> pesquisar(Usuario usuario) throws Exception {
		Session s = (Session) entityManager.getDelegate();
		Criteria c = s.createCriteria(Usuario.class);
		c.add(Example.create(usuario).enableLike().ignoreCase());
		List<Usuario> result = c.list();
		return result;

	}

}
