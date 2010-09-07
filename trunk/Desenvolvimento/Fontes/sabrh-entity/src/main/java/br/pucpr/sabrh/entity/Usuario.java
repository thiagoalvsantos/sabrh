/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * The Class Usuario.
 */
@Entity
@Table(name = "TB_USUARIO")
public class Usuario implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1112671402804675927L;

	/** The codigo. */
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "CD_CODIGO", length = 8)
	private Long codigo;

	/** The login. */
	@Column(name = "TX_LOGIN", length = 50, unique = true, nullable = false)
	private String login;

	/** The senha. */
	@Column(name = "TX_SENHA", length = 50, nullable = false)
	private String senha;

	/** The status. */
	@Enumerated(EnumType.STRING)
	@Column(name = "IN_STATUS", length = 20, nullable = false)
	private TipoStatus status;

	/** The perfil. */
	@Enumerated(EnumType.STRING)
	@Column(name = "IN_PERFIL", length = 20, nullable = false)
	private TipoPerfil perfil;

	@Column(name = "TX_CPF", length = 11, nullable = false)
	private String cpf;

	@Column(name = "TX_NOME", length = 255, nullable = false)
	private String nome;

	@ManyToOne(targetEntity = Municipio.class)
	@JoinColumn(name = "CD_MUNICIPIO", referencedColumnName = "CD_CODIGO")
	private Municipio municipio;

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

	

	

	public String getCpf() {
		return cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public Municipio getMunicipio() {
		return municipio;
	}

	public void setMunicipio(Municipio municipio) {
		this.municipio = municipio;
	}

	public TipoStatus getStatus() {
		return status;
	}

	public void setStatus(TipoStatus status) {
		this.status = status;
	}

	public TipoPerfil getPerfil() {
		return perfil;
	}

	public void setPerfil(TipoPerfil perfil) {
		this.perfil = perfil;
	}

	
}
