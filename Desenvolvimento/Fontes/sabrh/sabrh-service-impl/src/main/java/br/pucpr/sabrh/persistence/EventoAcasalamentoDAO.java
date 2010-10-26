package br.pucpr.sabrh.persistence;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Acasalamento;
import br.pucpr.sabrh.entity.EventoAcasalamento;

@Remote
public interface EventoAcasalamentoDAO {

	EventoAcasalamento salvar(EventoAcasalamento eventoAcasalamento);

	List<EventoAcasalamento> pesquisar(Acasalamento acasalamento);
}
