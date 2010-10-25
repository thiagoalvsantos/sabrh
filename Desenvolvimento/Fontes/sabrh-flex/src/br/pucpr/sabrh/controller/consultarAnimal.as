import br.pucpr.sabrh.components.constantes.ConstantesUtils;
import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.Municipio;
import br.pucpr.sabrh.entity.Propriedade;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.core.FlexGlobals;
import mx.events.CloseEvent;
import mx.events.FlexEvent;
import mx.events.ListEvent;
import mx.managers.PopUpManager;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.utils.StringUtil;

protected function btnClickConsultarPropriedade(atributo:TextInput, tipoConsulta:String):void
{
	var popUpConsultarPropriedade:consultarPropriedade=consultarPropriedade(PopUpManager.createPopUp(this.parent, consultarPropriedade, true));
	popUpConsultarPropriedade.janelaOrigem=this;
	popUpConsultarPropriedade.tipoConsulta=tipoConsulta;
	popUpConsultarPropriedade.atributoDestino=atributo;
	if (txtPesquisaProprietario.text != "")
	{
		popUpConsultarPropriedade.proprietarioPesquisa=proprietarioPesquisa;
		popUpConsultarPropriedade.btnPesquisaBuscar.enabled=false;
		popUpConsultarPropriedade.txtPesquisaProprietario.text=txtPesquisaProprietario.text;
	}
	PopUpManager.centerPopUp(popUpConsultarPropriedade);
	FlexGlobals.topLevelApplication.popUpEffect.target=popUpConsultarPropriedade;
	FlexGlobals.topLevelApplication.popUpEffect.play();
}


protected function btnClickConsultarUsuario(atributo:TextInput, tipoConsulta:String):void
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
 * Limpa dados de pesquisa.
 *
 * @param event
 */
protected function btnClickLimparPesquisa():void
{
	currentState=ConstantesUtils.STATE_PESQUISA;

	txtPesquisaNomeAnimal.text=null;
	txtPesquisaNomeMae.text=null;
	txtPesquisaNomePai.text=null;
	txtPesquisaPropriedade.text=null;
	txtPesquisaProprietario.text=null;
	txtPesquisaRegistroAnimal.text=null;
	txtPesquisaRegistroMae.text=null;
	txtPesquisaRegistroPai.text=null;
	if (dataGridResultado != null)
	{
		dataGridResultado.dataProvider=null;
	}

	if (FlexGlobals.topLevelApplication.user.perfil == ConstantesUtils.PERFIL_PRODUTOR)
	{
		proprietarioPesquisa=FlexGlobals.topLevelApplication.user;
		btnPesquisaBuscar.enabled=false;
		txtPesquisaProprietario.text=FlexGlobals.topLevelApplication.user.nome;
	}

	txtPesquisaRegistroAnimal.focusManager.setFocus(txtPesquisaRegistroAnimal);
	PopUpManager.centerPopUp(this);
}

protected function btnClickPesquisar():void
{
	var ani:Animal=new Animal();

	if (StringUtil.trim(txtPesquisaRegistroAnimal.text) != "")
	{
		ani.registro=txtPesquisaRegistroAnimal.text;
	}

	if (StringUtil.trim(txtPesquisaNomeAnimal.text) != "")
	{
		ani.nome=txtPesquisaNomeAnimal.text;
	}

	if (StringUtil.trim(txtPesquisaRegistroPai.text) != "")
	{
		if (ani.pai == null)
		{
			ani.pai=new Animal();
		}
		ani.pai.registro=txtPesquisaRegistroPai.text;
	}

	if (StringUtil.trim(txtPesquisaNomePai.text) != "")
	{
		if (ani.pai == null)
		{
			ani.pai=new Animal();
		}
		ani.pai.nome=txtPesquisaNomePai.text;
	}

	if (StringUtil.trim(txtPesquisaRegistroMae.text) != "")
	{
		if (ani.mae == null)
		{
			ani.mae=new Animal();
		}
		ani.mae.registro=txtPesquisaRegistroMae.text;
	}

	if (StringUtil.trim(txtPesquisaNomeMae.text) != "")
	{
		if (ani.mae == null)
		{
			ani.mae=new Animal();
		}
		ani.mae.nome=txtPesquisaNomeMae.text;
	}

	if (txtPesquisaProprietario.text != "")
	{
		ani.propriedade.proprietario=proprietarioPesquisa;
	}

	if (txtPesquisaPropriedade.text != "")
	{
		ani.propriedade=propriedadePesquisa;
	}

	if (checkBoxFemea.selected)
	{
		ani.sexo=ConstantesUtils.SEXO_FEMEA;
		if (checkBoxMacho.selected)
		{
			ani.sexo=null;
		}
	}
	else if (checkBoxMacho)
	{
		ani.sexo=ConstantesUtils.SEXO_MACHO;
	}

	animalService.pesquisar(ani);
}

protected function fechar(event:CloseEvent):void
{
	// fecha tela de consultar propriedade
	PopUpManager.removePopUp(this);
}

/**
 *
 * @param event
 */
protected function gridResultadoItemClick(event:ListEvent):void
{
	var ani:Animal=event.itemRenderer.data as Animal;

	janelaOrigem.resultConsultarAnimal(atributoDestino, tipoConsulta, tipoAnimal, ani);

	PopUpManager.removePopUp(this);
}


/**
 * Preenche as combos ao iniciar.
 *
 * @param event
 */
protected function init(event:FlexEvent):void
{
	if (FlexGlobals.topLevelApplication.user.perfil == ConstantesUtils.PERFIL_PRODUTOR)
	{
		proprietarioPesquisa=FlexGlobals.topLevelApplication.user;
		btnPesquisaBuscar.enabled=false;
		txtPesquisaProprietario.text=FlexGlobals.topLevelApplication.user.nome;
	}

	if (tipoAnimal == ConstantesUtils.SEXO_MACHO)
	{
		checkBoxMacho.selected=true;
		checkBoxMacho.enabled=false;
		checkBoxFemea.selected=false;
		checkBoxFemea.enabled=false;
	}
	if (tipoAnimal == ConstantesUtils.SEXO_FEMEA)
	{
		checkBoxMacho.selected=false;
		checkBoxMacho.enabled=false;
		checkBoxFemea.selected=true;
		checkBoxFemea.enabled=false;
	}
	txtPesquisaRegistroAnimal.focusManager.setFocus(txtPesquisaRegistroAnimal);
}


/**
 * //////////////////////////////////////////////////////
 *
 * 	Utils
 *
 * //////////////////////////////////////////////////////
 * /


   /**
 * Falha ao invocar serviço
 *
 * @param event
 */
protected function onFault(event:FaultEvent):void
{
	//Ocorreu uma falha ao chamar o servico. 
	Alert.show(event.fault.rootCause.message);
}

/**
 * //////////////////////////////////////////////////////
 *
 * 	Resultado de serviços
 *
 * //////////////////////////////////////////////////////
 * /

   /**
 *
 *	Resultado da pesquisa de propriedades.
 *
 * @param event
 */
protected function serviceResultPesquisarAnimal(event:ResultEvent):void
{
	var listaAnimais:ArrayCollection=event.result as ArrayCollection;
	currentState=ConstantesUtils.STATE_RESULTADO;
	dataGridResultado.dataProvider=listaAnimais;
	panelResultado.title=ConstantesUtils.RESULTADO_GRID + listaAnimais.length;
	PopUpManager.centerPopUp(this);
}
