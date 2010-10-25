package br.pucpr.sabrh.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "TB_EVENTO_ACASALAMENTO")
public class EventoAcasalamento implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(initialValue = 1, sequenceName = "SEQ_EVENTO_ACASALAMENTO", name = "codigo")
	@Column(name = "CD_CODIGO", length = 8)
	private int codigo;
	private Acasalamento acasalamento;
	private TipoEventoAcasalamento tipoEventoAcasalamento;
	private Date dataEvento;
	private String comentario;

}
