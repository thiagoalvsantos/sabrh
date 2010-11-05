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
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.ForeignKey;

/**
 * The Class Usuario.
 */
@Entity
@Table(name = "TB_USUARIO")
public class Usuario implements Serializable {

	/** O atributo serial version uid. */
	private static final long serialVersionUID = -1112671402804675927L;

	/** O atributo codigo. */
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(initialValue = 1, sequenceName = "SEQ_USUARIO", name = "codigo")
	@Column(name = "CD_CODIGO", length = 8)
	private Long codigo;

	/** O atributo login. */
	@Column(name = "TX_LOGIN", length = 20, unique = true, nullable = false)
	private String login;

	/** O atributo senha. */
	@Column(name = "TX_SENHA", length = 50, nullable = false)
	private String senha;

	/** O atributo status. */
	@Enumerated(EnumType.STRING)
	@Column(name = "IN_STATUS", length = 20, nullable = false)
	private TipoStatus status;

	/** O atributo perfil. */
	@Enumerated(EnumType.STRING)
	@Column(name = "IN_PERFIL", length = 20, nullable = false)
	private TipoPerfil perfil;

	/** O atributo cpf. */
	@Column(name = "TX_CPF", length = 11, nullable = false, unique=true)
	private String cpf;

	/** O atributo nome. */
	@Column(name = "TX_NOME", length = 80, nullable = false)
	private String nome;

	/** O atributo email. */
	@Column(name = "TX_EMAIL", length = 80, nullable = false)
	private String email;

	/** O atributo municipio. */
	@ManyToOne(targetEntity = Municipio.class)
	@JoinColumn(name = "CD_MUNICIPIO", referencedColumnName = "CD_CODIGO")
	@ForeignKey(name = "FK_USUARIO_MUNICIPIO")
	private Municipio municipio;

	/**
	 * Get email.
	 * 
	 * @return the email
	 * @see Usuario#email.
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * Set email.
	 * 
	 * @param email
	 *            - email.
	 * @see Usuario#email.
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * Get codigo.
	 * 
	 * @return the codigo
	 * @see Usuario#codigo.
	 */
	public Long getCodigo() {
		return codigo;
	}

	/**
	 * Set codigo.
	 * 
	 * @param codigo
	 *            - codigo.
	 * @see Usuario#codigo.
	 */
	public void setCodigo(Long codigo) {
		this.codigo = codigo;
	}

	/**
	 * Get login.
	 * 
	 * @return the login
	 * @see Usuario#login.
	 */
	public String getLogin() {
		return login;
	}

	/**
	 * Set login.
	 * 
	 * @param login
	 *            - login.
	 * @see Usuario#login.
	 */
	public void setLogin(String login) {
		this.login = login;
	}

	/**
	 * Get senha.
	 * 
	 * @return the senha
	 * @see Usuario#senha.
	 */
	public String getSenha() {
		return senha;
	}

	/**
	 * Set senha.
	 * 
	 * @param senha
	 *            - senha.
	 * @see Usuario#senha.
	 */
	public void setSenha(String senha) {
		this.senha = senha;
	}

	/**
	 * Get cpf.
	 * 
	 * @return the cpf
	 * @see Usuario#cpf.
	 */
	public String getCpf() {
		return cpf;
	}

	/**
	 * Set cpf.
	 * 
	 * @param cpf
	 *            - cpf.
	 * @see Usuario#cpf.
	 */
	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

	/**
	 * Get nome.
	 * 
	 * @return the nome
	 * @see Usuario#nome.
	 */
	public String getNome() {
		return nome;
	}

	/**
	 * Set nome.
	 * 
	 * @param nome
	 *            - nome.
	 * @see Usuario#nome.
	 */
	public void setNome(String nome) {
		this.nome = nome;
	}

	/**
	 * Get municipio.
	 * 
	 * @return the municipio
	 * @see Usuario#municipio.
	 */
	public Municipio getMunicipio() {
		return municipio;
	}

	/**
	 * Set municipio.
	 * 
	 * @param municipio
	 *            - municipio.
	 * @see Usuario#municipio.
	 */
	public void setMunicipio(Municipio municipio) {
		this.municipio = municipio;
	}

	/**
	 * Get status.
	 * 
	 * @return the status
	 * @see Usuario#status.
	 */
	public TipoStatus getStatus() {
		return status;
	}

	/**
	 * Set status.
	 * 
	 * @param status
	 *            - status.
	 * @see Usuario#status.
	 */
	public void setStatus(TipoStatus status) {
		this.status = status;
	}

	/**
	 * Get perfil.
	 * 
	 * @return the perfil
	 * @see Usuario#perfil.
	 */
	public TipoPerfil getPerfil() {
		return perfil;
	}

	/**
	 * Set perfil.
	 * 
	 * @param perfil
	 *            - perfil.
	 * @see Usuario#perfil.
	 */
	public void setPerfil(TipoPerfil perfil) {
		this.perfil = perfil;
	}

}
