// login
import br.pucpr.sabrh.components.constantes.ConstantesUtils;
import br.pucpr.sabrh.entity.Municipio;
import br.pucpr.sabrh.entity.Propriedade;
import br.pucpr.sabrh.entity.Usuario;

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
import mx.validators.Validator;

import spark.components.TextInput;

var propriedadeNovo:Propriedade=null;;


/**
 * Preenche as combos ai iniciar.
 *
 * @param event
 */
protected function init(event:FlexEvent):void
{
	if (FlexGlobals.topLevelApplication.user.perfil == ConstantesUtils.PERFIL_PRODUTOR)
	{
		proprietarioNovo=FlexGlobals.topLevelApplication.user;
		proprietarioPesquisa=FlexGlobals.topLevelApplication.user;
		btnPesquisaBuscar.enabled=false;
		txtPesquisaProprietario.text=FlexGlobals.topLevelApplication.user.nome;
	}

	estadoService.listarEstados();
	txtPesquisaNome.focusManager.setFocus(txtPesquisaNome);

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
 * Evento botão de inserir usuário.
 *
 * @param event
 */
protected function actionBtnNovo():void
{

	currentState=ConstantesUtils.STATE_NOVO;
	actionBtnLimparNovo();

	PopUpManager.centerPopUp(this);

}



/**
 * Limpa dados de pesquisa.
 *
 * @param event
 */
protected function actionBtnLimparPesquisa():void
{
	currentState=ConstantesUtils.STATE_PESQUISA;
	txtPesquisaNome.text="";
	cmbPesquisaEstado.selectedIndex=-1;
	cmbPesquisaEstado.selectedIndex=0;
	cmbPesquisaMunicipio.selectedIndex=-1;
	cmbPesquisaMunicipio.selectedIndex=0;
	cmbPesquisaMunicipio.enabled=false;
	txtPesquisaProprietario.text="";
	proprietarioPesquisa=null;

	if (gridPropriedade != null)
	{
		gridPropriedade.dataProvider=null;
	}

	if (FlexGlobals.topLevelApplication.user.perfil == ConstantesUtils.PERFIL_PRODUTOR)
	{
		btnPesquisaBuscar.enabled=false;
		txtPesquisaProprietario.text=FlexGlobals.topLevelApplication.user.nome;
	}

	txtPesquisaNome.focusManager.setFocus(txtPesquisaNome);
	PopUpManager.centerPopUp(this);
}

/**
 * Limpa dados de novo.
 *
 */
protected function actionBtnLimparNovo():void
{
	txtNovoNome.text="";
	txtNovoTelefone.text="";
	txtNovoProprietario.text="";

	estadoService.listarEstados();

	txtNovoNome.errorString=null;
	txtNovoTelefone.errorString=null;
	txtNovoProprietario.errorString=null;
	cmbNovoMunicipio.errorString=null;
	cmbNovoEstado.errorString=null;

	if (currentState != ConstantesUtils.STATE_NOVO)
	{
		currentState=ConstantesUtils.STATE_NOVO;
	}

	if (FlexGlobals.topLevelApplication.user.perfil == ConstantesUtils.PERFIL_PRODUTOR)
	{
		btnNovoBuscar.enabled=false;
		txtNovoProprietario.text=FlexGlobals.topLevelApplication.user.nome;
	}

	panelError.visible=false;

	txtNovoNome.focusManager.setFocus(txtNovoNome);
}

/**
 * Ação do botão editar propriedade.
 * @param event
 */
protected function editarPropriedade():void
{
	currentState=ConstantesUtils.STATE_EDITAR;
	txtNovoNome.text=propriedadeSelecionada.nome;
	txtNovoProprietario.text=propriedadeSelecionada.proprietario.nome;
	txtNovoTelefone.text=telefoneFormatter.format(propriedadeSelecionada.telefone);
	if (FlexGlobals.topLevelApplication.user.perfil == ConstantesUtils.PERFIL_PRODUTOR)
	{
		btnNovoBuscar.enabled=false;
	}
	estadoService.listarEstados();
	PopUpManager.centerPopUp(this);
	panelSucesso.visible=false;
}

/**
 * Ação do botão voltar da pesquisa.
 * @param event
 */
protected function voltarPesquisa():void
{
	if (gridPropriedade == null)
	{
		currentState=ConstantesUtils.STATE_PESQUISA;
	}
	else
	{
		currentState=ConstantesUtils.STATE_RESULTADO;
		actionBtnPesquisar();
	}
	txtPesquisaNome.focusManager.setFocus(txtPesquisaNome);
	PopUpManager.centerPopUp(this);
	if (panelError != null)
	{
		panelError.visible=false;
	}

	if (panelSucesso != null)
	{
		panelSucesso.visible=false;
	}
}

/**
 * Ação do botão novo na tela de edição.
 * @param event
 */
protected function novoConfirmacao():void
{
	Alert.show("Tem certeza de sair sem salvar as alterações?", "Manutenção de Propriedades", Alert.YES | Alert.NO, this, novoConfirmacaoResult);
}

//Função para recuperar o resultado da confirmação.
protected function novoConfirmacaoResult(event:CloseEvent):void
{
	if (event.detail == Alert.YES)
	{
		actionBtnLimparNovo();
	}
}

/**
 * Ação do botão salvar usuário.
 */
protected function actionBtnSalvarPropriedade():void
{
	if (validar())
	{
		panelError.visible=false;
		propriedadeNovo=new Propriedade();
		propriedadeNovo.municipio=cmbNovoMunicipio.selectedItem;
		propriedadeNovo.nome=txtNovoNome.text;
		propriedadeNovo.proprietario=proprietarioNovo;
		propriedadeNovo.telefone=txtNovoTelefone.text;

		//retira mascara telefone
		propriedadeNovo.telefone=propriedadeNovo.telefone.replace("(", "");
		propriedadeNovo.telefone=propriedadeNovo.telefone.replace(")", "");
		propriedadeNovo.telefone=propriedadeNovo.telefone.replace("-", "");

		if (currentState == ConstantesUtils.STATE_EDITAR)
		{
			propriedadeNovo.codigo=propriedadeSelecionada.codigo;
		}

		propriedadeSelecionada=propriedadeNovo;
		
		propriedadeService.propriedadeExistente(propriedadeNovo);

	}
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
protected function pesquisarPropriedadesResult(event:ResultEvent):void
{
	var listaPropriedades:ArrayCollection=event.result as ArrayCollection;
	currentState=ConstantesUtils.STATE_RESULTADO;
	gridPropriedade.dataProvider=listaPropriedades;
	panelResultado.title=ConstantesUtils.RESULTADO_GRID + listaPropriedades.length;
	PopUpManager.centerPopUp(this);
}

/**
 * Resultado da pesquisa de propriedade existente
 *
 * @param event
 */
protected function propriedadeExistenteResult(event:ResultEvent):void
{
	var propriedadeExistente:Boolean=event.result;
	if (propriedadeExistente){
		txtNovoNome.errorString="Propriedade já existente na cidade.";
		panelError.visible=true;
	} else {
		propriedadeService.salvar(propriedadeNovo);
	}
}

/**
 * Resultado da inserção de propriedade
 *
 * @param event
 */
protected function salvarPropriedadeResult(event:ResultEvent):void
{
	currentState=ConstantesUtils.STATE_DETALHE;
	
	txtNovoNome.errorString=null;

	txtDetalheNome.text=propriedadeSelecionada.nome;
	txtDetalheProprietario.text=propriedadeSelecionada.proprietario.nome;
	txtDetalheTelefone.text=telefoneFormatter.format(propriedadeSelecionada.telefone);
	cmbDetalheEstado.text=propriedadeSelecionada.municipio.estado.descricao;
	cmbDetalheMunicipio.text=propriedadeSelecionada.municipio.descricao;

	PopUpManager.centerPopUp(this);
	panelSucesso.visible=true;
}

/**
 *	Resultado da listagem de municipios.
 * @param event
 */
protected function listarMunicipiosResult(event:ResultEvent):void
{
	var listaMunicipios:ArrayCollection=new ArrayCollection();
	listaMunicipios.addItem(ConstantesUtils.SELECIONE);
	listaMunicipios.addAll(event.result as ArrayCollection);


	if (currentState == ConstantesUtils.STATE_PESQUISA || currentState == ConstantesUtils.STATE_RESULTADO)
	{
		cmbPesquisaMunicipio.dataProvider=listaMunicipios;
		cmbPesquisaMunicipio.selectedIndex=-1;
		cmbPesquisaMunicipio.selectedIndex=0;
		cmbPesquisaMunicipio.enabled=true;
		cmbPesquisaMunicipio.errorString=null;
	}
	else
	{
		cmbNovoMunicipio.dataProvider=listaMunicipios;
		cmbNovoMunicipio.selectedIndex=-1;
		cmbNovoMunicipio.selectedIndex=0;
		cmbNovoMunicipio.enabled=true;
		if (currentState == ConstantesUtils.STATE_EDITAR)
		{
			for (var i:Number=1; i < cmbNovoMunicipio.dataProvider.length; i++)
			{
				if (cmbNovoMunicipio.dataProvider.getItemAt(i).codigo == propriedadeSelecionada.municipio.codigo)
				{
					cmbNovoMunicipio.selectedIndex=i;
				}
			}
		}
		cmbNovoMunicipio.errorString=null;
	}
}

/**
 * Resultado da listagem de estados
 *
 * @param event
 */
protected function listarEstadosResult(event:ResultEvent):void
{
	var listaEstados:ArrayCollection=new ArrayCollection();
	listaEstados.addItem(ConstantesUtils.SELECIONE);
	listaEstados.addAll(event.result as ArrayCollection);
	if (currentState == ConstantesUtils.STATE_PESQUISA || currentState == ConstantesUtils.STATE_RESULTADO)
	{
		cmbPesquisaEstado.dataProvider=listaEstados;
		cmbPesquisaEstado.selectedIndex=-1;
		cmbPesquisaEstado.selectedIndex=0;
		cmbPesquisaEstado.errorString=null;
	}
	else
	{
		cmbNovoEstado.dataProvider=listaEstados;
		cmbNovoEstado.selectedIndex=-1;
		cmbNovoEstado.selectedIndex=0;


		if (currentState == ConstantesUtils.STATE_EDITAR)
		{
			for (var i:Number=1; i < cmbNovoEstado.dataProvider.length; i++)
			{
				if (cmbNovoEstado.dataProvider.getItemAt(i).sigla == propriedadeSelecionada.municipio.estado.sigla)
				{
					cmbNovoEstado.selectedIndex=i;
				}
			}

		}
		cbmEstadoChange();
		cmbNovoEstado.errorString=null;
	}

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
	if (currentState == ConstantesUtils.STATE_PESQUISA || currentState == ConstantesUtils.STATE_RESULTADO)
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
	else
	{
		if (cmbNovoEstado.selectedIndex != 0)
		{
			municipioService.listarMunicipios(cmbNovoEstado.selectedItem);
		}
		else
		{
			cmbNovoMunicipio.enabled=false;
			cmbNovoMunicipio.dataProvider=null;
		}
	}

}

/**
 *
 * @param event
 */
protected function gridPropriedadeItemClick(event:ListEvent):void
{
	currentState=ConstantesUtils.STATE_DETALHE;

	propriedadeSelecionada=event.currentTarget.selectedItem;
	txtDetalheNome.text=propriedadeSelecionada.nome;
	txtDetalheProprietario.text=propriedadeSelecionada.proprietario.nome;
	txtDetalheTelefone.text=telefoneFormatter.format(propriedadeSelecionada.telefone);
	cmbDetalheEstado.text=propriedadeSelecionada.municipio.estado.descricao;
	cmbDetalheMunicipio.text=propriedadeSelecionada.municipio.descricao;
	proprietarioNovo=propriedadeSelecionada.proprietario;
	txtDetalheProprietario.text=proprietarioNovo.nome;

	PopUpManager.centerPopUp(this);
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
 * Validar formulário.
 * @return
 */
protected function validar():Boolean
{
	//executa todos os validadores
	var errors:Array=Validator.validateAll(val);

	//se não existem erros 
	if (errors.length == 0)
	{
		return true;

	}
	else
	{
		errors[0].target.source.focusManager.setFocus(errors[0].target.source);
		panelError.visible=true;
		return false;
	}
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

	if (tipoConsulta == "novo")
	{
		proprietarioNovo=usuario;
	}
	else if (tipoConsulta == "pesquisa")
	{
		proprietarioPesquisa=usuario;
	}
}