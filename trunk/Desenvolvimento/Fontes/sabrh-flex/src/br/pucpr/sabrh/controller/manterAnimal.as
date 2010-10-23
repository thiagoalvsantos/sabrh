import br.pucpr.sabrh.components.constantes.ConstantesUtils;
import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.ClassificacaoLinear;
import br.pucpr.sabrh.entity.Propriedade;

import flash.events.MouseEvent;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
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

import spark.components.NavigatorContent;

public var maeDefault:Animal;

public var paiDefault:Animal;

//Função para abrir a tela de Consultar Animais.
protected function abrirConsultarAnimal(atributo:TextInput, tipoConsulta:String, tipoAnimal:String):void
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

//Função para abrir a tela de Consultar Propriedades.
protected function abrirConsultarPropriedade(atributo:TextInput, tipoConsulta:String):void
{
	var popUpConsultarPropriedade:consultarPropriedade=consultarPropriedade(PopUpManager.createPopUp(this.parent, consultarPropriedade, true));
	popUpConsultarPropriedade.janelaOrigem=this;
	popUpConsultarPropriedade.tipoConsulta=tipoConsulta;
	popUpConsultarPropriedade.atributoDestino=atributo;
	if (txtPesquisaProprietario.text != "" && tipoConsulta == "pesquisa")
	{
		popUpConsultarPropriedade.proprietarioPesquisa=proprietarioPesquisa;
		popUpConsultarPropriedade.btnPesquisaBuscar.enabled=false;
		popUpConsultarPropriedade.txtPesquisaProprietario.text=txtPesquisaProprietario.text;
	}
	PopUpManager.centerPopUp(popUpConsultarPropriedade);
	FlexGlobals.topLevelApplication.popUpEffect.target=popUpConsultarPropriedade;
	FlexGlobals.topLevelApplication.popUpEffect.play();
}


//Função para abrir a tela de Consultar Usuários.
protected function abrirConsultarUsuario(atributo:TextInput, tipoConsulta:String):void
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

protected function btnClickClassificacaoLinear(event:MouseEvent):void
{
	currentState=ConstantesUtils.STATE_CLASSIFICACAO_LINEAR_LISTA;
	txtDetalheClassificacaoRegistro.text=animalSelecionado.registro;
	txtDetalheClassificacaoApelido.text=animalSelecionado.apelido;

	classificacaoLinearService.pesquisar(animalSelecionado);

	dataGridResultadoClassificacao.dataProvider=animalSelecionado.listaClassificacao;
	PopUpManager.centerPopUp(this);
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
	radioGroupNovoSexo.selectedValue=ConstantesUtils.SEXO_MACHO;
	novoStatusFemea.visible=false;

	txtNovoApelido.errorString=null;
	txtNovoMae.errorString=null;
	txtNovoNome.errorString=null;
	txtNovoPai.errorString=null;
	txtNovoPropriedade.errorString=null;
	txtNovoRegistro.errorString=null;
	txtNovoDataNascimento.errorString=null;

	txtNovoRegistro.focusManager.setFocus(txtNovoRegistro);

	if (currentState != ConstantesUtils.STATE_NOVO)
	{
		currentState=ConstantesUtils.STATE_NOVO;
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
	currentState=ConstantesUtils.STATE_PESQUISA;
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

	if (FlexGlobals.topLevelApplication.user.perfil != ConstantesUtils.PERFIL_PRODUTOR)
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


protected function btnClickNovaClassificacao():void
{
	currentState=ConstantesUtils.STATE_CLASSIFICACAO_LINEAR_EDITAR;
	PopUpManager.centerPopUp(this);
}

/**
 * Evento botão de inserir Animal.
 *
 * @param event
 */
protected function btnClickNovo():void
{
	currentState=ConstantesUtils.STATE_NOVO;
	statusService.listarStatusFemea();
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
		animal.sexo=ConstantesUtils.SEXO_FEMEA;
	else if (checkBoxMacho.selected && checkBoxFemea.selected == false)
		animal.sexo=ConstantesUtils.SEXO_MACHO;

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
		panelError.visible=false;

		var animal:Animal=new Animal;

		animal.apelido=StringUtil.trim(txtNovoApelido.text);
		animal.dataNascimento=txtNovoDataNascimento.selectedDate;
		animal.propriedade=propriedadeNovo;
		animal.registro=txtNovoRegistro.text;
		animal.nome=txtNovoNome.text;
		animal.sexo=radioGroupNovoSexo.selectedValue as String;
		if (txtNovoPai.text != null && txtNovoPai.text != "")
		{
			if (txtNovoPai.text == ConstantesUtils.NOME_ANIMAL_DEFAULT)
				animal.pai=paiDefault;
			else
				animal.pai=paiNovo;
		}
		if (txtNovoMae.text != null && txtNovoMae.text != "")
		{
			if (txtNovoMae.text == ConstantesUtils.NOME_ANIMAL_DEFAULT)
				animal.mae=maeDefault;
			else
				animal.mae=maeNovo;
		}
		if (radioGroupNovoSexo.selectedValue == ConstantesUtils.SEXO_FEMEA)
			animal.status=cmbNovoStatusFemea.selectedItem;

		animalService.salvar(animal);
	}

}

protected function btnClickVoltarClassificacaoLista():void
{
	currentState=ConstantesUtils.STATE_CLASSIFICACAO_LINEAR_LISTA;
}

protected function btnClickSalvarClassificacao():void
{
	if (validarClassificacaoLinear())
	{
		var classificacaoLinear:ClassificacaoLinear=new ClassificacaoLinear();

		classificacaoLinear.dataClassificacao=txtClassificacaoDataClassificacao.selectedDate;
		classificacaoLinear.lactacao=txtClassificacaoLactacao.value;

		//Força Leiteira
		classificacaoLinear.estatura=new Number(txtClassificacaoEstatura.text);
		classificacaoLinear.nivelamentoNivelSuperior=new Number(txtClassificacaoNivLinhaSup.text);
		classificacaoLinear.larguraPeito=new Number(txtClassificacaoLarguraPeito.text);
		classificacaoLinear.profundidadeCorporal=new Number(txtClassificacaoProfCorporal.text);
		classificacaoLinear.angulosidade=new Number(txtClassificacaoAngulosidade.text);
		classificacaoLinear.escoreCorporal=new Number(txtClassificacaoEscoreCorporal.text);
		classificacaoLinear.pontuacaoForcaLeiteira=new Number(txtClassificacaoTotalForcaLeiteira.text);


		//Garupa
		classificacaoLinear.anguloGarupa=new Number(txtClassificacaoAnguloGarupa.text);
		classificacaoLinear.larguraGarupa=new Number(txtClassificacaoLarguraGarupa.text);
		classificacaoLinear.forcaLombo=new Number(txtClassificacaoForcaLombo.text);
		classificacaoLinear.pontuacaoGarupa=new Number(txtClassificacaoTotalGarupa.text);

		//Pernas e Pés
		classificacaoLinear.anguloCasco=new Number(txtClassificacaoAnguloCasco.text);
		classificacaoLinear.profundidadeTalao=new Number(txtClassificacaoProfundidadeTalao.text);
		classificacaoLinear.qualidadeOssea=new Number(txtClassificacaoQualidadeOssea.text);
		classificacaoLinear.pernasPostVistaLateral=new Number(txtClassificacaoPernasPostLateral.text);
		classificacaoLinear.pernasPostVistaPost=new Number(txtClassificacaoPernasPostPosterior.text);
		classificacaoLinear.pontucaoPernasPes=new Number(txtClassificacaoTotalPernasPes.text);

		//Sistema Mamário
		classificacaoLinear.profundidadeUbere=new Number(txtClassificacaoProfundidadeUbere.text);
		classificacaoLinear.texturaUbere=new Number(txtClassificacaoTexturaUbere.text);
		classificacaoLinear.ligamentoMedio=new Number(txtClassificacaoLigamentoMedio.text);
		classificacaoLinear.insercaoUbereAnterior=new Number(txtClassificacaoInsersaoUbereAnt.text);
		classificacaoLinear.colocacaoTetosAnteriores=new Number(txtClassificacaoColocacaoTetosAnt.text);
		classificacaoLinear.alturaUberePosterior=new Number(txtClassificacaoAlturaUberePost.text);
		classificacaoLinear.larguraUberePosterior=new Number(txtClassificacaoLarguraUberePost.text);
		classificacaoLinear.colocacaoTetosPosteriores=new Number(txtClassificacaoColocacaoTetosPost.text);
		classificacaoLinear.comprimentoTetos=new Number(txtClassificacaoComprimentoTetos.text);
		classificacaoLinear.pontuacaoSistemaMamario=new Number(txtClassificacaoTotalSistemaMamario.text);

		//Classificação Final
		classificacaoLinear.pontuacaoFinal=new Number(txtClassificacaoPontuacaoFinal.text);
		classificacaoLinear.classificacaoFinal=txtClassificacaoClassificacaoFinal.text;

		classificacaoLinear.animal=animalSelecionado;

		classificacaoLinearService.salvar(classificacaoLinear);
	}
}

protected function btnClickVoltarDetalhe():void
{
	currentState=ConstantesUtils.STATE_DETALHE;
}

/**
 * Ação do botão editar Animal.
 * @param event
 */
protected function editarAnimal():void
{
	currentState=ConstantesUtils.STATE_EDITAR;

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
	statusService.listarStatusFemea();

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
	currentState=ConstantesUtils.STATE_DETALHE;

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
		btnClassificacaoProva.addEventListener(MouseEvent.CLICK, btnClickClassificacaoLinear);
		btnClassificacaoProva.visible=true;
		cmbDetalheStatusFemea.text=animalSelecionado.status;
		detalheStatusFemea.visible=true;
	}
	else if (animalSelecionado.sexo == ConstantesUtils.SEXO_MACHO)
	{
		btnClassificacaoProva.label=ConstantesUtils.PROVA_TOURO;
		btnClassificacaoProva.addEventListener(MouseEvent.CLICK, trocaEstadoProvaTouro);
		btnClassificacaoProva.visible=true;
		detalheStatusFemea.visible=false;
	}

	PopUpManager.centerPopUp(this);
}

protected function gridClickResultadoClassificacao(event:ListEvent):void
{
	currentState=ConstantesUtils.STATE_CLASSIFICACAO_LINEAR_EDITAR;
}

/**
 * Preenche as combos ai iniciar.
 *
 * @param event
 */
protected function init(event:FlexEvent):void
{
	if (FlexGlobals.topLevelApplication.user.perfil == ConstantesUtils.PERFIL_PRODUTOR)
	{
		proprietarioPesquisa=FlexGlobals.topLevelApplication.user;
		btnPesquisaBuscarProprietario.enabled=false;
		txtPesquisaProprietario.text=FlexGlobals.topLevelApplication.user.nome;
	}

	animalService.recuperarAnimalPadrao(ConstantesUtils.SEXO_MACHO);
	animalService.recuperarAnimalPadrao(ConstantesUtils.SEXO_FEMEA);

	txtPesquisaRegistroAnimal.focusManager.setFocus(txtPesquisaRegistroAnimal);

}

protected function listarStatusFemeaResult(event:ResultEvent):void
{
	var listaStatusFemea:ArrayCollection=new ArrayCollection();
	listaStatusFemea.addItem(ConstantesUtils.SELECIONE);
	listaStatusFemea.addAll(event.result as ArrayCollection);

	cmbNovoStatusFemea.dataProvider=listaStatusFemea;
	cmbNovoStatusFemea.selectedIndex=-1;
	cmbNovoStatusFemea.selectedIndex=0;

	if (currentState == ConstantesUtils.STATE_EDITAR && animalSelecionado.sexo == ConstantesUtils.SEXO_FEMEA)
	{
		cmbNovoStatusFemea.selectedItem=animalSelecionado.status;
		novoStatusFemea.visible=true;
		numValStatusFemea.enabled=true;
	}
	else
	{
		novoStatusFemea.visible=false;
		numValStatusFemea.enabled=false;
	}

	cmbNovoStatusFemea.errorString=null;
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

//Função que recebe o retorno da consulta de Usuário.
public function resultConsultarUsuario(atributoDestino:TextInput, tipoConsulta:String, usuario:Usuario):void
{
	atributoDestino.text=usuario.nome;

	if (tipoConsulta == "pesquisa")
	{
		proprietarioPesquisa=usuario;
	}
}



protected function serviceResultAnimalPesquisar(event:ResultEvent):void
{
	// Recupera lista de animais
	var listaAnimais:ArrayCollection=event.result as ArrayCollection;

	// Altera estado da tela para "RESULTADO"
	currentState=ConstantesUtils.STATE_RESULTADO;

	// Atribui a lista de animais para a grid de resultado
	dataGridResultado.dataProvider=listaAnimais;

	// Informa o número de registros encontrados 
	panelResultado.title=ConstantesUtils.RESULTADO_GRID + listaAnimais.length;
	PopUpManager.centerPopUp(this);

}

/**
 * Resultado da inserção de animais
 *
 * @param event
 */
protected function serviceResultAnimalSalvar(event:ResultEvent):void
{
	currentState=ConstantesUtils.STATE_DETALHE;

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

	if (animalSelecionado.sexo == ConstantesUtils.SEXO_FEMEA)
	{
		btnClassificacaoProva.label=ConstantesUtils.CLASSIFICACAO_LINEAR;
		btnClassificacaoProva.addEventListener(MouseEvent.CLICK, btnClickClassificacaoLinear);
		btnClassificacaoProva.visible=true;
		cmbDetalheStatusFemea.text=animalSelecionado.status;
		detalheStatusFemea.visible=true;
	}
	else if (animalSelecionado.sexo == ConstantesUtils.SEXO_MACHO)
	{
		btnClassificacaoProva.label=ConstantesUtils.PROVA_TOURO;
		btnClassificacaoProva.addEventListener(MouseEvent.CLICK, trocaEstadoProvaTouro);
		btnClassificacaoProva.visible=true;
		detalheStatusFemea.visible=false;
	}

	PopUpManager.centerPopUp(this);

	panelSucesso.visible=true;
}


/**
 * Resultado da pesquisa de animal padrao
 *
 * @param event
 */
protected function serviceResultRecuperarAnimalPadrao(event:ResultEvent):void
{
	var animal:Animal=event.result as Animal;

	if (animal.sexo == ConstantesUtils.SEXO_MACHO)
		paiDefault=animal;
	else
		maeDefault=animal;
}

protected function serviceResultSalvarClassificacao(event:ResultEvent):void
{
	btnClickClassificacaoLinear(null);
}

protected function serviceResultPesquisarClassificacaoLinear(event:ResultEvent):void
{
	var listaClassificacao:ArrayCollection=event.result as ArrayCollection;
	dataGridResultadoClassificacao.dataProvider=listaClassificacao;

}


protected function trocaEstadoProvaTouro(event:MouseEvent):void
{
	currentState=ConstantesUtils.STATE_PROVA_TOURO;
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
		else if (radioGroupNovoSexo.selectedValue == ConstantesUtils.SEXO_FEMEA && numValStatusFemea.validate().results != null)
		{
			cmbNovoStatusFemea.focusManager.setFocus(cmbNovoStatusFemea);
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

protected function validarClassificacaoLinear():Boolean
{
	var errors:Array=Validator.validateAll(valClassificacao);

	//se não existem erros 
	if (errors.length == 0)
	{
		if (txtClassificacaoDataClassificacao.selectedDate > new Date())
		{
			txtClassificacaoDataClassificacao.errorString="Data da classificação deve ser igual ou menor que a data atual";
			txtClassificacaoDataClassificacao.focusManager.setFocus(txtClassificacaoDataClassificacao);
		}
		else
		{
			panelErrorClassificacao.visible=false;
			return true;
		}
	}
	else
	{
		errors[0].target.source.focusManager.setFocus(errors[0].target.source);
	}
	panelErrorClassificacao.visible=true;

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
		currentState=ConstantesUtils.STATE_PESQUISA;
	}
	else
	{
		currentState=ConstantesUtils.STATE_RESULTADO;
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

protected function radioChangeNovoSexo():void
{
	if (radioGroupNovoSexo.selectedValue == ConstantesUtils.SEXO_FEMEA)
	{
		novoStatusFemea.visible=true;
		numValStatusFemea.enabled=true;
	}
	else
	{
		novoStatusFemea.visible=false;
		numValStatusFemea.enabled=false;
	}
}
