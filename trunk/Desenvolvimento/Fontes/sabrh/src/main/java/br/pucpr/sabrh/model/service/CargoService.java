package br.pucpr.sabrh.model.service;

import java.util.ArrayList;
import java.util.List;

import utils.ServiceLookup;

import entidades.Usuario;

import br.pucpr.sabrh.model.entity.Cargo;


public class CargoService {

	public Cargo save(Cargo p_cargo) {
		System.out.println("Salvou o Cargo: " + p_cargo.getDsCargo());
		
		Usuario usuario = new Usuario();
		
		usuario.setLogin(p_cargo.getIdCargo() + "");
		usuario.setSenha(p_cargo.getDsCargo());
		
		System.out.println(ServiceLookup.getServiceUsuario().Autenticar(usuario));
		
		
		return p_cargo;
	}

	public void remove(Cargo p_cargo) {
		System.out.println("Excluiu o Cargo: " + p_cargo.getDsCargo());
	}

	public List<Cargo> getList() {
		return new ArrayList<Cargo>();
	}

	public Cargo findByPrimaryKey() {
		return new Cargo();
	}
}
