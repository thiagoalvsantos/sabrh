package br.pucpr.sabrh.common.persistence;

import java.util.List;

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
public interface CrudDAO<T> {

	/*
	 * Ações possíveis feita com CRUD. Os métodos cujos parâmetros são do tipo
	 * java.util.List, são enviados em massa, ou seja, os dados são processados
	 * e armazenados e apenas no final o aplicativo lança o commit. Para grande
	 * massa de dados é mais viável pois o tempo de processo é muito maior
	 * quando abre apenas uma conexão e aplica apenas uma ação de persistencia
	 */
	public T remove(T object) throws Exception;

	public T persist(T object) throws Exception;

	public T update(T object) throws Exception;

	public List<T> update(List<T> object) throws Exception;

	public List<T> persist(List<T> list) throws Exception;

	public List<T> remove(List<T> object) throws Exception;

	/*
	 * Aqui se aplica todos os tipos de buscas possível para se fazer dentro de
	 * uma aplicação padrão.
	 */
	public List<T> findAll() throws Exception;

	// public T load(Object obj) throws Exception;
}
