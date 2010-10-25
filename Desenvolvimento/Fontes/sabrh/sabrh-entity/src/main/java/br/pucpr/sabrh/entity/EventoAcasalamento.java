/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.entity;

import java.io.Serializable;
import java.util.Date;

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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.ForeignKey;

/**
 * Class EventoAcasalamento.
 */
@Entity
@Table(name = "TB_EVENTO_ACASALAMENTO")
public class EventoAcasalamento implements Serializable {

	/** O atributo serial version uid. */
	private static final long serialVersionUID = -2827720903322780905L;

	/** O atributo codigo. */
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(initialValue = 1, sequenceName = "SEQ_EVENTO_ACASALAMENTO", name = "codigo")
	@Column(name = "CD_CODIGO", length = 8)
	private int codigo;

	/** O atributo acasalamento. */
	@ManyToOne(targetEntity = Acasalamento.class)
	@JoinColumn(name = "CD_ACASALAMENTO", referencedColumnName = "CD_CODIGO", nullable = false)
	@ForeignKey(name = "FK_EVENTO_ACASALAMENTO")
	private Acasalamento acasalamento;

	/** O atributo tipo evento acasalamento. */
	@Enumerated(EnumType.STRING)
	@Column(name = "IN_TIPO", length = 20, nullable = false)
	private TipoEventoAcasalamento tipoEventoAcasalamento;

	/** O atributo data evento. */
	@Column(name = "DT_ACASALAMENTO", nullable = false)
	@Temporal(TemporalType.DATE)
	private Date dataEvento;

	/** O atributo comentario. */
	@Column(name = "TX_COMENTARIO", length = 255, nullable = false)
	private String comentario;

	/**
	 * Get codigo.
	 * 
	 * @return the codigo
	 * @see EventoAcasalamento#codigo.
	 */
	public int getCodigo() {
		return codigo;
	}

	/**
	 * Set codigo.
	 * 
	 * @param codigo
	 *            - codigo.
	 * @see EventoAcasalamento#codigo.
	 */
	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}

	/**
	 * Get acasalamento.
	 * 
	 * @return the acasalamento
	 * @see EventoAcasalamento#acasalamento.
	 */
	public Acasalamento getAcasalamento() {
		return acasalamento;
	}

	/**
	 * Set acasalamento.
	 * 
	 * @param acasalamento
	 *            - acasalamento.
	 * @see EventoAcasalamento#acasalamento.
	 */
	public void setAcasalamento(Acasalamento acasalamento) {
		this.acasalamento = acasalamento;
	}

	/**
	 * Get tipo evento acasalamento.
	 * 
	 * @return the tipo evento acasalamento
	 * @see EventoAcasalamento#tipoEventoAcasalamento.
	 */
	public TipoEventoAcasalamento getTipoEventoAcasalamento() {
		return tipoEventoAcasalamento;
	}

	/**
	 * Set tipo evento acasalamento.
	 * 
	 * @param tipoEventoAcasalamento
	 *            - tipo evento acasalamento.
	 * @see EventoAcasalamento#tipoEventoAcasalamento.
	 */
	public void setTipoEventoAcasalamento(
			TipoEventoAcasalamento tipoEventoAcasalamento) {
		this.tipoEventoAcasalamento = tipoEventoAcasalamento;
	}

	/**
	 * Get data evento.
	 * 
	 * @return the data evento
	 * @see EventoAcasalamento#dataEvento.
	 */
	public Date getDataEvento() {
		return dataEvento;
	}

	/**
	 * Set data evento.
	 * 
	 * @param dataEvento
	 *            - data evento.
	 * @see EventoAcasalamento#dataEvento.
	 */
	public void setDataEvento(Date dataEvento) {
		this.dataEvento = dataEvento;
	}

	/**
	 * Get comentario.
	 * 
	 * @return the comentario
	 * @see EventoAcasalamento#comentario.
	 */
	public String getComentario() {
		return comentario;
	}

	/**
	 * Set comentario.
	 * 
	 * @param comentario
	 *            - comentario.
	 * @see EventoAcasalamento#comentario.
	 */
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}

}
