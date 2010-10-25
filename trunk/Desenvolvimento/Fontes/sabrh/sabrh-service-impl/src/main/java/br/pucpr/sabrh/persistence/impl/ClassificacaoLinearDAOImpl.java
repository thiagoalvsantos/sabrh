/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence.impl;

import java.util.List;

import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.ClassificacaoLinear;
import br.pucpr.sabrh.persistence.ClassificacaoLinearDAO;

/**
 * Class ClassificacaoLinearDAOImpl.
 */
@Stateless
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class ClassificacaoLinearDAOImpl implements ClassificacaoLinearDAO {

	/** O atributo entity manager. */
	@PersistenceContext(unitName = "SABRH")
	private EntityManager entityManager;

	/**
	 * Get entity manager.
	 * 
	 * @return the entity manager
	 * @see ClassificacaoLinearDAOImpl#entityManager.
	 */
	public EntityManager getEntityManager() {
		return entityManager;
	}

	/**
	 * Set entity manager.
	 * 
	 * @param entityManager
	 *            - entity manager.
	 * @see ClassificacaoLinearDAOImpl#entityManager.
	 */
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.persistence.ClassificacaoLinearDAO#pesquisar(br.pucpr.
	 * sabrh.entity.Animal)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<ClassificacaoLinear> pesquisar(Animal animal) {
		Session s = (Session) entityManager.getDelegate();
		Criteria c = s.createCriteria(ClassificacaoLinear.class, "classlin");
		c.add(Restrictions.eq("animal", animal));

		c.addOrder(Order.asc("lactacao"));
		List<ClassificacaoLinear> result = c.list();
		return result;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.persistence.ClassificacaoLinearDAO#salvar(br.pucpr.sabrh
	 * .entity.ClassificacaoLinear)
	 */
	@Override
	public ClassificacaoLinear salvar(ClassificacaoLinear classificacaoLinear) {

		ClassificacaoLinear result = null;
		result = entityManager.merge(classificacaoLinear);
		entityManager.flush();

		return result;
	}

	@Override
	public void excluir(ClassificacaoLinear classificacaoLinear) {
		classificacaoLinear = entityManager.merge(classificacaoLinear);
		entityManager.remove(classificacaoLinear);
		entityManager.flush();
	}

}
