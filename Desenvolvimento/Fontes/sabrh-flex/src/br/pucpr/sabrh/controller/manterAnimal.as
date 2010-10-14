import br.pucpr.sabrh.components.constantes.ConstantesUtils;
import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.view.consultarPropriedade;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.controls.DateField;
import mx.core.FlexGlobals;
import mx.events.CloseEvent;
import mx.events.FlexEvent;
import mx.events.ListEvent;
import mx.managers.PopUpManager;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.utils.StringUtil;
import mx.validators.Validator;

/**
 * Limpa dados de novo.
 *
 */
protected function btnClickLimparNovo():void
{
	txtNovoApelido.text="";
	txtNovoMae.text="";
	txtNovoNome.text="";
	txtNovoPai.text="";
	txtNovoPropriedade.text="";
	txtNovoRegistro.text="";
	txtNovoDataNascimento.text="";
	radioGroupNovoSexo.selectedValue="Macho";

	txtNovoApelido.errorString=null;
	txtNovoMae.errorString=null;
	txtNovoNome.errorString=null;
	txtNovoPai.errorString=null;
	txtNovoPropriedade.errorString=null;
	txtNovoRegistro.errorString=null;
	txtNovoDataNascimento.errorString=null;

	txtNovoRegistro.focusManager.setFocus(txtNovoRegistro);

	if (currentState != "stateNovo")
	{
		currentState="stateNovo";
	}
	
	panelError.visible=false;
}

/**
 * Limpa dados de pesquisa.
 *
 * @param event
 */
protected function btnClickLimparPesquisa():void
{
	currentState='statePesquisa';
	txtPesquisaNomeAnimal.text="";
	txtPesquisaNomeMae.text="";
	txtPesquisaNomePai.text="";
	txtPesquisaRegistroAnimal.text="";
	txtPesquisaRegistroMae.text="";
	txtPesquisaRegistroPai.text="";
	checkBoxFemea.selected=false;
	checkBoxMacho.selected=false;

	if (dataGridResultado != null)
	{
		dataGridResultado.dataProvider=null;
	}
	PopUpManager.centerPopUp(this);
}

/**
 * Evento botão de inserir usuário.
 *
 * @param event
 */
protected function btnClickNovo():void
{
	currentState="stateNovo";
	btnClickLimparNovo();
	PopUpManager.centerPopUp(this);
}


/**
 *	Evento botão de pesquisar animais.
 *
 * @param event
 */
protected function btnClickPesquisar():void
{
	var animal:Animal=new Animal();
	if (StringUtil.trim(txtPesquisaNomeAnimal.text) != "")
	{
		animal.nome=StringUtil.trim(txtPesquisaNomeAnimal.text);
	}


	animalService.pesquisar(animal);
}

protected function btnClickSalvar():void
{
	if (validar())
	{
		var animal:Animal=new Animal;

		animal.apelido=StringUtil.trim(txtNovoApelido.text);
		animal.dataNascimento=DateField.stringToDate(txtNovoDataNascimento.text, "DD/MM/YYYY");
		animal.mae=null;
		animal.pai=null;
		animal.propriedade=null;
		animal.registro=txtNovoRegistro.text;
	}

}






/**
 * Ação do botão editar usuario.
 * @param event
 */
protected function editarUsuario():void
{
//    currentState="stateEditar";
//    txtNovoCPF.text=cpfFormatter.format(usuarioSelecionado.cpf);
//    txtNovoConfirmarSenha.text=usuarioSelecionado.senha;
//    txtNovoEmail.text=usuarioSelecionado.email;
//    txtNovoLogin.text=usuarioSelecionado.login;
//    txtNovoSenha.text=usuarioSelecionado.senha;
//    txtNovoNome.text=usuarioSelecionado.nome;

//    estadoService.listarEstados();
//    perfilService.listarPerfil();
//    statusService.listarStatus();

	PopUpManager.centerPopUp(this);

}

/**
 *	Fechar a tela de manter usuário
 *
 * @param event
 */
protected function fechar(event:CloseEvent):void
{
	// fecha janela atual.
	PopUpManager.removePopUp(this);
}

/**
 *
 * @param event
 */
protected function gridUsuarioItemClick(event:ListEvent):void
{
	currentState='stateDetalhe';

//    usuarioSelecionado=event.currentTarget.selectedItem;
//    txtDetalheCPF.text=cpfFormatter.format(usuarioSelecionado.cpf);
//    txtDetalheEmail.text=usuarioSelecionado.email;
//    txtDetalheLogin.text=usuarioSelecionado.login;
//    txtDetalheNome.text=usuarioSelecionado.nome;
//    cmbDetalheEstado.text=usuarioSelecionado.municipio.estado.descricao;
//    cmbDetalheMunicipio.text=usuarioSelecionado.municipio.descricao;
//    cmbDetalhePerfil.text=usuarioSelecionado.perfil;

	PopUpManager.centerPopUp(this);
}

/**
 * Preenche as combos ai iniciar.
 *
 * @param event
 */
protected function init(event:FlexEvent):void
{

	txtPesquisaNomeAnimal.focusManager.setFocus(txtPesquisaNomeAnimal);

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
//		cmbPesquisaEstado.dataProvider=listaEstados;
//		cmbPesquisaEstado.selectedIndex=-1;
//		cmbPesquisaEstado.selectedIndex=0;
//		cmbPesquisaEstado.errorString=null;
	}
	else
	{
//        cmbNovoEstado.dataProvider=listaEstados;
//        cmbNovoEstado.selectedIndex=-1;
//        cmbNovoEstado.selectedIndex=0;

		if (currentState == 'stateEditar')
		{
//            for (var i:Number=1; i < cmbNovoEstado.dataProvider.length; i++)
//            {
//                if (cmbNovoEstado.dataProvider.getItemAt(i).sigla == usuarioSelecionado.municipio.estado.sigla)
//                {
//                    cmbNovoEstado.selectedIndex=i;
//                }
//            }
		}
//        cmbNovoEstado.errorString=null;
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
//		cmbPesquisaPerfil.dataProvider=listaPerfil;
//		cmbPesquisaPerfil.selectedIndex=-1;
//		cmbPesquisaPerfil.selectedIndex=0;
	}
	else
	{
//        cmbNovoPerfil.dataProvider=listaPerfil;
//        cmbNovoPerfil.selectedIndex=-1;
//        cmbNovoPerfil.selectedIndex=0;

		if (currentState == 'stateEditar')
		{
			//      cmbNovoPerfil.selectedItem=usuarioSelecionado.perfil;
		}
//        cmbNovoPerfil.errorString=null;
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
//		cmbPesquisaStatus.dataProvider=listaStatus;
//		cmbPesquisaStatus.selectedIndex=-1;
//		cmbPesquisaStatus.selectedIndex=0

	}
	else
	{
//        cmbNovoStatus.dataProvider=listaStatus;
//        cmbNovoStatus.selectedIndex=-1;
//        cmbNovoStatus.selectedIndex=0;

		if (currentState == 'stateEditar')
		{
			//    cmbNovoStatus.selectedItem=usuarioSelecionado.status;
		}
//        cmbNovoStatus.errorString=null;
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
/**
 *
 * @param event
 */
protected function novoConfirmacaoResult(event:CloseEvent):void
{
	if (event.detail == Alert.YES)
	{
		btnClickLimparNovo();
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


//Função para abrir a tela de Consulta de Propriedade.
public function abrirConsultarPropriedade(atributo:TextInput, tipoConsulta:String):void
{
	var popUpConsultarPropriedade:consultarPropriedade=consultarPropriedade(PopUpManager.createPopUp(this.parent, consultarPropriedade, true));
	popUpConsultarPropriedade.janelaOrigem=this;
	popUpConsultarPropriedade.tipoConsulta=tipoConsulta;
	popUpConsultarPropriedade.atributoDestino=atributo;
	PopUpManager.centerPopUp(popUpConsultarPropriedade);
	FlexGlobals.topLevelApplication.popUpEffect.target=popUpConsultarPropriedade;
	FlexGlobals.topLevelApplication.popUpEffect.play();
}



//   /**
// *
// *	Resultado da pesquisa de usuários.
// *
// * @param event
// */
//protected function pesquisarUsuariosResult(event:ResultEvent):void
//{
//    var listaUsuarios:ArrayCollection=event.result as ArrayCollection;
//    currentState='stateResultado';
//    gridUsuario.dataProvider=listaUsuarios;
//    panelResultado.title="Resultado      -      Registros encontrados " + listaUsuarios.length;
//    PopUpManager.centerPopUp(this);
//}

protected function serviceResultAnimalPesquisar(event:ResultEvent):void
{
	// Recupera lista de animais
	var listaAnimais:ArrayCollection=event.result as ArrayCollection;

	// Altera estado da tela para "RESULTADO"
	currentState='stateResultado';

	// Atribui a lista de animais para a grid de resultado
	dataGridResultado.dataProvider=listaAnimais;

	// Informa o número de registros encontrados 
	panelResultado.title=ConstantesUtils.RESULTADO_GRID + listaAnimais.length;
	PopUpManager.centerPopUp(this);

}

/**
 * Resultado da inserção de usuários
 *
 * @param event
 */
protected function serviceResultAnimalSalvar(event:ResultEvent):void
{
	// Exibe mensagem de sucesso
	if (currentState == 'stateNovo')
	{
		Alert.show("Animal inserido com sucesso!", "Sucesso");
	}
	else if (currentState == 'stateEditar')
	{
		Alert.show("Animal alterado com sucesso!", "Sucesso");
	}

	currentState='stateDetalhe';


//    usuarioSelecionado=event.result as Usuario;
//
//    txtDetalheCPF.text=cpfFormatter.format(usuarioSelecionado.cpf);
//    txtDetalheEmail.text=usuarioSelecionado.email;
//    txtDetalheLogin.text=usuarioSelecionado.login;
//    txtDetalheNome.text=usuarioSelecionado.nome;
//    cmbDetalheEstado.text=usuarioSelecionado.municipio.estado.descricao;
//    cmbDetalheMunicipio.text=usuarioSelecionado.municipio.descricao;
//    cmbDetalhePerfil.text=usuarioSelecionado.perfil;

	PopUpManager.centerPopUp(this);
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
	}
	panelError.visible=true;

	return false;
}
///**
// * Ação do botão voltar da pesquisa.
// * @param event
// */
//protected function voltarPesquisa():void
//{
//    if (gridUsuario == null)
//    {
//        currentState='statePesquisa';
//    }
//    else
//    {
//        currentState='stateResultado';
//        actionBtnPesquisar();
//    }
//    txtPesquisaNomeAnimal.focusManager.setFocus(txtPesquisaNomeAnimal);
//    PopUpManager.centerPopUp(this);
//}
