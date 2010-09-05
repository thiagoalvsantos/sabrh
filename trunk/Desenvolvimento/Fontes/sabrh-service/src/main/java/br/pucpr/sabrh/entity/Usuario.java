package br.pucpr.sabrh.entity;

import java.io.Serializable;

public interface Usuario extends Serializable {

	public String getCpf();

	public void setCpf(String cpf);

	public String getNome();

	public void setNome(String nome);

	public Municipio getMunicipio();

	public void setMunicipio(Municipio municipio);

	public Long getCodigo();

	public void setCodigo(Long codigo);

	public String getLogin();

	public void setLogin(String login);

	public String getSenha();

	public void setSenha(String senha);

	public char getStatus();

	public void setStatus(char status);

	public char getPerfil();

	public void setPerfil(char perfil);
}
