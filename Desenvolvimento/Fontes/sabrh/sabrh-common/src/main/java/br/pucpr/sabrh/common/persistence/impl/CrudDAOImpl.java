package br.pucpr.sabrh.common.persistence.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;

import br.pucpr.sabrh.common.persistence.CrudDAO;

/**
 * Implementação JPA da interface IBasicCRUD.
 * 
 * @see br.unicamp.dga.siad.commons.persistence.spec.CrudDAO
 * @author charles.viegas
 * @param <ENTITY>
 *            Tipo do objeto que será persistido <i>Value Object (VO)</i>.
 * @param <PK>
 *            Tipo da chave primeira da entidade.
 */
@SuppressWarnings("unchecked")
public class CrudDAOImpl<T> implements CrudDAO<T> {

	protected EntityManager em = null;
	protected Class<T> entity = null;

	public CrudDAOImpl(EntityManager em, Class<T> entity) {

		this.entity = entity;
		this.em = em;

	}

	@Override
	public List<T> findAll() throws Exception {

		String str = " FROM " + entity.getName();
		List<T> list = em.createQuery(str).getResultList();
		return list;

	}

	//@Override
	//public abstract T load(Object obj) throws Exception;

	@Override
	public T persist(T object) throws Exception {
		EntityTransaction transaction = em.getTransaction();
		transaction.begin();
		try {
			em.persist(object);
			transaction.commit();
			return object;
		} catch (Exception e) {
			transaction.rollback();
			throw e;
		}
	}

	@Override
	public List<T> persist(List<T> list) throws Exception {
		EntityTransaction transaction = em.getTransaction();
		transaction.begin();
		try {
			for (T object : list)
				em.persist(object);
			transaction.commit();
			return list;
		} catch (Exception e) {
			transaction.rollback();
			throw e;
		}
	}

	@Override
	public T remove(T object) throws Exception {
		EntityTransaction transaction = em.getTransaction();
		transaction.begin();
		try {
			em.remove(object);
			transaction.commit();
			return object;
		} catch (Exception e) {
			transaction.rollback();
			throw e;
		}
	}

	@Override
	public List<T> remove(List<T> list) throws Exception {
		EntityTransaction transaction = em.getTransaction();
		transaction.begin();
		try {
			for (T object : list)
				em.remove(object);
			transaction.commit();
			return list;
		} catch (Exception e) {
			transaction.rollback();
			throw e;
		}
	}

	@Override
	public T update(T object) throws Exception {
		EntityTransaction transaction = em.getTransaction();
		transaction.begin();
		try {
			em.merge(object);
			transaction.commit();
			return object;
		} catch (Exception e) {
			transaction.rollback();
			throw e;
		}
	}

	@Override
	public List<T> update(List<T> list) throws Exception {
		EntityTransaction transaction = em.getTransaction();
		transaction.begin();
		try {
			for (T object : list)
				em.merge(object);
			transaction.commit();
			return list;
		} catch (Exception e) {
			transaction.rollback();
			throw e;
		}
	}

}
