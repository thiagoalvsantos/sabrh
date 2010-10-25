/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import br.pucpr.sabrh.entity.Acasalamento;
import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.ClassificacaoLinear;
import br.pucpr.sabrh.entity.Propriedade;
import br.pucpr.sabrh.entity.Usuario;
import br.pucpr.sabrh.persistence.AcasalamentoDAO;

/**
 * Class AcasalamentoDAOImpl.
 */
@Stateless
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class AcasalamentoDAOImpl implements AcasalamentoDAO {

	/** O atributo entity manager. */
	@PersistenceContext(unitName = "SABRH")
	private EntityManager entityManager;

	/**
	 * Get entity manager.
	 * 
	 * @return the entity manager
	 * @see AcasalamentoDAOImpl#entityManager.
	 */
	public EntityManager getEntityManager() {
		return entityManager;
	}

	/**
	 * Set entity manager.
	 * 
	 * @param entityManager
	 *            - entity manager.
	 * @see AcasalamentoDAOImpl#entityManager.
	 */
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.persistence.AcasalamentoDAO#pesquisar(br.pucpr.sabrh.entity
	 * .Acasalamento, java.util.Date, java.util.Date)
	 */
	@Override
	public List<Acasalamento> pesquisar(Acasalamento acasalamento,
			Date dataInicio, Date dataFim) {
		Session s = (Session) entityManager.getDelegate();
		Criteria c = s.createCriteria(Acasalamento.class, "acasa");

		if (dataInicio != null && dataFim != null) {
			c.add(Restrictions.between("dataAcasalamento", dataInicio, dataFim));
		} else {
			if (dataInicio != null) {
				c.add(Restrictions.ge("dataAcasalamento", dataInicio));
			}
			if (dataFim != null) {
				c.add(Restrictions.le("dataAcasalamento", dataFim));
			}
		}

		List<Animal> temp = new ArrayList<Animal>();
		boolean executa = false;
		if (acasalamento.getFemea() != null) {
			Criteria q = s.createCriteria(Animal.class, "ani");
			if (acasalamento.getFemea().getNome() != null) {
				q.add(Restrictions.or(Restrictions.ilike("apelido",
						acasalamento.getFemea().getNome(), MatchMode.ANYWHERE),
						Restrictions.ilike("nome", acasalamento.getFemea()
								.getNome(), MatchMode.ANYWHERE)));
			}
			if (acasalamento.getFemea().getRegistro() != null
					&& acasalamento.getFemea().getRegistro() != "") {

				q.add(Restrictions.ilike("registro", acasalamento.getFemea()
						.getRegistro(), MatchMode.ANYWHERE));
			}

			if (acasalamento.getFemea().getPropriedade() != null) {
				// se o nome da propriedade não existir, apenas o produtor será
				// pesquisado
				if (acasalamento.getFemea().getPropriedade().getNome() != null) {
					q.add(Restrictions.eq("propriedade", acasalamento
							.getFemea().getPropriedade()));
				} else {
					q.createAlias("propriedade", "prop");
					Criteria qprop = s.createCriteria(Usuario.class, "ani");
					qprop.add(Example.create(acasalamento.getFemea()
							.getPropriedade().getProprietario()));
					q.add(Restrictions.eq("prop.proprietario",
							qprop.uniqueResult()));
				}
				temp = q.list();
			}

			if (!temp.isEmpty()) {
				executa = true;
				c.add(Restrictions.or(Restrictions.in("femea", temp),
						Restrictions.or(Restrictions.in("macho", temp),
								Restrictions.in("cria", temp))));
			}

		} else {
			executa = true;
		}

		if (executa) {
			c.addOrder(Order.asc("dataAcasalamento"));
			List<Acasalamento> result = c.list();
			return result;

		}
		return new ArrayList<Acasalamento>();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.persistence.AcasalamentoDAO#salvar(br.pucpr.sabrh.entity
	 * .Acasalamento)
	 */
	@Override
	public Acasalamento salvar(Acasalamento acasalamento) {
		acasalamento = entityManager.merge(acasalamento);
		entityManager.flush();
		return acasalamento;
	}

}
