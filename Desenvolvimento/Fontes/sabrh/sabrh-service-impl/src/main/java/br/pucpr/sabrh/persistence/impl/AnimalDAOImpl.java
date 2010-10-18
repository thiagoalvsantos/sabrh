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
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.Usuario;
import br.pucpr.sabrh.persistence.AnimalDAO;

/**
 * Class AnimalDAOImpl.
 */
@Stateless
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class AnimalDAOImpl implements AnimalDAO {

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
	 * br.pucpr.sabrh.persistence.AnimalDAO#pesquisar(br.pucpr.sabrh.entity.
	 * Animal)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Animal> pesquisar(Animal animal) {
		Session s = (Session) entityManager.getDelegate();
		Criteria c = s.createCriteria(Animal.class, "ani");
		c.createCriteria("propriedade", "prop");
		c.add(Example.create(animal).enableLike(MatchMode.ANYWHERE)
				.ignoreCase());

		// verifica se existe propriedade para ser pesquisada
		if (animal.getPropriedade() != null) {
			// se o nome da propriedade não existir, apenas o produtor será
			// pesquisado
			if (animal.getPropriedade().getNome() != null) {
				c.add(Restrictions.eq("propriedade", animal.getPropriedade()));
			} else {
				Criteria q = s.createCriteria(Usuario.class);
				q.add(Example.create(animal.getPropriedade().getProprietario()));
				c.add(Restrictions.eq("prop.proprietario", q.uniqueResult()));
			}
		}

		// verifica se existe dados da mae para ser pesquisado
		if (animal.getMae() != null) {
			Criteria q = s.createCriteria(Animal.class);
			q.add(Example.create(animal.getMae()).enableLike(MatchMode.ANYWHERE)
					.ignoreCase());
			c.add(Restrictions.in("mae", q.list()));
		}
		
		// verifica se existe dados do pai para ser pesquisado
		if (animal.getPai() != null) {
			Criteria q = s.createCriteria(Animal.class);
			q.add(Example.create(animal.getPai()).enableLike(MatchMode.ANYWHERE)
					.ignoreCase());
			c.add(Restrictions.in("pai", q.list()));
		}

		c.addOrder(Order.asc("registro"));
		List<Animal> result = c.list();
		return result;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.persistence.AnimalDAO#salvar(br.pucpr.sabrh.entity.Animal)
	 */
	@Override
	public Animal salvar(Animal animal) {

		Animal result = null;
		result = entityManager.merge(animal);
		entityManager.flush();

		return result;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.persistence.AnimalDAO#excluir(br.pucpr.sabrh.entity.Animal
	 * )
	 */
	@Override
	public void excluir(Animal animal) {
		// TODO Auto-generated method stub

	}

}
