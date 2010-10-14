// login
import br.pucpr.sabrh.components.constantes.ConstantesUtils;
import br.pucpr.sabrh.entity.Municipio;
import br.pucpr.sabrh.entity.Usuario;

import flash.events.MouseEvent;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
import mx.core.FlexGlobals;
import mx.events.CloseEvent;
import mx.events.FlexEvent;
import mx.events.ListEvent;
import mx.managers.PopUpManager;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.utils.StringUtil;
import mx.validators.Validator;

private var usuarioSalvar:Usuario;

/**
 * Preenche as combos ai iniciar.
 *
 * @param event
 */
protected function init(event:FlexEvent):void
{
	if (FlexGlobals.topLevelApplication.user.perfil == "PRODUTOR")
	{
		setStateDetalheProdutor();
	}
	else
	{
		estadoService.listarEstados();
		statusService.listarStatus();
		perfilService.listarPerfil();
		txtPesquisaNome.focusManager.setFocus(txtPesquisaNome);
	}

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
 * Evento botão de inserir usuário.
 *
 * @param event
 */
protected function actionBtnNovo():void
{

	currentState="stateNovo";
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
 * Limpa dados de novo.
 *
 */
protected function actionBtnLimparNovo():void
{

	if (FlexGlobals.topLevelApplication.user.perfil == "PRODUTOR")
	{
		setStateDetalheProdutor();
	}
	else
	{
		estadoService.listarEstados();
		perfilService.listarPerfil();
		txtNovoNome.text="";
		txtNovoConfirmarSenha.text="";
		txtNovoCPF.text="";
		txtNovoLogin.text="";
		txtNovoSenha.text="";
		txtNovoEmail.text="";

		txtNovoNome.errorString=null;
		txtNovoConfirmarSenha.errorString=null;
		txtNovoCPF.errorString=null;
		txtNovoLogin.errorString=null;
		txtNovoSenha.errorString=null;
		txtNovoEmail.errorString=null;
		cmbNovoMunicipio.errorString=null;
		cmbNovoEstado.errorString=null;
		cmbNovoPerfil.errorString=null;
		txtNovoNome.focusManager.setFocus(txtNovoNome);

		if (currentState != "stateNovo")
		{
			currentState="stateNovo";
		}
		panelError.visible=false;
	}
}

/**
 * Ação do botão editar usuario.
 * @param event
 */
protected function editarUsuario():void
{
	currentState="stateEditar";
	txtNovoCPF.text=cpfFormatter.format(usuarioSelecionado.cpf);
	txtNovoConfirmarSenha.text=usuarioSelecionado.senha;
	txtNovoEmail.text=usuarioSelecionado.email;
	txtNovoLogin.text=usuarioSelecionado.login;
	txtNovoSenha.text=usuarioSelecionado.senha;
	txtNovoNome.text=usuarioSelecionado.nome;
	if (FlexGlobals.topLevelApplication.user.perfil == "PRODUTOR")
	{
		cmbNovoPerfil.enabled=false;
		cmbNovoStatus.enabled=false;
		btnNovoLimpar.label="Voltar";
		btnNovoVoltar.visible=false;
	}

	estadoService.listarEstados();
	perfilService.listarPerfil();
	statusService.listarStatus();

	PopUpManager.centerPopUp(this);

	panelSucesso.visible=false;
}

/**
 * Ação do botão voltar da pesquisa.
 * @param event
 */
protected function voltarPesquisa():void
{
	if (gridUsuario == null)
	{
		currentState='statePesquisa';
	}
	else
	{
		currentState='stateResultado';
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
	Alert.show("Tem certeza de sair sem salvar as alterações?", "Manutenção de Usuários", Alert.YES | Alert.NO, this, novoConfirmacaoResult);

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
protected function actionBtnSalvarUsuario():void
{

	if (validar())
	{
		panelError.visible=false;
		usuarioSalvar=new Usuario();
		usuarioSalvar.cpf=txtNovoCPF.text;
		usuarioSalvar.login=txtNovoLogin.text;
		usuarioSalvar.municipio=cmbNovoMunicipio.selectedItem;
		usuarioSalvar.nome=txtNovoNome.text;
		usuarioSalvar.senha=txtNovoSenha.text;
		usuarioSalvar.perfil=cmbNovoPerfil.selectedItem;
		usuarioSalvar.email=txtNovoEmail.text;
		usuarioSalvar.status="ATIVO";

		//retira mascara cpf
		usuarioSalvar.cpf=usuarioSalvar.cpf.replace(".", "");
		usuarioSalvar.cpf=usuarioSalvar.cpf.replace(".", "");
		usuarioSalvar.cpf=usuarioSalvar.cpf.replace("-", "");

		if (currentState == 'stateEditar')
		{
			usuarioSalvar.codigo=usuarioSelecionado.codigo;
			usuarioSalvar.status=cmbNovoStatus.selectedItem;

		}

		if (usuarioSelecionado.senha == null)
		{
			usuarioSelecionado.senha="";
		}

		usuarioService.criptografar(usuarioSalvar.senha, usuarioSelecionado.senha);

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
protected function pesquisarUsuariosResult(event:ResultEvent):void
{
	var listaUsuarios:ArrayCollection=event.result as ArrayCollection;
	currentState='stateResultado';
	gridUsuario.dataProvider=listaUsuarios;
	panelResultado.title=ConstantesUtils.RESULTADO_GRID + listaUsuarios.length;
	PopUpManager.centerPopUp(this);
}

/**
 * Resultado da inserção de usuários
 *
 * @param event
 */
protected function inserirUsuarioResult(event:ResultEvent):void
{
	currentState='stateDetalhe';

	panelSucesso.visible=true;

	usuarioSelecionado=event.result as Usuario;

	txtDetalheCPF.text=cpfFormatter.format(usuarioSelecionado.cpf);
	txtDetalheEmail.text=usuarioSelecionado.email;
	txtDetalheLogin.text=usuarioSelecionado.login;
	txtDetalheNome.text=usuarioSelecionado.nome;
	cmbDetalheEstado.text=usuarioSelecionado.municipio.estado.descricao;
	cmbDetalheMunicipio.text=usuarioSelecionado.municipio.descricao;
	cmbDetalhePerfil.text=usuarioSelecionado.perfil;

	PopUpManager.centerPopUp(this);

	if (FlexGlobals.topLevelApplication.user.codigo == usuarioSelecionado.codigo)
	{
		FlexGlobals.topLevelApplication.user=usuarioSelecionado;
	}
}

/**
 * Resultado da criptografia da senha do usuário
 *
 * @param event
 */
protected function criptografarUsuarioResult(event:ResultEvent):void
{
	var senhaCriptografada:String=event.result as String;

	usuarioSalvar.senha=senhaCriptografada;

	usuarioSelecionado=usuarioSalvar;

	usuarioService.inserir(usuarioSalvar);
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


	if (currentState == 'statePesquisa' || currentState == 'stateResultado')
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
		if (currentState == 'stateEditar')
		{
			for (var i:Number=1; i < cmbNovoMunicipio.dataProvider.length; i++)
			{
				if (cmbNovoMunicipio.dataProvider.getItemAt(i).codigo == usuarioSelecionado.municipio.codigo)
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
	listaEstados.addItem("Selecione...");
	listaEstados.addAll(event.result as ArrayCollection);
	if (currentState == 'statePesquisa' || currentState == 'stateResultado')
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

		if (currentState == 'stateEditar')
		{
			for (var i:Number=1; i < cmbNovoEstado.dataProvider.length; i++)
			{
				if (cmbNovoEstado.dataProvider.getItemAt(i).sigla == usuarioSelecionado.municipio.estado.sigla)
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
 * Resultado da listagem de perfil.
 *
 * @param event
 */
protected function listarPerfilResult(event:ResultEvent):void
{
	var listaPerfil:ArrayCollection=new ArrayCollection();
	listaPerfil.addItem("Selecione...");
	listaPerfil.addAll(event.result as ArrayCollection);

	if (currentState == 'statePesquisa')
	{
		cmbPesquisaPerfil.dataProvider=listaPerfil;
		cmbPesquisaPerfil.selectedIndex=-1;
		cmbPesquisaPerfil.selectedIndex=0;
	}
	else
	{
		cmbNovoPerfil.dataProvider=listaPerfil;
		cmbNovoPerfil.selectedIndex=-1;
		cmbNovoPerfil.selectedIndex=0;

		if (currentState == 'stateEditar')
		{
			cmbNovoPerfil.selectedItem=usuarioSelecionado.perfil;
		}
		cmbNovoPerfil.errorString=null;
	}
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

	if (currentState == 'statePesquisa')
	{
		cmbPesquisaStatus.dataProvider=listaStatus;
		cmbPesquisaStatus.selectedIndex=-1;
		cmbPesquisaStatus.selectedIndex=0

	}
	else
	{
		cmbNovoStatus.dataProvider=listaStatus;
		cmbNovoStatus.selectedIndex=-1;
		cmbNovoStatus.selectedIndex=0;

		if (currentState == 'stateEditar')
		{
			cmbNovoStatus.selectedItem=usuarioSelecionado.status;
		}
		cmbNovoStatus.errorString=null;
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
	if (currentState == 'statePesquisa' || currentState == 'stateResultado')
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
protected function gridUsuarioItemClick(event:ListEvent):void
{
	currentState='stateDetalhe';

	usuarioSelecionado=event.currentTarget.selectedItem;
	txtDetalheCPF.text=cpfFormatter.format(usuarioSelecionado.cpf);
	txtDetalheEmail.text=usuarioSelecionado.email;
	txtDetalheLogin.text=usuarioSelecionado.login;
	txtDetalheNome.text=usuarioSelecionado.nome;
	cmbDetalheEstado.text=usuarioSelecionado.municipio.estado.descricao;
	cmbDetalheMunicipio.text=usuarioSelecionado.municipio.descricao;
	cmbDetalhePerfil.text=usuarioSelecionado.perfil;

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
	if (event.fault.rootCause.message == "Erro ao salvar.\n Dados já foram cadastrados para outro usuário.")
	{
		//ToolTipUtil.createToolTip(txtNovoCPF, "Dados já foram cadastrados para outro usuário", iconInf, true, ToolTipUtil.RIGHT, 5000);
		//ToolTipUtil.createToolTip(txtNovoLogin, "Dados já foram cadastrados para outro usuário", iconInf, true, ToolTipUtil.RIGHT, 5000);
	}
	else
	{
		Alert.show(event.fault.rootCause.message);
	}
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
		if (txtNovoConfirmarSenha.text == txtNovoSenha.text)
		{
			return true;
		}
		else
		{
			txtNovoConfirmarSenha.errorString="Senhas não coicidem";
			txtNovoConfirmarSenha.focusManager.setFocus(txtNovoConfirmarSenha);
		}
	}
	else
	{
		errors[0].target.source.focusManager.setFocus(errors[0].target.source);
	}
	panelError.visible=true;

	return false;
}

/**
 * Metodo para setar apenas a visualização de Detalhes para usuário com perfil de Produtor
 *
 * @param item
 * @param column
 * @return
 */
protected function setStateDetalheProdutor():void
{
	currentState='stateDetalhe';

	usuarioSelecionado=FlexGlobals.topLevelApplication.user;
	txtDetalheCPF.text=cpfFormatter.format(usuarioSelecionado.cpf);
	txtDetalheEmail.text=usuarioSelecionado.email;
	txtDetalheLogin.text=usuarioSelecionado.login;
	txtDetalheNome.text=usuarioSelecionado.nome;
	cmbDetalheEstado.text=usuarioSelecionado.municipio.estado.descricao;
	cmbDetalheMunicipio.text=usuarioSelecionado.municipio.descricao;
	cmbDetalhePerfil.text=usuarioSelecionado.perfil;
	btnDetalheVoltar.visible=false;
	PopUpManager.centerPopUp(this);
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
