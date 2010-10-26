import br.pucpr.sabrh.components.constantes.ConstantesUtils;
import br.pucpr.sabrh.entity.Acasalamento;
import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.EventoAcasalamento;
import br.pucpr.sabrh.entity.Propriedade;
import br.pucpr.sabrh.entity.Usuario;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.core.FlexGlobals;
import mx.events.CloseEvent;
import mx.events.ListEvent;
import mx.formatters.DateFormatter;
import mx.managers.PopUpManager;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.utils.StringUtil;
import mx.validators.Validator;

public function resultConsultarPropriedade(atributoDestino:TextInput, tipoConsulta:String, propriedade:Propriedade):void
{
	atributoDestino.text=propriedade.nome;

	if (tipoConsulta == "novo")
	{
		propriedadeNovo=propriedade;
	}
	else
	{
		if (tipoConsulta == "pesquisa")
		{
			propriedadePesquisa=propriedade;
			proprietarioPesquisa=propriedade.proprietario;
			txtPesquisaProprietario.text=proprietarioPesquisa.nome;
			btnPesquisaBuscarProprietario.enabled=false;
		}
	}

}




//Função que recebe o retorno da consulta de Usuário.
public function resultConsultarUsuario(atributoDestino:TextInput, tipoConsulta:String, usuario:Usuario):void
{
	atributoDestino.text=usuario.nome;

	if (tipoConsulta == "pesquisa")
	{
		proprietarioPesquisa=usuario;
	}
}


//Função para abrir a tela de Consultar Propriedades.
protected function abrirConsultarPropriedade(atributo:TextInput, tipoConsulta:String):void
{
	var popUpConsultarPropriedade:consultarPropriedade=consultarPropriedade(PopUpManager.createPopUp(this.parent, consultarPropriedade, true));
	popUpConsultarPropriedade.janelaOrigem=this;
	popUpConsultarPropriedade.tipoConsulta=tipoConsulta;
	popUpConsultarPropriedade.atributoDestino=atributo;
	if (txtPesquisaProprietario.text != "" && tipoConsulta == "pesquisa")
	{
		popUpConsultarPropriedade.proprietarioPesquisa=proprietarioPesquisa;
		popUpConsultarPropriedade.btnPesquisaBuscar.enabled=false;
		popUpConsultarPropriedade.txtPesquisaProprietario.text=txtPesquisaProprietario.text;
	}
	PopUpManager.centerPopUp(popUpConsultarPropriedade);
	FlexGlobals.topLevelApplication.popUpEffect.target=popUpConsultarPropriedade;
	FlexGlobals.topLevelApplication.popUpEffect.play();
}

//Função para abrir a tela de Consultar Usuários.
protected function abrirConsultarUsuario(atributo:TextInput, tipoConsulta:String):void
{
	var popUpConsultarUsuario:consultarUsuario=consultarUsuario(PopUpManager.createPopUp(this.parent, consultarUsuario, true));
	popUpConsultarUsuario.janelaOrigem=this;
	popUpConsultarUsuario.tipoConsulta=tipoConsulta;
	popUpConsultarUsuario.atributoDestino=atributo;
	if (txtPesquisaPropriedade.text != "")
	{
		popUpConsultarUsuario.txtPesquisaNome.text=propriedadePesquisa.proprietario.nome;
		popUpConsultarUsuario.txtPesquisaNome.enabled=false;
	}
	PopUpManager.centerPopUp(popUpConsultarUsuario);
	FlexGlobals.topLevelApplication.popUpEffect.target=popUpConsultarUsuario;
	FlexGlobals.topLevelApplication.popUpEffect.play();
}



protected function btnClickLimparPesquisa():void
{
	txtPesquisaDataFim.selectedDate=null;
	txtPesquisaDataInicio.selectedDate=null;
	txtPesquisaNomeAnimal.text=null;
	txtPesquisaPropriedade.text=null;
	txtPesquisaProprietario.text=null;
	txtPesquisaRegistroAnimal.text=null;
}

protected function btnClickPesquisar():void
{
	var acasalamento:Acasalamento=new Acasalamento();

	if (txtPesquisaNomeAnimal.text != "")
	{
		if (acasalamento.cria == null)
		{
			acasalamento.cria=new Animal;
		}
		if (acasalamento.macho == null)
		{
			acasalamento.macho=new Animal;
		}
		if (acasalamento.femea == null)
		{
			acasalamento.femea=new Animal;
		}
		acasalamento.cria.nome=txtPesquisaNomeAnimal.text;
		acasalamento.macho.nome=txtPesquisaNomeAnimal.text;
		acasalamento.femea.nome=txtPesquisaNomeAnimal.text;
		acasalamento.cria.apelido=txtPesquisaNomeAnimal.text;
		acasalamento.macho.apelido=txtPesquisaNomeAnimal.text;
		acasalamento.femea.apelido=txtPesquisaNomeAnimal.text;
	}

	if (txtPesquisaRegistroAnimal.text != "")
	{
		if (acasalamento.cria == null)
		{
			acasalamento.cria=new Animal;
		}
		if (acasalamento.macho == null)
		{
			acasalamento.macho=new Animal;
		}
		if (acasalamento.femea == null)
		{
			acasalamento.femea=new Animal;
		}
		acasalamento.cria.registro=txtPesquisaRegistroAnimal.text;
		acasalamento.macho.registro=txtPesquisaRegistroAnimal.text;
		acasalamento.femea.registro=txtPesquisaRegistroAnimal.text;
	}

	if (txtPesquisaPropriedade.text != "")
	{
		if (acasalamento.cria == null)
		{
			acasalamento.cria=new Animal;
		}
		if (acasalamento.macho == null)
		{
			acasalamento.macho=new Animal;
		}
		if (acasalamento.femea == null)
		{
			acasalamento.femea=new Animal;
		}
		acasalamento.cria.propriedade=propriedadePesquisa;
		acasalamento.macho.propriedade=propriedadePesquisa;
		acasalamento.femea.propriedade=propriedadePesquisa;
	}

	if (txtPesquisaPropriedade.text == "" && txtPesquisaProprietario.text != "")
	{
		if (acasalamento.cria == null)
		{
			acasalamento.cria=new Animal;
		}
		if (acasalamento.macho == null)
		{
			acasalamento.macho=new Animal;
		}
		if (acasalamento.femea == null)
		{
			acasalamento.femea=new Animal;
		}
		var prop:Propriedade=new Propriedade();
		var propetario:Usuario=proprietarioPesquisa;
		prop.proprietario=propetario;
		acasalamento.cria.propriedade=prop;
		acasalamento.macho.propriedade=prop;
		acasalamento.femea.propriedade=prop;
	}

	var dataInicio:Date=txtPesquisaDataInicio.selectedDate;
	var dataFim:Date=txtPesquisaDataFim.selectedDate;

	acasalamentoService.pesquisar(acasalamento, dataInicio, dataFim);
}

protected function btnClickSalvarEvento():void
{
	if (validar())
	{

		var evento:EventoAcasalamento=new EventoAcasalamento();
		switch (cmbEventoTipoEvento.selectedItem)
		{
			case "PROPOSTA":
				break;
			case "INSEMINACAO":
				evento.acasalamento=acasalamentoSelecionado;
				evento.comentario=StringUtil.trim(txtEventoComentario.text);
				evento.dataEvento=txtEventoData.selectedDate;
				evento.tipoEventoAcasalamento="INSEMINACAO";
				acasalamentoService.salvarEvento(evento);
				acasalamentoSelecionado.dataAcasalamento=evento.dataEvento;
				acasalamentoSelecionado.tipoAcasalamento="INSEMINACAO";
				acasalamentoService.salvar(acasalamentoSelecionado);
				break;
			case "FALHA_INSEMINACAO":
				evento.acasalamento=acasalamentoSelecionado;
				evento.comentario=StringUtil.trim(txtEventoComentario.text);
				evento.dataEvento=txtEventoData.selectedDate;
				evento.tipoEventoAcasalamento="FALHA_INSEMINACAO";
				acasalamentoService.salvarEvento(evento);
				acasalamentoSelecionado.tipoAcasalamento="FALHA_INSEMINACAO";
				acasalamentoService.salvar(acasalamentoSelecionado);
				break;
			case "PRENHA":
				evento.acasalamento=acasalamentoSelecionado;
				evento.comentario=StringUtil.trim(txtEventoComentario.text);
				evento.dataEvento=txtEventoData.selectedDate;
				evento.tipoEventoAcasalamento="PRENHA";
				acasalamentoService.salvarEvento(evento);
				acasalamentoSelecionado.tipoAcasalamento="PRENHA";
				acasalamentoService.salvar(acasalamentoSelecionado);
				break;
			case "ABORTO":
				evento.acasalamento=acasalamentoSelecionado;
				evento.comentario=StringUtil.trim(txtEventoComentario.text);
				evento.dataEvento=txtEventoData.selectedDate;
				evento.tipoEventoAcasalamento="ABORTO";
				acasalamentoService.salvarEvento(evento);
				acasalamentoSelecionado.tipoAcasalamento="ABORTO";
				acasalamentoService.salvar(acasalamentoSelecionado);
				break;
			case "NASCIMENTO":
				evento.acasalamento=acasalamentoSelecionado;
				evento.comentario=StringUtil.trim(txtEventoComentario.text);
				evento.dataEvento=txtEventoData.selectedDate;
				evento.tipoEventoAcasalamento="NASCIMENTO";
				acasalamentoService.salvarEvento(evento);
				acasalamentoSelecionado.tipoAcasalamento="NASCIMENTO";
				acasalamentoService.salvar(acasalamentoSelecionado);
				break;
			case "COMENTARIO":
				evento.acasalamento=acasalamentoSelecionado;
				evento.comentario=StringUtil.trim(txtEventoComentario.text);
				evento.dataEvento=txtEventoData.selectedDate;
				evento.tipoEventoAcasalamento="COMENTARIO";
				acasalamentoService.salvarEvento(evento);
				break;
		}
	}
}

protected function btnClickVoltarPesquisa():void
{
	currentState=ConstantesUtils.STATE_PESQUISA;
	init();
}

/**
 *	Fechar a tela de manter usuário
 *
 * @param event
 */
protected function fechar(event:CloseEvent):void
{
	// fecha tela de manter usuário
	PopUpManager.removePopUp(this);
}

protected function gridClickEvento(event:ListEvent):void
{

	// TODO FAZER METODO
}


protected function gridClickResultadoAcasalamento(event:ListEvent):void
{
	currentState=ConstantesUtils.STATE_DETALHE;

	acasalamentoSelecionado=event.currentTarget.selectedItem;

	acasalamentoService.pesquisarEvento(acasalamentoSelecionado);

	var df:DateFormatter=new DateFormatter();
	df.formatString="DD/MM/YYYY";

	txtDetalheFemea.text=acasalamentoSelecionado.femea.apelido;
	txtDetalheMacho.text=acasalamentoSelecionado.macho.apelido;
	txtDetalheCria.text=acasalamentoSelecionado.cria.apelido;
	txtDetalheDataAcasalamento.text=df.format(acasalamentoSelecionado.dataAcasalamento);
	txtDetalheStatusAcasalamento.text=acasalamentoSelecionado.tipoAcasalamento;

	PopUpManager.centerPopUp(this);
}


protected function init():void
{
	statusService.listarStatusAcasalamento();
}

protected function labelFunctionDataAcasalamento(item:Object, column:AdvancedDataGridColumn):String
{
	var dateFormat:DateFormatter=new DateFormatter();
	dateFormat.formatString="DD/MM/YYYY";

	return dateFormat.format(item.dataAcasalamento);
}

protected function labelFunctionDataEvento(item:Object, column:AdvancedDataGridColumn):String
{
	var dateFormat:DateFormatter=new DateFormatter();
	dateFormat.formatString="DD/MM/YYYY";

	return dateFormat.format(item.dataEvento);
}

protected function onFault(event:FaultEvent):void
{
	//Ocorreu uma falha ao chamar o servico. 
	Alert.show(event.fault.rootCause.message);
}

protected function serviceResultAcasalamentoPesquisar(event:ResultEvent):void
{
	// Recupera lista de animais
	var listaAcasalamento:ArrayCollection=event.result as ArrayCollection;

	// Altera estado da tela para "RESULTADO"
	currentState=ConstantesUtils.STATE_RESULTADO;

	// Atribui a lista de acasalamentos para a grid de resultado
	dataGridResultadoAcasalamento.dataProvider=listaAcasalamento;

	// Informa o número de registros encontrados 
	panelResultado.title=ConstantesUtils.RESULTADO_GRID + listaAcasalamento.length;
	PopUpManager.centerPopUp(this);

}

protected function serviceResultEventoAcasalamentoPesquisar(event:ResultEvent):void
{
	// Recupera lista de animais
	var listaEventoAcasalamento:ArrayCollection=event.result as ArrayCollection;

	// Atribui a lista de eventos para a grid de resultado
	dataGridEvento.dataProvider=listaEventoAcasalamento;

	statusService.listarStatusEventoAcasalamento();

	PopUpManager.centerPopUp(this);

}

protected function serviceResultEventoAcasalamentoSalvar(event:ResultEvent):void
{
	acasalamentoService.pesquisarEvento(acasalamentoSelecionado);
	PopUpManager.centerPopUp(this);
	txtEventoComentario.text=null;
	txtEventoComentario.errorString=null;
	cmbEventoTipoEvento.selectedIndex=-1;
	cmbEventoTipoEvento.selectedIndex=0;
	cmbEventoTipoEvento.errorString=null;
}

protected function serviceResultAcasalamentoSalvar(event:ResultEvent):void
{
	acasalamentoSelecionado=event.result as Acasalamento;

	statusService.listarStatusEventoAcasalamento();
	acasalamentoService.pesquisarEvento(acasalamentoSelecionado);

	var df:DateFormatter=new DateFormatter();
	df.formatString="DD/MM/YYYY";

	txtDetalheFemea.text=acasalamentoSelecionado.femea.apelido;
	txtDetalheMacho.text=acasalamentoSelecionado.macho.apelido;
	txtDetalheCria.text=acasalamentoSelecionado.cria.apelido;
	txtDetalheDataAcasalamento.text=df.format(acasalamentoSelecionado.dataAcasalamento);
	txtDetalheStatusAcasalamento.text=acasalamentoSelecionado.tipoAcasalamento;

	txtEventoComentario.text=null;
	txtEventoComentario.errorString=null;
	cmbEventoTipoEvento.selectedIndex=-1;
	cmbEventoTipoEvento.selectedIndex=0;
	cmbEventoTipoEvento.errorString=null;
	PopUpManager.centerPopUp(this);
}



protected function serviceResultListarStatusAcasalamento(event:ResultEvent):void
{
	var listaStatus:ArrayCollection=new ArrayCollection();
	listaStatus.addItem(ConstantesUtils.SELECIONE);
	listaStatus.addAll(event.result as ArrayCollection);

	cmbPesquisaStatusAcasalamento.dataProvider=listaStatus;
	cmbPesquisaStatusAcasalamento.selectedIndex=-1;
	cmbPesquisaStatusAcasalamento.selectedIndex=0

}

protected function serviceResultListarStatusEvento(event:ResultEvent):void
{
	var listaStatus:ArrayCollection=new ArrayCollection();
	listaStatus.addItem(ConstantesUtils.SELECIONE);
	listaStatus.addAll(event.result as ArrayCollection);


	listaStatus.removeItemAt(listaStatus.getItemIndex("PROPOSTA"));
	switch (acasalamentoSelecionado.tipoAcasalamento)
	{
		case "PROPOSTA":
			listaStatus.removeItemAt(listaStatus.getItemIndex("FALHA_INSEMINACAO"));
			listaStatus.removeItemAt(listaStatus.getItemIndex("PRENHA"));
			listaStatus.removeItemAt(listaStatus.getItemIndex("ABORTO"));
			listaStatus.removeItemAt(listaStatus.getItemIndex("NASCIMENTO"));
			break;
		case "INSEMINACAO":

			listaStatus.removeItemAt(listaStatus.getItemIndex("INSEMINACAO"));
			listaStatus.removeItemAt(listaStatus.getItemIndex("ABORTO"));
			listaStatus.removeItemAt(listaStatus.getItemIndex("NASCIMENTO"));
			break;
		case "FALHA_INSEMINACAO":
			listaStatus.removeItemAt(listaStatus.getItemIndex("FALHA_INSEMINACAO"));
			listaStatus.removeItemAt(listaStatus.getItemIndex("PRENHA"));
			listaStatus.removeItemAt(listaStatus.getItemIndex("ABORTO"));
			listaStatus.removeItemAt(listaStatus.getItemIndex("NASCIMENTO"));
			break;
		case "PRENHA":
			listaStatus.removeItemAt(listaStatus.getItemIndex("INSEMINACAO"));
			listaStatus.removeItemAt(listaStatus.getItemIndex("FALHA_INSEMINACAO"));
			listaStatus.removeItemAt(listaStatus.getItemIndex("PRENHA"));
			break;
		case "ABORTO":
			listaStatus.removeItemAt(listaStatus.getItemIndex("FALHA_INSEMINACAO"));
			listaStatus.removeItemAt(listaStatus.getItemIndex("PRENHA"));
			listaStatus.removeItemAt(listaStatus.getItemIndex("ABORTO"));
			listaStatus.removeItemAt(listaStatus.getItemIndex("NASCIMENTO"));
			break;
		case "NASCIMENTO":
			listaStatus.removeItemAt(listaStatus.getItemIndex("INSEMINACAO"));
			listaStatus.removeItemAt(listaStatus.getItemIndex("FALHA_INSEMINACAO"));
			listaStatus.removeItemAt(listaStatus.getItemIndex("PRENHA"));
			listaStatus.removeItemAt(listaStatus.getItemIndex("ABORTO"));
			listaStatus.removeItemAt(listaStatus.getItemIndex("NASCIMENTO"));
			break;
	}
	cmbEventoTipoEvento.dataProvider=listaStatus;
	cmbEventoTipoEvento.selectedIndex=-1;
	cmbEventoTipoEvento.selectedIndex=0



}

protected function validar():Boolean
{
	//executa todos os validadores
	var errors:Array=Validator.validateAll(validadores);

	//se não existem erros 
	if (errors.length == 0)
	{
		panelError.visible=false;
		return true;
	}
	else
	{
		errors[0].target.source.focusManager.setFocus(errors[0].target.source);
	}
	panelError.visible=true;

	return false;
}
