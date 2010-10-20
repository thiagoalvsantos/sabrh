// login
import br.pucpr.sabrh.components.constantes.ConstantesUtils;
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
	
	estadoService.listarEstados();
	txtPesquisaNome.focusManager.setFocus(txtPesquisaNome);
}

/**
 *	Fechar a tela de consultar propriedade
 *
 * @param event
 */
protected function fechar(event:CloseEvent):void
{
	// fecha tela de consultar propriedade
	PopUpManager.removePopUp(this);
}

/**
 * //////////////////////////////////////////////////////
 *
 * 	Eventos de botões
 *
 * //////////////////////////////////////////////////////
 * /
 
/**
 *	Evento botão de pesquisar propriedades.
 *
 * @param event
 */
protected function actionBtnPesquisar():void
{
	var prop:Propriedade=new Propriedade();
	
	if (StringUtil.trim(txtPesquisaNome.text) != "")
	{
		prop.nome=StringUtil.trim(txtPesquisaNome.text);
	}
	
	if (cmbPesquisaMunicipio.selectedIndex == 0 && cmbPesquisaEstado.selectedIndex != 0)
	{
		var mun:Municipio=new Municipio;
		mun.estado=cmbPesquisaEstado.selectedItem;
		prop.municipio=mun;
	}
	
	if (cmbPesquisaMunicipio.selectedIndex != 0)
	{
		prop.municipio=cmbPesquisaMunicipio.selectedItem;
	}
	
	if (txtPesquisaProprietario.text != "")
	{
		prop.proprietario=proprietarioPesquisa;
	}
	
	propriedadeService.pesquisar(prop);
}

/**
 * Limpa dados de pesquisa.
 *
 * @param event
 */
protected function actionBtnLimparPesquisa():void
{
	currentState='statePesquisa';
	txtPesquisaNome.text="";
	cmbPesquisaEstado.selectedIndex=-1;
	cmbPesquisaEstado.selectedIndex=0;
	cmbPesquisaMunicipio.selectedIndex=-1;
	cmbPesquisaMunicipio.selectedIndex=0;
	cmbPesquisaMunicipio.enabled=false;
	
	if (btnPesquisaBuscar.enabled)
	{
		txtPesquisaProprietario.text="";
		proprietarioPesquisa=null;
	}
	
	if (gridPropriedade != null)
	{
		gridPropriedade.dataProvider=null;
	}
	
	txtPesquisaNome.focusManager.setFocus(txtPesquisaNome);
	PopUpManager.centerPopUp(this);
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
protected function pesquisarPropriedadesResult(event:ResultEvent):void
{
	var listaPropriedades:ArrayCollection=event.result as ArrayCollection;
	currentState='stateResultado';
	gridPropriedade.dataProvider=listaPropriedades;
	panelResultado.title=ConstantesUtils.RESULTADO_GRID + listaPropriedades.length;
	PopUpManager.centerPopUp(this);
}

/**
 *	Resultado da listagem de municipios.
 * @param event
 */
protected function listarMunicipiosResult(event:ResultEvent):void
{
	var listaMunicipios:ArrayCollection=new ArrayCollection();
	listaMunicipios.addItem("Selecione...");
	listaMunicipios.addAll(event.result as ArrayCollection);
	
	
	cmbPesquisaMunicipio.dataProvider=listaMunicipios;
	cmbPesquisaMunicipio.selectedIndex=-1;
	cmbPesquisaMunicipio.selectedIndex=0;
	cmbPesquisaMunicipio.enabled=true;
	cmbPesquisaMunicipio.errorString=null;
}

/**
 * Resultado da listagem de estados
 *
 * @param event
 */
protected function listarEstadosResult(event:ResultEvent):void
{
	var listaEstados:ArrayCollection=new ArrayCollection();
	listaEstados.addItem("Selecione...");
	listaEstados.addAll(event.result as ArrayCollection);
	cmbPesquisaEstado.dataProvider=listaEstados;
	cmbPesquisaEstado.selectedIndex=-1;
	cmbPesquisaEstado.selectedIndex=0;
	cmbPesquisaEstado.errorString=null;
}

/**
 * //////////////////////////////////////////////////////
 *
 * 	Eventos de componentes.
 *
 * //////////////////////////////////////////////////////
 * /
 
/**
 * Evento de seleção de estado
 *
 * @param event
 */
protected function cbmEstadoChange():void
{
	if (cmbPesquisaEstado.selectedIndex != 0)
	{
		municipioService.listarMunicipios(cmbPesquisaEstado.selectedItem);
	}
	else
	{
		cmbPesquisaMunicipio.enabled=false;
		cmbPesquisaMunicipio.dataProvider=null;
	}
	
}

/**
 *
 * @param event
 */
protected function gridPropriedadeItemClick(event:ListEvent):void
{
	var prop:Propriedade=event.itemRenderer.data as Propriedade;
	
	janelaOrigem.resultConsultarPropriedade(atributoDestino, tipoConsulta, prop);
	
	PopUpManager.removePopUp(this);
}

//Função para abrir a tela de Consultar Usuários.
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

//Função que recebe o retorno da consulta de Usuário.
public function resultConsultarUsuario(atributoDestino:TextInput, tipoConsulta:String, usuario:Usuario):void
{
	atributoDestino.text=usuario.nome;
	
	if (tipoConsulta == "pesquisa")
	{
		proprietarioPesquisa=usuario;
	}
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