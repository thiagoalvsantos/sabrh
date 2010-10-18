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
import br.pucpr.sabrh.components.constantes.ConstantesUtils;
import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.Municipio;
import br.pucpr.sabrh.entity.Propriedade;

public function abrirConsultarPropriedade(atributo:TextInput, tipoConsulta:String):void
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

public function abrirConsultarUsuario(atributo:TextInput, tipoConsulta:String):void
{
	var popUpConsultarUsuario:consultarUsuario=consultarUsuario(PopUpManager.createPopUp(this.parent, consultarUsuario, true));
	popUpConsultarUsuario.janelaOrigem=this;
	popUpConsultarUsuario.tipoConsulta=tipoConsulta;
	popUpConsultarUsuario.atributoDestino=atributo;
	PopUpManager.centerPopUp(popUpConsultarUsuario);
	FlexGlobals.topLevelApplication.popUpEffect.target=popUpConsultarUsuario;
	FlexGlobals.topLevelApplication.popUpEffect.play();
}


public function btnClickConsultarUsuario(atributo:TextInput, tipoConsulta:String):void
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
	currentState='statePesquisa';

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

	//TODO IMPLEMENTAR REGRAS
//	if (FlexGlobals.topLevelApplication.user.perfil == "PRODUTOR")
//	{
//		btnPesquisaBuscar.enabled=false;
//		txtPesquisaProprietario.text=FlexGlobals.topLevelApplication.user.nome;
//	}

	txtPesquisaRegistroAnimal.focusManager.setFocus(txtPesquisaRegistroAnimal);
	PopUpManager.centerPopUp(this);
}

protected function btnClickPesquisar():void
{
	var ani:Animal=new Animal();

//	if (StringUtil.trim(txtPesquisaNome.text) != "")
//	{
//		prop.nome=StringUtil.trim(txtPesquisaNome.text);
//	}
//
//	if (cmbPesquisaMunicipio.selectedIndex == 0 && cmbPesquisaEstado.selectedIndex != 0)
//	{
//		var mun:Municipio=new Municipio;
//		mun.estado=cmbPesquisaEstado.selectedItem;
//		prop.municipio=mun;
//	}
//
//	if (cmbPesquisaMunicipio.selectedIndex != 0)
//	{
//		prop.municipio=cmbPesquisaMunicipio.selectedItem;
//	}
//
//	if (txtPesquisaProprietario.text != "")
//	{
//		prop.proprietario=proprietarioPesquisa;
//	}

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
	atributoDestino.text=ani.nome;

	if (tipoConsulta == "novo")
	{
		if (tipoConsulta == "pai")
		{
			janelaOrigem.paiNovo=ani;
		}
		else if (tipoConsulta == "mae")
		{
			janelaOrigem.maeNovo=ani;
		}
	}
	else
	{
		if (tipoConsulta == "pesquisa")
		{
			if (tipoConsulta == "pai")
			{
				janelaOrigem.paiPesquisa=ani;
			}
			else if (tipoConsulta == "mae")
			{
				janelaOrigem.maePesquisa=ani;
			}
		}
	}
	PopUpManager.removePopUp(this);
}


/**
 * Preenche as combos ao iniciar.
 *
 * @param event
 */
protected function init(event:FlexEvent):void
{
	if (FlexGlobals.topLevelApplication.user.perfil == "PRODUTOR")
	{
		proprietarioPesquisa=FlexGlobals.topLevelApplication.user;
		btnPesquisaBuscar.enabled=false;
		txtPesquisaProprietario.text=FlexGlobals.topLevelApplication.user.nome;
	}

	if (tipoAnimal == 'pai')
	{
		checkBoxMacho.selected=true;
		checkBoxMacho.enabled=false;
		checkBoxFemea.selected=false;
		checkBoxFemea.enabled=false;
	}
	if (tipoAnimal == 'mae')
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
	currentState='stateResultado';
	dataGridResultado.dataProvider=listaAnimais;
	panelResultado.title=ConstantesUtils.RESULTADO_GRID + listaAnimais.length;
	PopUpManager.centerPopUp(this);
}
