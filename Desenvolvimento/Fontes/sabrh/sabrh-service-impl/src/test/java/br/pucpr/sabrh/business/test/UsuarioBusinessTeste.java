package br.pucpr.sabrh.business.test;

import java.util.List;

import javax.ejb.EJBContext;

import org.testng.annotations.Test;
import org.unitils.UnitilsTestNG;
import org.unitils.easymock.annotation.Mock;
import org.unitils.inject.annotation.InjectIntoByType;
import org.unitils.inject.annotation.TestedObject;

import br.pucpr.sabrh.entity.Usuario;
import br.pucpr.sabrh.services.UsuarioService;

public class UsuarioBusinessTeste extends UnitilsTestNG {

	/** O atributo EJB context. */
	@Mock
	@InjectIntoByType
	EJBContext EJBContext;

	@TestedObject
	UsuarioService service;

	@Test(groups = "unittest")
	public void pesquisar() throws Exception {
		List<Usuario> lista = service.listar();

		for (Usuario usuario : lista) {
			System.err.println(usuario.getNome());
		}

	}

}
