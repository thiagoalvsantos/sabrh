/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Estado;
import br.pucpr.sabrh.entity.Municipio;

/**
 * Interface MunicipioDAO.
 */
@Remote
public interface MunicipioDAO {

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
