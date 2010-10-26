import br.pucpr.sabrh.components.constantes.ConstantesUtils;
import br.pucpr.sabrh.entity.Acasalamento;
import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.Propriedade;
import br.pucpr.sabrh.entity.Usuario;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.core.FlexGlobals;
import mx.events.CloseEvent;
import mx.formatters.DateFormatter;
import mx.managers.PopUpManager;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;


protected function init():void{
	statusService.listarStatusAcasalamento();
}
protected function onFault(event:FaultEvent):void
{
	//Ocorreu uma falha ao chamar o servico. 
	Alert.show(event.fault.rootCause.message);
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

protected function serviceResultAcasalamentoPesquisar(event:ResultEvent):void
{
	// Recupera lista de animais
	var listaAcasalamento:ArrayCollection=event.result as ArrayCollection;

	// Altera estado da tela para "RESULTADO"
	currentState=ConstantesUtils.STATE_RESULTADO;

	// Atribui a lista de animais para a grid de resultado
	dataGridResultadoAcasalamento.dataProvider=listaAcasalamento;

	// Informa o número de registros encontrados 
	panelResultado.title=ConstantesUtils.RESULTADO_GRID + listaAcasalamento.length;
	PopUpManager.centerPopUp(this);

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

//Função que recebe o retorno da consulta de Propriedade.
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

protected function labelFunctionDataAcasalamento(item:Object, column:AdvancedDataGridColumn):String
{
	var dateFormat:DateFormatter=new DateFormatter();
	dateFormat.formatString="DD/MM/YYYY";

	return dateFormat.format(item.dataAcasalamento);
}

protected function serviceResultListarStatusAcasalamento(event:ResultEvent):void
{
	var listaStatus:ArrayCollection=new ArrayCollection();
	listaStatus.addItem(ConstantesUtils.SELECIONE);
	listaStatus.addAll(event.result as ArrayCollection);
	
	if (currentState == ConstantesUtils.STATE_PESQUISA)
	{
		cmbPesquisaStatusAcasalamento.dataProvider=listaStatus;
		cmbPesquisaStatusAcasalamento.selectedIndex=-1;
		cmbPesquisaStatusAcasalamento.selectedIndex=0
		
	}
//	else
//	{
//		cmbNovoStatus.dataProvider=listaStatus;
//		cmbNovoStatus.selectedIndex=-1;
//		cmbNovoStatus.selectedIndex=0;
//		
//		if (currentState == ConstantesUtils.STATE_EDITAR)
//		{
//			cmbNovoStatus.selectedItem=usuarioSelecionado.status;
//		}
//		cmbNovoStatus.errorString=null;
//	}
}
