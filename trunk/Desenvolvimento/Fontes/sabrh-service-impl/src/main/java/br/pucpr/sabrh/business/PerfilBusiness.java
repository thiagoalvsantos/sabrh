package br.pucpr.sabrh.business;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.Stateless;

import org.apache.commons.collections.CollectionUtils;

import br.pucpr.sabrh.entity.TipoPerfil;
import br.pucpr.sabrh.services.PerfilService;

@Stateless(name="PerfilService")
public class PerfilBusiness implements PerfilService {

	@Override
	public List<TipoPerfil> listarPerfil() {
		ArrayList<TipoPerfil> tipoPerfils = new ArrayList<TipoPerfil>();
		CollectionUtils.addAll(tipoPerfils, TipoPerfil.values());
		return tipoPerfils;
	}

}
