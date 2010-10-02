// login
import br.pucpr.sabrh.entity.Municipio;
import br.pucpr.sabrh.entity.Propriedade;
import br.pucpr.sabrh.entity.Usuario;
import br.pucpr.sabrh.view.consultarUsuario;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
import mx.controls.dataGridClasses.DataGridColumn;
import mx.core.Application;
import mx.core.FlexGlobals;
import mx.events.CloseEvent;
import mx.events.FlexEvent;
import mx.events.ListEvent;
import mx.managers.PopUpManager;
import mx.messaging.errors.NoChannelAvailableError;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.utils.StringUtil;
import mx.validators.Validator;

import spark.components.TextInput;
import spark.events.IndexChangeEvent;




/**
 * Preenche as combos ai iniciar.
 *
 * @param event
 */
protected function init(event:FlexEvent):void
{

	estadoService.listarEstados();


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
		prop.proprietario=usuarioPesquisa;
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
	txtPesquisaProprietario.text="";
	usuarioPesquisa=null;

	if (gridProprietario != null)
	{
		gridProprietario.dataProvider=null;
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
	txtNovoTelefone.text="";
	txtNovoProprietario.text="";

	estadoService.listarEstados();

	txtNovoNome.errorString=null;
	txtNovoTelefone.errorString=null;
	txtNovoProprietario.errorString=null;
	cmbNovoMunicipio.errorString=null;
	cmbNovoEstado.errorString=null;

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
	txtNovoNome.text=propriedadeSelecionada.nome;
	txtNovoProprietario.text=propriedadeSelecionada.proprietario.nome;
	txtNovoTelefone.text=propriedadeSelecionada.telefone;
	estadoService.listarEstados();
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
 * Ação do botão salvar usuário.
 */
protected function actionBtnSalvarPropriedade():void
{
	if (validar())
	{
		var propriedade:Propriedade=new Propriedade();
		propriedade.municipio=cmbNovoMunicipio.selectedItem;
		propriedade.nome=txtNovoNome.text;
		var usuario:Usuario=new Usuario();
		usuario.codigo=10;
		propriedade.proprietario=usuarioNovo;
		propriedade.telefone=txtNovoTelefone.text;

		if (currentState == 'stateEditar')
		{
			propriedade.codigo=propriedadeSelecionada.codigo;
		}

		propriedadeSelecionada=propriedade;

		propriedadeService.salvar(propriedade);

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
	var listaPrprietarios:ArrayCollection=event.result as ArrayCollection;
	if (listaPrprietarios != null && listaPrprietarios.length != 0)
	{
		currentState='stateResultado';
		gridProprietario.dataProvider=listaPrprietarios;
		PopUpManager.centerPopUp(this);
	}
	else
	{
		currentState="statePesquisa";
		if (gridProprietario != null)
		{
			gridProprietario.dataProvider=null;
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
		Alert.show("Propriedade inserida com sucesso!", "Sucesso");
	}
	else if (currentState == 'stateEditar')
	{
		Alert.show("Propriedade alterada com sucesso!", "Sucesso");
	}

	currentState='stateDetalhe';

	txtDetalheNome.text=propriedadeSelecionada.nome;
	txtDetalheProprietario.text=propriedadeSelecionada.proprietario.nome;
	txtDetalheTelefone.text=propriedadeSelecionada.telefone;
	cmbDetalheEstado.text=propriedadeSelecionada.municipio.estado.descricao;
	cmbDetalheMunicipio.text=propriedadeSelecionada.municipio.descricao;

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

	propriedadeSelecionada=event.currentTarget.selectedItem;
	txtDetalheNome.text=propriedadeSelecionada.nome;
	txtDetalheProprietario.text=propriedadeSelecionada.proprietario.nome;
	txtDetalheTelefone.text=propriedadeSelecionada.telefone;
	cmbDetalheEstado.text=propriedadeSelecionada.municipio.estado.descricao;
	cmbDetalheMunicipio.text=propriedadeSelecionada.municipio.descricao;

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
		return false;
	}
}


//Função para abrir a tela de Manuntenção de Usuários.
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