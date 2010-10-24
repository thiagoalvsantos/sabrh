/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence.impl;

import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.exception.ConstraintViolationException;

import br.pucpr.sabrh.entity.Estado;
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see br.pucpr.sabrh.persistence.UsuarioDAO#listar()
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Usuario> listar() throws Exception {
		Session session = (Session) entityManager.getDelegate();
		return session.createCriteria(Usuario.class).list();

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.persistence.UsuarioDAO#salvar(br.pucpr.sabrh.entity.Usuario
	 * )
	 */
	@Override
	public Usuario salvar(Usuario usuario) {
		Usuario result = null;
		try {
			result = entityManager.merge(usuario);
			entityManager.flush();
		} catch (PersistenceException e) {

			if (ConstraintViolationException.class.isInstance(e.getCause())) {
				throw new RuntimeException(
						"Erro ao salvar.\n Dados já está cadastrado para um outro usuário.");
			} else {
				if (EntityExistsException.class.isInstance(e.getCause())) {
					throw new RuntimeException(
							"Erro ao salvar.\n Usuário já cadastrado.");
				}
			}

		} catch (Exception e) {
			throw new RuntimeException("Erro ao salvar usuário.");
		}
		return result;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.persistence.UsuarioDAO#pesquisar(br.pucpr.sabrh.entity
	 * .Usuario)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Usuario> pesquisar(Usuario usuario) throws Exception {

		Session s = (Session) entityManager.getDelegate();
		Criteria c = s.createCriteria(Usuario.class, "usu");
		c.createCriteria("municipio", "mun");
		c.add(Example.create(usuario).enableLike(MatchMode.ANYWHERE)
				.ignoreCase());
		if (usuario.getMunicipio() != null) {
			if (usuario.getMunicipio().getCodigo() != 0) {
				c.add(Restrictions.eq("municipio", usuario.getMunicipio()));
			} else {
				Criteria q = s.createCriteria(Estado.class);
				q.add(Example.create(usuario.getMunicipio().getEstado()));
				c.add(Restrictions.eq("mun.estado", q.uniqueResult()));
			}

		}
		c.add(Restrictions.ne("codigo", Long.parseLong("0")));
		c.addOrder(Order.asc("nome"));
		List<Usuario> result = c.list();
		return result;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see br.pucpr.sabrh.persistence.UsuarioDAO#pesquisarCPF(java.lang.String)
	 */
	@Override
	public boolean pesquisarCPF(String cpf) throws Exception {
		Session s = (Session) entityManager.getDelegate();
		Criteria c = s.createCriteria(Usuario.class);
		c.add(Restrictions.eq("cpf", cpf));
		Usuario usuario = (Usuario) c.uniqueResult();
		if (usuario != null)
			return true;
		else
			return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.persistence.UsuarioDAO#pesquisarLogin(java.lang.String)
	 */
	@Override
	public boolean pesquisarLogin(String login) throws Exception {
		Session s = (Session) entityManager.getDelegate();
		Criteria c = s.createCriteria(Usuario.class);
		c.add(Restrictions.eq("login", login));
		Usuario usuario = (Usuario) c.uniqueResult();
		if (usuario != null)
			return true;
		else
			return false;
	}

}
