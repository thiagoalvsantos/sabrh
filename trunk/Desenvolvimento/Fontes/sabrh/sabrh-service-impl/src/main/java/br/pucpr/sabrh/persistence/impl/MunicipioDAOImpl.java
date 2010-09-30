package br.pucpr.sabrh.persistence.impl;

import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import br.pucpr.sabrh.entity.Estado;
import br.pucpr.sabrh.entity.Municipio;
import br.pucpr.sabrh.persistence.MunicipioDAO;

@Stateless
public class MunicipioDAOImpl implements MunicipioDAO {

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

	@SuppressWarnings("unchecked")
	@Override
	public List<Municipio> listarMunicipios() {

		Session session = (Session) entityManager.getDelegate();
		return session.createCriteria(Municipio.class)
				.addOrder(Order.asc("descricao")).list();

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Municipio> listarMunicipios(Estado estado) {
		Session session = (Session) entityManager.getDelegate();
		return session.createCriteria(Municipio.class)
				.add(Restrictions.eq("estado", estado))
				.addOrder(Order.asc("descricao")).list();
	}

}
