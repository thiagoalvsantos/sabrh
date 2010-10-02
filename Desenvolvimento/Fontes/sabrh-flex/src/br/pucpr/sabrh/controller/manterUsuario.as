// login
import br.pucpr.sabrh.entity.Municipio;
import br.pucpr.sabrh.entity.Usuario;

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
	txtNovoNome.text="";
	txtNovoConfirmarSenha.text="";
	txtNovoCPF.text="";
	txtNovoLogin.text="";
	txtNovoSenha.text="";
	txtNovoEmail.text="";
	estadoService.listarEstados();
	perfilService.listarPerfil();

	txtNovoNome.errorString=null;
	txtNovoConfirmarSenha.errorString=null;
	txtNovoCPF.errorString=null;
	txtNovoLogin.errorString=null;
	txtNovoSenha.errorString=null;
	txtNovoEmail.errorString=null;
	cmbNovoMunicipio.errorString=null;
	cmbNovoEstado.errorString=null;
	cmbNovoPerfil.errorString=null;

	if (currentState != "stateNovo")
	{
		currentState="stateNovo";
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

	estadoService.listarEstados();
	perfilService.listarPerfil();
	statusService.listarStatus();

	PopUpManager.centerPopUp(this);

}

/**
 * Ação do botão voltar da pesquisa.
 * @param event
 */
protected function voltarPesquisa():void
{
	currentState='statePesquisa';
	PopUpManager.centerPopUp(this);
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
	if (event.detail == Alert.YES){
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
		var usuario:Usuario=new Usuario();
		usuario.cpf=txtNovoCPF.text;
		usuario.login=txtNovoLogin.text;
		usuario.municipio=cmbNovoMunicipio.selectedItem;
		usuario.nome=txtNovoNome.text;
		usuario.senha=txtNovoSenha.text;
		usuario.perfil=cmbNovoPerfil.selectedItem;
		usuario.email=txtNovoEmail.text;
		usuario.status="ATIVO";

		//retira mascara cpf
		usuario.cpf=usuario.cpf.replace(".", "");
		usuario.cpf=usuario.cpf.replace(".", "");
		usuario.cpf=usuario.cpf.replace("-", "");

		if (currentState == 'stateEditar')
		{
			usuario.codigo=usuarioSelecionado.codigo;
			usuario.status=cmbNovoStatus.selectedItem;
		}

		usuarioSelecionado=usuario;

		usuarioService.inserir(usuario);

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
 * Resultado da inserção de usuários
 *
 * @param event
 */
protected function inserirUsuarioResult(event:ResultEvent):void
{
	if (currentState == 'stateNovo')
	{
		Alert.show("Usuário inserido com sucesso!", "Sucesso");
	}
	else if (currentState == 'stateEditar')
	{
		Alert.show("Usuário alterado com sucesso!", "Sucesso");
	}

	currentState='stateDetalhe';

	usuarioSelecionado=event.result as Usuario;

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
		if (txtNovoConfirmarSenha.text == txtNovoSenha.text)
		{
			return true;
		}
		else
		{
			Alert.show("Senhas não coicidem.", "Manutenção de Usuários");
		}
	}
	return false;
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
