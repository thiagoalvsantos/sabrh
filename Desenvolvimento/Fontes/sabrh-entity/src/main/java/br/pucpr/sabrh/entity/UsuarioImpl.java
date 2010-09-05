/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * The Class Usuario.
 */
@Entity(name = "Usuario")
@Table(name = "TB_USUARIO")
public class UsuarioImpl implements Usuario, Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1112671402804675927L;

	/** The codigo. */
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE)
	@Column(name = "CD_CODIGO", length = 8)
	private Long codigo;

	/** The login. */
	@Column(name = "TX_LOGIN", length = 50, unique = true, nullable = false)
	private String login;

	/** The senha. */
	@Column(name = "TX_SENHA", length = 50, nullable = false)
	private String senha;

	/** The status. */
	@Column(name = "IN_STATUS", length = 1, nullable = false)
	private char status;

	/** The perfil. */
	@Column(name = "IN_PERFIL", length = 1, nullable = false)
	private char perfil;

	@Column(name = "TX_CPF", length = 11, nullable = false)
	private String cpf;

	@Column(name = "TX_NOME", length = 255, nullable = false)
	private String nome;

	@ManyToOne(targetEntity = MunicipioImpl.class)
	@JoinColumn(name = "CD_MUNICIPIO", referencedColumnName = "CD_CODIGO")
	private Municipio municipio;

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

	/**
	 * Gets the codigo.
	 * 
	 * @return the codigo
	 */
	public Long getCodigo() {
		return codigo;
	}

	/**
	 * Sets the codigo.
	 * 
	 * @param codigo
	 *            the new codigo
	 */
	public void setCodigo(Long codigo) {
		this.codigo = codigo;
	}

	/**
	 * Gets the login.
	 * 
	 * @return the login
	 */
	public String getLogin() {
		return login;
	}

	/**
	 * Sets the login.
	 * 
	 * @param login
	 *            the new login
	 */
	public void setLogin(String login) {
		this.login = login;
	}

	/**
	 * Gets the senha.
	 * 
	 * @return the senha
	 */
	public String getSenha() {
		return senha;
	}

	/**
	 * Sets the senha.
	 * 
	 * @param senha
	 *            the new senha
	 */
	public void setSenha(String senha) {
		this.senha = senha;
	}

	/**
	 * Gets the status.
	 * 
	 * @return the status
	 */
	public char getStatus() {
		return status;
	}

	/**
	 * Sets the status.
	 * 
	 * @param status
	 *            the new status
	 */
	public void setStatus(char status) {
		this.status = status;
	}

	/**
	 * Gets the perfil.
	 * 
	 * @return the perfil
	 */
	public char getPerfil() {
		return perfil;
	}

	/**
	 * Sets the perfil.
	 * 
	 * @param perfil
	 *            the new perfil
	 */
	public void setPerfil(char perfil) {
		this.perfil = perfil;
	}

	@Override
	public void setMunicipio(Municipio municipio) {
		this.municipio = municipio;

	}

}
