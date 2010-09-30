/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence.impl;

import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Example;

import br.pucpr.sabrh.entity.Propriedade;
import br.pucpr.sabrh.persistence.PropriedadeDAO;

/**
 * Class PropriedadeDAOImpl.
 */
@Stateless
public class PropriedadeDAOImpl implements PropriedadeDAO {

	/** O atributo entity manager. */
	@PersistenceContext(unitName = "SABRH")
	private EntityManager entityManager;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.persistence.PropriedadeDAO#listar(br.pucpr.sabrh.entity
	 * .Propriedade)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Propriedade> listar(Propriedade propriedade) {
		Session s = (Session) entityManager.getDelegate();
		Criteria c = s.createCriteria(Propriedade.class);
		c.add(Example.create(propriedade).enableLike().ignoreCase());
		List<Propriedade> result = c.list();
		return result;
	}

	
	/* (non-Javadoc)
	 * @see br.pucpr.sabrh.persistence.PropriedadeDAO#salvar(br.pucpr.sabrh.entity.Propriedade)
	 */
	@Override
	public Propriedade salvar(Propriedade propriedade) {
		return entityManager.merge(propriedade);

	}

	/**
	 * Get entity manager.
	 * 
	 * @return the entity manager
	 * @see PropriedadeDAOImpl#entityManager.
	 */
	public EntityManager getEntityManager() {
		return entityManager;
	}

	/**
	 * Set entity manager.
	 * 
	 * @param entityManager
	 *            - entity manager.
	 * @see PropriedadeDAOImpl#entityManager.
	 */
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

}
