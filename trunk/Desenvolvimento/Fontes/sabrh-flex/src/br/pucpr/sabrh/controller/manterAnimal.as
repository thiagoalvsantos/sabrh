
import br.pucpr.sabrh.components.constantes.ConstantesUtils;
import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.Propriedade;
import br.pucpr.sabrh.view.consultarPropriedade;

import flash.events.MouseEvent;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.controls.DateField;
import mx.core.FlexGlobals;
import mx.events.CloseEvent;
import mx.events.FlexEvent;
import mx.events.ListEvent;
import mx.formatters.DateFormatter;
import mx.managers.PopUpManager;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.utils.StringUtil;
import mx.validators.Validator;

public var paiDefault:Animal;
public var maeDefault:Animal;

//Função para abrir a tela de Consultar Propriedades.
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

//Função que recebe o retorno da consulta de Propriedade.
public function resultConsultarPropriedade(atributoDestino:TextInput, tipoConsulta:String, propriedade:Propriedade):void
{
	atributoDestino.text=propriedade.nome;

	if (tipoConsulta == "novo")
	{
		propriedadeNovo=propriedade;
	}
	else
	{
		if (tipoConsulta == "pesquisa")
		{
			propriedadePesquisa=propriedade;
			proprietarioPesquisa=propriedade.proprietario;
			txtPesquisaProprietario.text=proprietarioPesquisa.nome;
			btnPesquisaBuscarProprietario.enabled=false;
		}
	}

}


//Função para abrir a tela de Consultar Usuários.
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

//Função que recebe o retorno da consulta de Usuário.
public function resultConsultarUsuario(atributoDestino:TextInput, tipoConsulta:String, usuario:Usuario):void
{
	atributoDestino.text=usuario.nome;

	if (tipoConsulta == "pesquisa")
	{
		proprietarioPesquisa=usuario;
	}
}

//Função para abrir a tela de Consultar Animais.
public function abrirConsultarAnimal(atributo:TextInput, tipoConsulta:String, tipoAnimal:String):void
{
	var popUpConsultarAnimal:consultarAnimal=consultarAnimal(PopUpManager.createPopUp(this.parent, consultarAnimal, true));
	popUpConsultarAnimal.janelaOrigem=this;
	popUpConsultarAnimal.tipoConsulta=tipoConsulta;
	popUpConsultarAnimal.atributoDestino=atributo;
	popUpConsultarAnimal.tipoAnimal=tipoAnimal;
	PopUpManager.centerPopUp(popUpConsultarAnimal);
	FlexGlobals.topLevelApplication.popUpEffect.target=popUpConsultarAnimal;
	FlexGlobals.topLevelApplication.popUpEffect.play();
}

//Função que recebe o retorno da consulta de Animais.
public function resultConsultarAnimal(atributoDestino:TextInput, tipoConsulta:String, tipoAnimal:String, animal:Animal):void
{
	atributoDestino.text=animal.nome;

	if (tipoConsulta == "novo")
	{
		if (tipoAnimal == "pai")
		{
			paiNovo=animal;
		}
		else if (tipoAnimal == "mae")
		{
			maeNovo=animal;
		}
	}
	else
	{
		if (tipoConsulta == "pesquisa")
		{
//			if (tipoAnimal == "pai")
//			{
//				paiPesquisa=animal;
//			}
//			else if (tipoAnimal == "mae")
//			{
//				maePesquisa=animal;
//			}
		}
	}
}

/**
 * Limpa dados de novo.
 *
 */
protected function btnClickLimparNovo():void
{
	txtNovoApelido.text="";
	txtNovoMae.text=maeDefault.nome;
	txtNovoNome.text="";
	txtNovoPai.text=paiDefault.nome;
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

	if (FlexGlobals.topLevelApplication.user.perfil != "PRODUTOR")
	{
		txtPesquisaProprietario.text="";
		proprietarioPesquisa=null;
		btnPesquisaBuscarProprietario.enabled=true;
	}

	if (dataGridResultado != null)
	{
		dataGridResultado.dataProvider=null;
	}

	txtPesquisaRegistroAnimal.focusManager.setFocus(txtPesquisaRegistroAnimal);

	PopUpManager.centerPopUp(this);
}

/**
 * Evento botão de inserir Animal.
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
			if (txtNovoPai.text == "NÃO INFORMADO")
				animal.pai=paiDefault;
			else
				animal.pai=paiNovo;
		}
		if (txtNovoMae.text != null && txtNovoMae.text != "")
		{
			if (txtNovoMae.text == "NÃO INFORMADO")
				animal.mae=maeDefault;
			else
				animal.mae=maeNovo;
		}

		animalService.salvar(animal);
	}

}

/**
 * Ação do botão editar Animal.
 * @param event
 */
protected function editarAnimal():void
{
	currentState="stateEditar";

	txtNovoRegistro.text=animalSelecionado.registro;
	txtNovoNome.text=animalSelecionado.nome;
	txtNovoApelido.text=animalSelecionado.apelido;
	propriedadeNovo=animalSelecionado.propriedade
	txtNovoPropriedade.text=propriedadeNovo.nome;
	if (animalSelecionado.pai != null)
	{
		paiNovo=animalSelecionado.pai;
		txtNovoPai.text=paiNovo.nome;
	}
	else
	{
		txtNovoPai.text="";
	}
	if (animalSelecionado.mae != null)
	{
		maeNovo=animalSelecionado.mae;
		txtNovoMae.text=maeNovo.nome;
	}
	else
	{
		txtNovoMae.text="";
	}

	txtNovoDataNascimento.selectedDate=animalSelecionado.dataNascimento;
	radioGroupNovoSexo.selectedValue=animalSelecionado.sexo;

	panelSucesso.visible=false;

	PopUpManager.centerPopUp(this);
}

/**
 *	Fechar a tela de manter Animal
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

	animalSelecionado=event.currentTarget.selectedItem;
	txtDetalheRegistro.text=animalSelecionado.registro;
	txtDetalheNome.text=animalSelecionado.nome;
	txtDetalheApelido.text=animalSelecionado.apelido;
	propriedadeNovo=animalSelecionado.propriedade
	txtDetalhePropriedade.text=propriedadeNovo.nome;
	if (animalSelecionado.pai != null)
	{
		paiNovo=animalSelecionado.pai;
		txtDetalhePai.text=paiNovo.nome;
	}
	else
	{
		txtDetalhePai.text="";
	}
	if (animalSelecionado.mae != null)
	{
		maeNovo=animalSelecionado.mae;
		txtDetalheMae.text=maeNovo.nome;
	}
	else
	{
		txtDetalheMae.text="";
	}
	var df:DateFormatter=new DateFormatter();
	df.formatString="DD/MM/YYYY";
	txtDetalheDataNascimento.text=df.format(animalSelecionado.dataNascimento);
	radioGroupDetalheSexo.selectedValue=animalSelecionado.sexo;

	if (animalSelecionado.sexo == ConstantesUtils.SEXO_FEMEA)
	{
		btnClassificacaoProva.label=ConstantesUtils.CLASSIFICACAO_LINEAR;
		btnClassificacaoProva.addEventListener(MouseEvent.CLICK, trocaEstadoClassificacaoLinear);
		btnClassificacaoProva.visible=true;
	}
	else if (animalSelecionado.sexo == ConstantesUtils.SEXO_MACHO)
	{
		btnClassificacaoProva.label=ConstantesUtils.PROVA_TOURO;
		btnClassificacaoProva.addEventListener(MouseEvent.CLICK, trocaEstadoProvaTouro);
		btnClassificacaoProva.visible=true;
	}

	PopUpManager.centerPopUp(this);
}

protected function trocaEstadoClassificacaoLinear(event:MouseEvent):void
{
	currentState='stateClassificacaoLinear';
}

protected function trocaEstadoProvaTouro(event:MouseEvent):void
{
	currentState='stateProvaTouro';
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
	
	animalService.recuperarAnimalPadrao("MACHO");
	animalService.recuperarAnimalPadrao("FEMEA");

	txtPesquisaRegistroAnimal.focusManager.setFocus(txtPesquisaRegistroAnimal);

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

protected function onFault(event:FaultEvent):void
{
	//Ocorreu uma falha ao chamar o servico. 
	Alert.show(event.fault.rootCause.message);
}



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
 * Resultado da pesquisa de animal padrao
 *
 * @param event
 */
protected function serviceResultRecuperarAnimalPadrao(event:ResultEvent):void
{	
	var animal:Animal=event.result as Animal;
	
	if (animal.sexo == "MACHO")
		paiDefault=animal;
	else
		maeDefault=animal;
}

/**
 * Resultado da inserção de animais
 *
 * @param event
 */
protected function serviceResultAnimalSalvar(event:ResultEvent):void
{
	currentState='stateDetalhe';

	panelSucesso.visible=true;

	animalSelecionado=event.result as Animal;
	txtDetalheRegistro.text=animalSelecionado.registro;
	txtDetalheNome.text=animalSelecionado.nome;
	txtDetalheApelido.text=animalSelecionado.apelido;
	propriedadeNovo=animalSelecionado.propriedade
	txtDetalhePropriedade.text=propriedadeNovo.nome;
	if (animalSelecionado.pai != null)
	{
		paiNovo=animalSelecionado.pai;
		txtDetalhePai.text=paiNovo.nome;
	}
	else
	{
		txtDetalhePai.text="";
	}
	if (animalSelecionado.mae != null)
	{
		maeNovo=animalSelecionado.mae;
		txtDetalheMae.text=maeNovo.nome;
	}
	else
	{
		txtDetalheMae.text="";
	}
	var df:DateFormatter=new DateFormatter();
	df.formatString="DD/MM/YYYY";
	txtDetalheDataNascimento.text=df.format(animalSelecionado.dataNascimento);
	radioGroupDetalheSexo.selectedValue=animalSelecionado.sexo;

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
		if (txtNovoDataNascimento.selectedDate > new Date())
		{
			txtNovoDataNascimento.errorString="Data de Nascimento deve ser igual ou menor que a data atual";
			txtNovoDataNascimento.focusManager.setFocus(txtNovoDataNascimento);
		}
		else
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
	txtPesquisaRegistroAnimal.focusManager.setFocus(txtPesquisaRegistroAnimal);
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
