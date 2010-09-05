
package br.pucpr.sabrh.common.persistence.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import br.pucpr.sabrh.common.logging.Logging;
import br.pucpr.sabrh.common.persistence.CrudDAO;
import br.pucpr.sabrh.common.persistence.exception.DAOException;


@SuppressWarnings("unchecked")
public class CrudDAOImpl<ENTITY, PK> implements CrudDAO<ENTITY, PK> {

    /** A Constant LOGGER. */
    private static final Logging LOGGER = Logging.getLogger(CrudDAOImpl.class.getName());

    /**
     * Obtem o entity manager dao.
     */
    private EntityManager entityManager;

    /**
     * Obtem a clazz biz.
     */
    private Class clazzBiz;

    /**
     * Construtor da classe CrudDAOImpl.
     * @param pClazz
     *            - p clazz.
     * @param pEntityManager
     *            - p entity manager.
     */
    public CrudDAOImpl(Class<?> pClazz, EntityManager pEntityManager) {
        this.clazzBiz = pClazz;
        this.entityManager = pEntityManager;
    }

    /**
     * @see br.unicamp.dga.siad.commons.persistence.spec.CrudDAO#findAll()
     */
    public List<ENTITY> findAll() throws DAOException {
        LOGGER.debug("create #0 instance", getClazzBiz().getCanonicalName());
        try {
            String str = " FROM " + getClazzBiz().getName();
            List<ENTITY> list = getEntityManager().createQuery(str).getResultList();
            return list;

        } catch (RuntimeException re) {
            LOGGER.error("findAll failed", re);
            throw new RuntimeException(re);
        }
    }

    /**
     * @see br.unicamp.dga.siad.commons.persistence.spec.CrudDAO#create(java.lang.Object)
     */
    public ENTITY create(ENTITY entity) throws DAOException {
        LOGGER.debug("create #0 instance", entity.getClass().getCanonicalName());
        try {
            EntityManager em = getEntityManager();
            em.persist(entity);
            em.flush();
            return (ENTITY) entity;
        } catch (RuntimeException re) {
            LOGGER.error("create failed", re);
            throw new RuntimeException(re);
        }
    }

    /**
     * @see br.unicamp.dga.siad.commons.persistence.spec.CrudDAO#update(java.lang.Object)
     */
    public void update(ENTITY entity) throws DAOException {
        LOGGER.debug("update #0 instance", entity.getClass().getCanonicalName());
        try {
            EntityManager em = getEntityManager();
            em.merge(entity);
            em.flush();

        } catch (RuntimeException re) {
            LOGGER.error("update failed", re);
            throw new RuntimeException(re);
        }
    }

    /**
     * @see br.unicamp.dga.siad.commons.persistence.spec.CrudDAO#remove(java.lang.Object)
     */
    public void remove(ENTITY entity) throws DAOException {
        LOGGER.debug("removing #0 instance", entity.getClass().getCanonicalName());
        try {
            EntityManager em = getEntityManager();
            em.remove(em.merge(entity));
            LOGGER.debug("remove successful");
        } catch (RuntimeException re) {
            LOGGER.error("remove failed", re);
            throw new RuntimeException(re);
        }
    }

    /**
     * @see br.unicamp.dga.siad.commons.persistence.spec.CrudDAO#findById(java.lang.Object)
     */
    public ENTITY findById(PK pk) throws DAOException {
        LOGGER.debug("findById #0 instance", getClazzBiz().getCanonicalName());
        try {
            return (ENTITY) getEntityManager().find(getClazzBiz(), pk);
        } catch (RuntimeException re) {
            LOGGER.error("findById failed", re);
            throw new RuntimeException(re);
        }
    }

    /**
     * @see br.unicamp.dga.siad.commons.persistence.spec.CrudDAO#count()
     */
    public Long count() throws DAOException {
        LOGGER.debug("count #0 instance", getClazzBiz().getCanonicalName());
        try {
            Query query = getEntityManager().createQuery("SELECT COUNT(entity) "
                + "FROM " + getClazzBiz().getName() + " entity ");
            return (Long) query.getSingleResult();
        } catch (RuntimeException re) {
            LOGGER.error("findById failed", re);
            throw new RuntimeException(re);
        }
    }

    /**
     * @see br.unicamp.dga.siad.commons.persistence.spec.CrudDAO#queryList(java.lang.String, int, int)
     */
    public List<ENTITY> queryList(String namedQuery, int numMax, int offset) throws DAOException {
        return queryList(namedQuery, numMax, offset, null);
    }

    /**
     * @see br.unicamp.dga.siad.commons.persistence.spec.CrudDAO#queryList(java.lang.String, int, int,
     *      java.lang.Object[])
     */
    public List<ENTITY> queryList(String namedQuery, int numMax, int offset, Object... parametros)
        throws DAOException {
        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug("consultaQueryList #0", this.getClass().getCanonicalName());
            LOGGER.debug("  |--- entity \t #0", getClazzBiz().getCanonicalName());
            LOGGER.debug("  |--- namedList\t #0", namedQuery);
            LOGGER.debug("  |--- parametros\t #0", parametros);
        }
        try {
            EntityManager em = this.getEntityManager();
            Query query = em.createNamedQuery(namedQuery);
            int i = 1;
            if (parametros != null) {
                for (Object object : parametros) {
                    if (object != null) {
                        LOGGER.debug("          |----- parametro #0 \t #1", i, object);
                        query.setParameter(i++, object);
                    }
                }
            }
            query.setFirstResult(offset);
            query.setMaxResults(numMax);

            return query.getResultList();
        } catch (RuntimeException re) {
            LOGGER.error("consultaQueryList failed", re);
            throw new RuntimeException(re);
        }

    }

    /**
     * @see br.unicamp.dga.siad.commons.persistence.spec.CrudDAO#queryList(java.lang.String,
     *      java.lang.Object[])
     */
    public List<ENTITY> queryList(String namedQuery, Object... parametros) throws DAOException {
        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug("consultaQueryList #0", this.getClass().getCanonicalName());
            LOGGER.debug("  |--- entity \t #0", getClazzBiz().getCanonicalName());
            LOGGER.debug("  |--- namedList\t #0", namedQuery);
            LOGGER.debug("  |--- parametros\t #0", parametros);

        }
        try {
            EntityManager em = this.getEntityManager();
            Query query = em.createNamedQuery(namedQuery);
            if (parametros != null) {
                int i = 1;
                for (Object object : parametros) {
                    if (object != null) {
                        LOGGER.debug("          |----- parametro #0 \t #1", i, object);
                        query.setParameter(i++, object);
                    }
                }
            }
            List<ENTITY> listaEntity = query.getResultList();
            return listaEntity;
        } catch (RuntimeException re) {
            LOGGER.error("consultaQueryList failed", re);
            throw new RuntimeException(re);
        }

    }

    /**
     * @see br.unicamp.dga.siad.commons.persistence.spec.CrudDAO#querySingle(java.lang.String,
     *      java.lang.Object[])
     */
    public ENTITY querySingle(String namedQuery, Object... parametros) throws DAOException {
        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug("consultaQueryList #0", this.getClass().getCanonicalName());
            LOGGER.debug("  |--- entity \t #0", getClazzBiz().getCanonicalName());
            LOGGER.debug("  |--- namedList\t #0", namedQuery);
            LOGGER.debug("  |--- parametros\t #0", parametros);
        }
        try {
            EntityManager em = this.getEntityManager();
            Query query = em.createNamedQuery(namedQuery);

            if (parametros != null) {
                int i = 1;
                for (Object object : parametros) {
                    if (object != null) {
                        LOGGER.debug("          |----- parametro #0 \t #1", i, object);
                        query.setParameter(i++, object);
                    }
                }
            }
            ENTITY entity = (ENTITY) query.getSingleResult();
            return entity;
        } catch (RuntimeException re) {
            LOGGER.error("consultaQuerySingle failed", re);
            throw new RuntimeException(re);
        }

    }

    /**
     * Get entity manager.
     * @return the entity manager
     * @see CrudDAOImpl#entityManager.
     */
    public EntityManager getEntityManager() {
        return entityManager;
    }

    /**
     * Set entity manager.
     * @param pEntityManager
     *            - entity manager.
     * @see CrudDAOImpl#entityManager.
     */
    public void setEntityManager(EntityManager pEntityManager) {
        this.entityManager = pEntityManager;
    }

    /**
     * Get clazz biz.
     * @return the clazz biz
     * @see CrudDAOImpl#clazzBiz.
     */
    public Class getClazzBiz() {
        return clazzBiz;
    }

    /**
     * Set clazz biz.
     * @param pClazzBiz
     *            - clazz biz.
     * @see CrudDAOImpl#clazzBiz.
     */
    public void setClazzBiz(Class pClazzBiz) {
        this.clazzBiz = pClazzBiz;
    }

}
