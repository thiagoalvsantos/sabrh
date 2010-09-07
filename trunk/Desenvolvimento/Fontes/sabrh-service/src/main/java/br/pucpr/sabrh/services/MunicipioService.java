/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.services;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Estado;
import br.pucpr.sabrh.entity.Municipio;

/**
 * Interface de serviço da camada core relacionado ao componente Municipio.
 * 
 * @author Thiago
 * @version 1
 */
@Remote
public interface MunicipioService {

	/**
	 * Listar municipios.
	 * 
	 * @return list
	 */
	List<Municipio> listarMunicipios();

	/**
	 * Listar municipios.
	 * 
	 * @param estado
	 *            - estado
	 * @return list
	 */
	List<Municipio> listarMunicipios(Estado estado);

}
