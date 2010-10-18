
import br.pucpr.sabrh.components.constantes.ConstantesUtils;
import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.Propriedade;
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
	if (txtPesquisaPropriedade.text != "")
	{
		popUpConsultarUsuario.txtPesquisaNome.text=propriedadePesquisa.proprietario.nome;
		popUpConsultarUsuario.txtPesquisaNome.enabled=false;
	}
	PopUpManager.centerPopUp(popUpConsultarUsuario);
	FlexGlobals.topLevelApplication.popUpEffect.target=popUpConsultarUsuario;
	FlexGlobals.topLevelApplication.popUpEffect.play();
}

public function abrirConsultarAnimal(atributo:TextInput, tipoConsulta:String, tipoAnimal:String):void
{
	var popUpConsultarAnimal:consultarAnimal=consultarAnimal(PopUpManager.createPopUp(this.parent, consultarAnimal, true));
	popUpConsultarAnimal.janelaOrigem=this;
	popUpConsultarAnimal.tipoConsulta=tipoConsulta;
	popUpConsultarAnimal.atributoDestino=atributo;
	popUpConsultarAnimal.tipoAnimal=tipoAnimal;
	/** TODO APLICAR REGRAS */
//	if (txtPesquisaPropriedade.text != "")
//	{
//		popUpConsultarAnimal.txtPesquisaNome.text=propriedadePesquisa.proprietario.nome;
//		popUpConsultarAnimal.txtPesquisaNome.enabled=false;
//	}
	PopUpManager.centerPopUp(popUpConsultarAnimal);
	FlexGlobals.topLevelApplication.popUpEffect.target=popUpConsultarAnimal;
	FlexGlobals.topLevelApplication.popUpEffect.play();
}

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
	txtPesquisaPropriedade.text="";
	propriedadePesquisa=null;
	txtPesquisaProprietario.text="";
	proprietarioPesquisa=null;

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
	var mae:Animal;
	var pai:Animal;
	if (StringUtil.trim(txtPesquisaRegistroAnimal.text) != "")
	{
		animal.registro=StringUtil.trim(txtPesquisaRegistroAnimal.text);
	}

	if (StringUtil.trim(txtPesquisaNomeAnimal.text) != "")
	{
		animal.nome=StringUtil.trim(txtPesquisaNomeAnimal.text);
	}

	if (StringUtil.trim(txtPesquisaRegistroMae.text) != "")
	{
		if (mae == null)
			mae=new Animal();
		mae.registro=StringUtil.trim(txtPesquisaRegistroMae.text);
	}

	if (StringUtil.trim(txtPesquisaNomeMae.text) != "")
	{
		if (mae == null)
			mae=new Animal();
		mae.nome=StringUtil.trim(txtPesquisaNomeMae.text);
	}

	if (StringUtil.trim(txtPesquisaRegistroPai.text) != "")
	{
		if (pai == null)
			pai=new Animal();
		pai.registro=StringUtil.trim(txtPesquisaRegistroPai.text);
	}

	if (StringUtil.trim(txtPesquisaNomePai.text) != "")
	{
		if (pai == null)
			pai=new Animal();
		pai.nome=StringUtil.trim(txtPesquisaNomePai.text);
	}

	if (checkBoxFemea.selected && checkBoxMacho.selected == false)
		animal.sexo="FEMEA";
	else if (checkBoxMacho.selected && checkBoxFemea.selected == false)
		animal.sexo="MACHO";

	if (txtPesquisaPropriedade.text != "")
	{
		animal.propriedade=propriedadePesquisa;
	}
	else if (txtPesquisaProprietario.text != "")
	{
		var prop:Propriedade=new Propriedade();
		prop.proprietario=proprietarioPesquisa;
		animal.propriedade=prop;
	}

	if (mae != null)
		animal.mae=mae;
	if (pai != null)
		animal.pai=pai;

	animalService.pesquisar(animal);
}

protected function btnClickSalvar():void
{
	if (validar())
	{
		var animal:Animal=new Animal;

		animal.apelido=StringUtil.trim(txtNovoApelido.text);
		animal.dataNascimento=txtNovoDataNascimento.selectedDate;
		animal.propriedade=propriedadeNovo;
		animal.registro=txtNovoRegistro.text;
		animal.nome=txtNovoNome.text;
		animal.sexo=radioGroupNovoSexo.selectedValue as String;
		if (txtNovoPai.text != null && txtNovoPai.text != "")
		{
			animal.pai=paiNovo;
		}
		if (txtNovoMae.text != null && txtNovoMae.text != "")
		{
			animal.mae=maeNovo;
		}

		animalService.salvar(animal);
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
protected function gridClickResultado(event:ListEvent):void
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
	if (FlexGlobals.topLevelApplication.user.perfil == "PRODUTOR")
	{
		proprietarioPesquisa=FlexGlobals.topLevelApplication.user;
		btnPesquisaBuscarProprietario.enabled=false;
		txtPesquisaProprietario.text=FlexGlobals.topLevelApplication.user.nome;
	}

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
	Alert.show("Tem certeza de sair sem salvar as alterações?", "Manutenção de Animais", Alert.YES | Alert.NO, this, novoConfirmacaoResult);
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

/**
 * Ação do botão voltar da pesquisa.
 * @param event
 */
protected function voltarPesquisa():void
{
	if (dataGridResultado == null)
	{
		currentState='statePesquisa';
	}
	else
	{
		currentState='stateResultado';
		btnClickPesquisar();
	}
	txtPesquisaNomeAnimal.focusManager.setFocus(txtPesquisaNomeAnimal);
	PopUpManager.centerPopUp(this);
}
