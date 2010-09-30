// login
import br.pucpr.sabrh.entity.Municipio;
import br.pucpr.sabrh.entity.Usuario;
import br.pucpr.sabrh.view.manterPropriedade;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
import mx.controls.dataGridClasses.DataGridColumn;
import mx.events.CloseEvent;
import mx.events.FlexEvent;
import mx.events.ListEvent;
import mx.managers.PopUpManager;
import mx.messaging.errors.NoChannelAvailableError;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.utils.StringUtil;
import mx.validators.Validator;

import spark.events.IndexChangeEvent;


/**
 * Preenche as combos ai iniciar.
 *
 * @param event
 */
protected function init(event:FlexEvent):void
{

	estadoService.listarEstados();
	statusService.listarStatus();
	perfilService.listarPerfil();

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

/**
 * //////////////////////////////////////////////////////
 *
 * 	Eventos de botões
 *
 * //////////////////////////////////////////////////////
 * /

   /**
 *	Evento botão de pesquisar usuários.
 *
 * @param event
 */
protected function actionBtnPesquisar():void
{
	var usr:Usuario=new Usuario();
	if (StringUtil.trim(txtPesquisaNome.text) != "")
	{
		usr.nome=StringUtil.trim(txtPesquisaNome.text);
	}

	if (cmbPesquisaMunicipio.selectedIndex == 0 && cmbPesquisaEstado.selectedIndex != 0)
	{
		var mun:Municipio=new Municipio;
		mun.estado=cmbPesquisaEstado.selectedItem;
		usr.municipio=mun;
	}

	if (cmbPesquisaMunicipio.selectedIndex != 0)
	{
		usr.municipio=cmbPesquisaMunicipio.selectedItem;
	}
	usr.perfil=cmbPesquisaPerfil.selectedItem;
	usr.status=cmbPesquisaStatus.selectedItem;

	usuarioService.pesquisar(usr);
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
	cmbPesquisaPerfil.selectedIndex=-1;
	cmbPesquisaPerfil.selectedIndex=0;
	cmbPesquisaStatus.selectedIndex=-1;
	cmbPesquisaStatus.selectedIndex=0;
	if (gridUsuario != null)
	{
		gridUsuario.dataProvider=null;
	}
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
 *	Resultado da pesquisa de usuários.
 *
 * @param event
 */
protected function pesquisarUsuariosResult(event:ResultEvent):void
{
	var listaUsuarios:ArrayCollection=event.result as ArrayCollection;
	if (listaUsuarios != null && listaUsuarios.length != 0)
	{
		currentState='stateResultado';
		gridUsuario.dataProvider=listaUsuarios;
		PopUpManager.centerPopUp(this);
	}
	else
	{
		currentState="statePesquisa";
		if (gridUsuario != null)
		{
			gridUsuario.dataProvider=null;
		}
		PopUpManager.centerPopUp(this);
		Alert.show("Não foram encontrados resultados com os parâmentros informados", "Erro");
	}
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
 * Resultado da listagem de perfil.
 *
 * @param event
 */
protected function listarPerfilResult(event:ResultEvent):void
{
	var listaPerfil:ArrayCollection=new ArrayCollection();
	listaPerfil.addItem("Selecione...");
	listaPerfil.addAll(event.result as ArrayCollection);

	cmbPesquisaPerfil.dataProvider=listaPerfil;
	cmbPesquisaPerfil.selectedIndex=-1;
	cmbPesquisaPerfil.selectedIndex=0;
}

/**
 * Resultado da listagem de status.
 *
 * @param event
 */
protected function listarStatusResult(event:ResultEvent):void
{
	var listaStatus:ArrayCollection=new ArrayCollection();
	listaStatus.addItem("Selecione...");
	listaStatus.addAll(event.result as ArrayCollection);

	cmbPesquisaStatus.dataProvider=listaStatus;
	cmbPesquisaStatus.selectedIndex=-1;
	cmbPesquisaStatus.selectedIndex=0
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
protected function gridUsuarioItemClick(event:ListEvent):void
{
	var usr:Usuario=event.itemRenderer.data as Usuario;
	atributoDestino.text=usr.nome;
	var pai:manterPropriedade=janelaOrigem as manterPropriedade;

	if (tipoConsulta == "novo")
	{
		pai.usuarioNovo=usr;
	}
	else
	{
		if (tipoConsulta == "pesquisa")
		{
			pai.usuarioPesquisa=usr;
		}
	}
	PopUpManager.removePopUp(this);
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
 *
 * @param item
 * @param column
 * @return
 */
protected function cpflabelFunc(item:Object, column:AdvancedDataGridColumn):String
{
	return cpfFormatter.format(item.cpf);
}
