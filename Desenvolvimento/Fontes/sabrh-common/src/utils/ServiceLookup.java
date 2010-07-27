package utils;

import javax.naming.InitialContext;
import javax.naming.NamingException;

import service.ServiceUsuario;

public class ServiceLookup {

	public static ServiceUsuario getServiceUsuario() {
		InitialContext ctx;

		try {
			ctx = new InitialContext();

			ServiceUsuario serviceUsuario = (ServiceUsuario) ctx
					.lookup("sabrh-ear/ServiceUsuario/remote");

			return serviceUsuario;
		} catch (NamingException e) {
			throw new RuntimeException("Erro ao obter objeto remoto", e);
		}

	}

}
