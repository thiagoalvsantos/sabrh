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
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;

import br.pucpr.sabrh.entity.Estado;
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
	public List<Propriedade> pesquisar(Propriedade propriedade) {
		Session s = (Session) entityManager.getDelegate();
		Criteria c = s.createCriteria(Propriedade.class, "propri");
		c.createCriteria("municipio", "mun");
		c.createCriteria("proprietario", "prop");
		c.add(Example.create(propriedade).enableLike(MatchMode.ANYWHERE)
				.ignoreCase());
		if (propriedade.getMunicipio() != null) {
			if (propriedade.getMunicipio().getCodigo() != 0) {
				c.add(Restrictions.eq("municipio", propriedade.getMunicipio()));
			} else {
				Criteria q = s.createCriteria(Estado.class);
				q.add(Example.create(propriedade.getMunicipio().getEstado()));
				c.add(Restrictions.eq("mun.estado", q.uniqueResult()));
			}

		}
		if (propriedade.getProprietario() != null){
			c.add(Restrictions.eq("proprietario", propriedade.getProprietario()));
		}
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
