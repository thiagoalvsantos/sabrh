
import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity(name = "SABRH.USUARIO")
public class Usuario implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1112671402804675927L;

	// CD_USUARIO NUMBER(8) NOT NULL,
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "CD_CODIGO", length = 8)
	private Long codigo;

	// TX_LOGIN VARCHAR(50) NOT NULL,
	@Column(name = "TX_LOGIN", length = 50, unique = true, nullable = false)
	private String login;

	// TX_SENHA VARCHAR(50) NOT NULL,
	@Column(name = "TX_SENHA", length = 50, nullable = false)
	private String senha;

	// ST_STATUS CHAR(1) NULL
	@Column(name = "ST_STATUS", length = 1, nullable = false)
	private char status;

	public Long getCodigo() {
		return codigo;
	}

	public void setCodigo(Long codigo) {
		this.codigo = codigo;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public char getStatus() {
		return status;
	}

	public void setStatus(char status) {
		this.status = status;
	}

}
