package br.pucpr.sabrh.common.persistence;

import java.util.List;

import br.pucpr.sabrh.common.persistence.exception.DAOException;

/**
 * Interface representando as acoes basicas que podem ser executadas com objetos
 * persistidos.
 * 
 * @author charles.viegas
 * @param <ENTITY>
 *            Tipo do objeto que será persistido <i>Value Object (VO)</i>.
 * @param <PK>
 *            Tipo da chave primeira da entidade.
 */
public interface CrudDAO<ENTITY, PK> {

	/**
	 * Busca todos os objetos persistidos.
	 * 
	 * @throws DAOException
	 *             A exceção de persitência.
	 */
	List<ENTITY> findAll() throws DAOException;

	/**
	 * Busca o objeto entidade por sua chave.
	 * 
	 * @param pk
	 *            A chave primária do objeto persistido.
	 * @return A entidade populada.
	 * @throws DAOException
	 *             A exceção de persitência.
	 */
	ENTITY findById(PK pk) throws DAOException;

	/**
	 * Persiste um objeto.
	 * 
	 * @param entity
	 *            Template do objeto a ser persistido.
	 * @throws DAOException
	 *             A exceção de persitência.
	 */
	ENTITY create(ENTITY entity) throws DAOException;

	/**
	 * Remove um objeto persistido.
	 * 
	 * @param entity
	 *            Template do objeto a ser removido.
	 * @throws DAOException
	 *             A exceção de persitência.
	 */
	void remove(ENTITY entity) throws DAOException;

	/**
	 * Atualiza as informacoes de um objeto persistido.
	 * 
	 * @param entity
	 *            Template do objeto a ser atualizado.
	 * @throws DAOException
	 *             A exceção de persitência.
	 */
	void update(ENTITY entity) throws DAOException;

	/**
	 * Retorna o total de objetos persistidos.
	 * 
	 * @return Total de objetos persistidos.
	 * @throws DAOException
	 *             A exceção de persitência.
	 */
	Long count() throws DAOException;

	/**
	 * Busca através de uma namedQuery.
	 * 
	 * @param namedQuery
	 *            Nome da NamedQuery.
	 * @param parametros
	 *            Valores dos parâmetros.
	 * @return A entidade populada ou null.
	 * @throws DAOException
	 *             A exceção de persitência.
	 */
	ENTITY querySingle(String namedQuery, Object... parametros)
			throws DAOException;

	/**
	 * Busca por namedQuery sem passagem de parâmetros.
	 * 
	 * @param namedQuery
	 *            Nome da NamedQuery.
	 * @param numMax
	 * @param offset
	 * @return Lista de entidade populada ou lista vazia.
	 * @throws DAOException
	 *             A exceção de persitência.
	 */
	List<ENTITY> queryList(String namedQuery, int numMax, int offset)
			throws DAOException;

	/**
	 * Busca por namedQuery com a passagem de parâmetros.
	 * 
	 * @param namedQuery
	 *            Nome da NamedQuery.
	 * @return Lista de entidade populada ou lista vazia.
	 * @throws DAOException
	 *             A exceção de persitência.
	 */
	List<ENTITY> queryList(String namedQuery, Object... parametros)
			throws DAOException;

	/**
	 * Busca por namedQuery com a passagem de parâmetros e paginação.
	 * 
	 * @param namedQuery
	 *            Nome da NamedQuery.
	 * @param numMax
	 * @param offset
	 * @return Lista de entidade populada ou lista vazia.
	 * @throws DAOException
	 *             A exceção de persitência.
	 */
	List<ENTITY> queryList(String namedQuery, int numMax, int offset,
			Object... parametros) throws DAOException;
}
