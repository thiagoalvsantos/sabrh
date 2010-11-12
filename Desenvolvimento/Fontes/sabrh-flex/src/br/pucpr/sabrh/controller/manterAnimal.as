import br.pucpr.sabrh.components.constantes.ConstantesUtils;
import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.ClassificacaoLinear;
import br.pucpr.sabrh.entity.Propriedade;
import br.pucpr.sabrh.entity.ProvaTouro;
import br.pucpr.sabrh.view.pesquisarReprodutor;

import flash.events.MouseEvent;
import flash.sampler.NewObjectSample;

import flashx.textLayout.formats.Float;

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

//Função que recebe o retorno da consulta de Animais.
public function resultConsultarAnimal(atributoDestino:TextInput, tipoConsulta:String, tipoAnimal:String, animal:Animal):void
{
	atributoDestino.text=animal.nome;

	if (tipoConsulta == "novo")
	{
		if (tipoAnimal == ConstantesUtils.SEXO_MACHO)
		{
			paiNovo=animal;
		}
		else if (tipoAnimal == ConstantesUtils.SEXO_FEMEA)
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

protected function btnClickAcasalar():void
{
	classificacaoLinearService.pesquisarUltimaClassificacao(animalSelecionado);
}

protected function btnClickGenealogia():void
{
	currentState=ConstantesUtils.STATE_GENEALOGIA;
	//ANIMAL
	txtGenealogiaAnimalNome.text=animalSelecionado.nome;
	txtGenealogiaAnimalRegistro.text=animalSelecionado.registro;

	//PAI
	if (animalSelecionado.pai.registro == "000000000000000" || animalSelecionado.pai.registro == "000000000000001")
	{
		txtGenealogiaPaiNome.text="************************";
		txtGenealogiaPaiRegistro.text="************************";

		txtGenealogiaMaePaiNome.text="************************";
		txtGenealogiaMaePaiRegistro.text="************************";
		txtGenealogiaPaiPaiNome.text="************************";
		txtGenealogiaPaiPaiRegistro.text="************************";
	}
	else
	{
		txtGenealogiaPaiNome.text=animalSelecionado.pai.nome;
		txtGenealogiaPaiRegistro.text=animalSelecionado.pai.registro;

		if (animalSelecionado.pai.pai.registro == "000000000000000" || animalSelecionado.pai.pai.registro == "000000000000001")
		{
			txtGenealogiaPaiPaiNome.text="************************";
			txtGenealogiaPaiPaiRegistro.text="************************";
		}
		else
		{
			txtGenealogiaPaiPaiNome.text=animalSelecionado.pai.pai.nome;
			txtGenealogiaPaiPaiRegistro.text=animalSelecionado.pai.pai.registro;
		}

		if (animalSelecionado.pai.mae.registro == "000000000000000" || animalSelecionado.pai.mae.registro == "000000000000001")
		{
			txtGenealogiaMaePaiNome.text="************************";
			txtGenealogiaMaePaiRegistro.text="************************";
		}
		else
		{
			txtGenealogiaMaePaiNome.text=animalSelecionado.pai.mae.nome;
			txtGenealogiaMaePaiRegistro.text=animalSelecionado.pai.mae.registro;
		}

	}

	//MAE
	if (animalSelecionado.mae.registro == "000000000000000" || animalSelecionado.mae.registro == "000000000000001")
	{
		txtGenealogiaMaeNome.text="************************";
		txtGenealogiaMaeRegistro.text="************************";

		txtGenealogiaMaeMaeNome.text="************************";
		txtGenealogiaMaeMaeRegistro.text="************************";
		txtGenealogiaPaiMaeNome.text="************************";
		txtGenealogiaPaiMaeRegistro.text="************************";
	}
	else
	{
		txtGenealogiaMaeNome.text=animalSelecionado.mae.nome;
		txtGenealogiaMaeRegistro.text=animalSelecionado.mae.registro;

		if (animalSelecionado.mae.pai.registro == "000000000000000" || animalSelecionado.mae.pai.registro == "000000000000001")
		{
			txtGenealogiaPaiMaeNome.text="************************";
			txtGenealogiaPaiMaeRegistro.text="************************";
		}
		else
		{
			txtGenealogiaPaiMaeNome.text=animalSelecionado.mae.pai.nome;
			txtGenealogiaPaiMaeRegistro.text=animalSelecionado.mae.pai.registro;
		}

		if (animalSelecionado.mae.mae.registro == "000000000000000" || animalSelecionado.mae.mae.registro == "000000000000001")
		{
			txtGenealogiaMaeMaeNome.text="************************";
			txtGenealogiaMaeMaeRegistro.text="************************";
		}
		else
		{
			txtGenealogiaMaeMaeNome.text=animalSelecionado.mae.mae.nome;
			txtGenealogiaMaeMaeRegistro.text=animalSelecionado.mae.mae.registro;
		}

	}

	PopUpManager.centerPopUp(this);
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
 * Ação do botão editar Animal.
 * @param event
 */
protected function btnClickEditarAnimal():void
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

	if (animalSelecionado.sexo == ConstantesUtils.SEXO_FEMEA)
	{
		checkBoxNovoDescarte.visible=true;

		if (animalSelecionado.status == "GESTACAO")
		{
			checkBoxNovoDescarte.enabled=false;
		}
		else
		{
			checkBoxNovoDescarte.enabled=true;
			if (animalSelecionado.status == "DESCARTE")
			{
				checkBoxNovoDescarte.selected=true;
			}
			else
			{
				checkBoxNovoDescarte.selected=false;
			}
		}
	}
	else
	{
		checkBoxNovoDescarte.visible=false;
	}

	panelSucesso.visible=false;

	PopUpManager.centerPopUp(this);
}

protected function btnClickExcluirClassificacao():void
{
	classificacaoLinearService.excluir(classificacaoLinearSelecionada);
}

protected function btnClickExcluirProvaTouro():void
{
	provaTouroService.excluir(provaTouroSelecionada);
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
	classificacaoLinearSelecionada=null;
	currentState=ConstantesUtils.STATE_CLASSIFICACAO_LINEAR_EDITAR;
	// Limpar os campos para uma nova classificação

	btnClassificacaoExcluir.visible=false;
	//Dados Gerais
	txtClassificacaoDataClassificacao.selectedDate=null;
	txtClassificacaoLactacao.value=1;

	//Força Leiteira
	txtClassificacaoEstatura.text=null;
	txtClassificacaoNivLinhaSup.text=null;
	txtClassificacaoLarguraPeito.text=null;
	txtClassificacaoProfCorporal.text=null;
	txtClassificacaoAngulosidade.text=null;
	txtClassificacaoEscoreCorporal.text=null;
	txtClassificacaoTotalForcaLeiteira.text=null;

	//Garupa
	txtClassificacaoAnguloGarupa.text=null;
	txtClassificacaoLarguraGarupa.text=null;
	txtClassificacaoForcaLombo.text=null;
	txtClassificacaoTotalGarupa.text=null;

	//Pernas e Pés
	txtClassificacaoAnguloCasco.text=null;
	txtClassificacaoProfundidadeTalao.text=null;
	txtClassificacaoQualidadeOssea.text=null;
	txtClassificacaoPernasPostLateral.text=null;
	txtClassificacaoPernasPostPosterior.text=null;
	txtClassificacaoTotalPernasPes.text=null;

	//Sistema Mamário
	txtClassificacaoProfundidadeUbere.text=null;
	txtClassificacaoTexturaUbere.text=null;
	txtClassificacaoLigamentoMedio.text=null;
	txtClassificacaoInsersaoUbereAnt.text=null;
	txtClassificacaoColocacaoTetosAnt.text=null;
	txtClassificacaoAlturaUberePost.text=null;
	txtClassificacaoLarguraUberePost.text=null;
	txtClassificacaoColocacaoTetosPost.text=null;
	txtClassificacaoComprimentoTetos.text=null;
	txtClassificacaoTotalSistemaMamario.text=null;

	// Classificação Final
	txtClassificacaoPontuacaoFinal.text=null;
	txtClassificacaoClassificacaoFinal.text=null;

	//Limpar as mensagens de erro

	//Dados Gerais
	txtClassificacaoDataClassificacao.errorString=null;
	txtClassificacaoLactacao.errorString=null;

	//Força Leiteira
	txtClassificacaoEstatura.errorString=null;
	txtClassificacaoNivLinhaSup.errorString=null;
	txtClassificacaoLarguraPeito.errorString=null;
	txtClassificacaoProfCorporal.errorString=null;
	txtClassificacaoAngulosidade.errorString=null;
	txtClassificacaoEscoreCorporal.errorString=null;
	txtClassificacaoTotalForcaLeiteira.errorString=null;

	//Garupa
	txtClassificacaoAnguloGarupa.errorString=null;
	txtClassificacaoLarguraGarupa.errorString=null;
	txtClassificacaoForcaLombo.errorString=null;
	txtClassificacaoTotalGarupa.errorString=null;

	//Pernas e Pés
	txtClassificacaoAnguloCasco.errorString=null;
	txtClassificacaoProfundidadeTalao.errorString=null;
	txtClassificacaoQualidadeOssea.errorString=null;
	txtClassificacaoPernasPostLateral.errorString=null;
	txtClassificacaoPernasPostPosterior.errorString=null;
	txtClassificacaoTotalPernasPes.errorString=null;

	//Sistema Mamário
	txtClassificacaoProfundidadeUbere.errorString=null;
	txtClassificacaoTexturaUbere.errorString=null;
	txtClassificacaoLigamentoMedio.errorString=null;
	txtClassificacaoInsersaoUbereAnt.errorString=null;
	txtClassificacaoColocacaoTetosAnt.errorString=null;
	txtClassificacaoAlturaUberePost.errorString=null;
	txtClassificacaoLarguraUberePost.errorString=null;
	txtClassificacaoColocacaoTetosPost.errorString=null;
	txtClassificacaoComprimentoTetos.errorString=null;
	txtClassificacaoTotalSistemaMamario.errorString=null;

	// Classificação Final
	txtClassificacaoPontuacaoFinal.errorString=null;
	txtClassificacaoClassificacaoFinal.errorString=null;

	txtClassificacaoDataClassificacao.focusManager.setFocus(txtClassificacaoDataClassificacao);
	PopUpManager.centerPopUp(this);
}


protected function btnClickNovaProvaTouro():void
{
	provaTouroSelecionada=null;
	currentState=ConstantesUtils.STATE_PROVA_TOURO_EDITAR;

	btnProvaTouroExcluir.visible=false;

	//Dados Gerais
	txtProvaTouroDataProva.selectedDate=null;
	txtProvaTouroQtdFilhas.text=null;
	txtProvaTouroPreco.text=null;
	//Produção 
	txtProvaTouroPercentualProteina.text=null;
	txtProvaTouroPercentualGordura.text=null;
	txtProvaTouroQuiloLeite.text=null;
	// Força Leiteira
	txtProvaTouroEstatura.text=null;
	txtProvaTouroAngulosidade.text=null;
	txtProvaTouroLarguraPeito.text=null;
	txtProvaTouroProfundidadeCorporal.text=null;
	//Garupa 
	txtProvaTouroAnguloGarupa.text=null;
	txtProvaTouroLarguraGarupa.text=null;
	// Pernas e Pes
	txtProvaTouroAnguloCasco.text=null;
	txtProvaTouroPernasPostVistaLateral.text=null;
	txtProvaTouroPernasPostVistaPost.text=null;
	txtProvaTouroProfundidadeTalao.text=null;
	// Sistema Mamário
	txtProvaTouroProfundidadeUbere.text=null;
	txtProvaTouroColocacaoTetorAnteriores.text=null;
	txtProvaTouroColocacaoTetosPosteriores.text=null;
	txtProvaTouroLigamentoMedio.text=null;
	txtProvaTouroAlturaUberePosterior.text=null;
	txtProvaTouroComprimentoTetos.text=null;
	txtProvaTouroInsersaoUbereAnterior.text=null;
	txtProvaTouroLarguraUberePosterior.text=null;
	// Dados Finais 
	txtProvaTouroConfiabilidadeProducao.text=null;
	txtProvaTouroConfiabilidadeConformacao.text=null;


	//Dados Gerais
	txtProvaTouroDataProva.errorString=null;
	txtProvaTouroQtdFilhas.errorString=null;
	txtProvaTouroPreco.errorString=null;
	//Produção 
	txtProvaTouroPercentualProteina.errorString=null;
	txtProvaTouroPercentualGordura.errorString=null;
	txtProvaTouroQuiloLeite.errorString=null;
	// Força Leiteira
	txtProvaTouroEstatura.errorString=null;
	txtProvaTouroAngulosidade.errorString=null;
	txtProvaTouroLarguraPeito.errorString=null;
	txtProvaTouroProfundidadeCorporal.errorString=null;
	//Garupa 
	txtProvaTouroAnguloGarupa.errorString=null;
	txtProvaTouroLarguraGarupa.errorString=null;
	// Pernas e Pes
	txtProvaTouroAnguloCasco.errorString=null;
	txtProvaTouroPernasPostVistaLateral.errorString=null;
	txtProvaTouroPernasPostVistaPost.errorString=null;
	txtProvaTouroProfundidadeTalao.errorString=null;
	// Sistema Mamário
	txtProvaTouroProfundidadeUbere.errorString=null;
	txtProvaTouroColocacaoTetorAnteriores.errorString=null;
	txtProvaTouroColocacaoTetosPosteriores.errorString=null;
	txtProvaTouroLigamentoMedio.errorString=null;
	txtProvaTouroAlturaUberePosterior.errorString=null;
	txtProvaTouroComprimentoTetos.errorString=null;
	txtProvaTouroInsersaoUbereAnterior.errorString=null;
	txtProvaTouroLarguraUberePosterior.errorString=null;
	// Dados Finais 
	txtProvaTouroConfiabilidadeProducao.errorString=null;
	txtProvaTouroConfiabilidadeConformacao.errorString=null;

	txtProvaTouroDataProva.focusManager.setFocus(txtProvaTouroDataProva);
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

protected function btnClickProvaTouro(event:MouseEvent):void
{
	currentState=ConstantesUtils.STATE_PROVA_TOURO_LISTA;
	txtDetalheProvaTouroRegistro.text=animalSelecionado.registro;
	txtDetalheProvaTouroApelido.text=animalSelecionado.apelido;

	provaTouroService.pesquisar(animalSelecionado);

	PopUpManager.centerPopUp(this);

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
		{
			if (currentState == ConstantesUtils.STATE_EDITAR)
			{
				if (checkBoxNovoDescarte.selected)
				{
					animal.status="DESCARTE";
				}
				else
				{
					if (animalSelecionado.status == "DESCARTE")
					{
						animal.status="LACTACAO";
					}
					else
					{
						animal.status=animalSelecionado.status;
					}
				}
			}
			else
			{
				if (checkBoxNovoDescarte.selected)
				{
					animal.status="DESCARTE";
				}
				else
				{
					animal.status="LACTACAO";
				}
			}
		}

		animalService.salvar(animal);
	}

}

protected function btnClickSalvarClassificacao():void
{
	if (validarClassificacaoLinear())
	{
		var classificacaoLinear:ClassificacaoLinear;
		if (classificacaoLinearSelecionada == null)
		{
			classificacaoLinear=new ClassificacaoLinear();
		}
		else
		{
			classificacaoLinear=classificacaoLinearSelecionada;
		}
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
		classificacaoLinear.pontuacaoPernasPes=new Number(txtClassificacaoTotalPernasPes.text);

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


protected function btnClickSalvarProvaTouro():void
{
	if (validarProvaTouro())
	{
		var provaTouro:ProvaTouro;
		if (provaTouroSelecionada == null)
		{
			provaTouro=new ProvaTouro();
		}
		else
		{
			provaTouro=provaTouroSelecionada;
		}

		// Dados Gerais
		provaTouro.dataUltimaAtualizacao=txtProvaTouroDataProva.selectedDate;
		provaTouro.quantidadeFilhas=new Number(txtProvaTouroQtdFilhas.text);
		provaTouro.preco=new Number(txtProvaTouroPreco.text.replace("R$", '').replace(',', '').replace('.', ''));


		//Produção
		provaTouro.proteina=new Number(txtProvaTouroPercentualProteina.text);
		provaTouro.gordura=new Number(txtProvaTouroPercentualGordura.text);
		provaTouro.quiloLeite=parseFloat(txtProvaTouroQuiloLeite.text);
		//Força Leiteira
		provaTouro.estatura=new Number(txtProvaTouroEstatura.text);
		provaTouro.larguraPeito=new Number(txtProvaTouroLarguraPeito.text);
		provaTouro.profundidadeCorporal=new Number(txtProvaTouroProfundidadeCorporal.text);
		provaTouro.angulosidade=new Number(txtProvaTouroAngulosidade.text);
		//Garupa
		provaTouro.anguloGarupa=new Number(txtProvaTouroAnguloGarupa.text);
		provaTouro.larguraGarupa=new Number(txtProvaTouroLarguraGarupa.text);
		//Pernas e Pés
		provaTouro.anguloCasco=new Number(txtProvaTouroAnguloCasco.text);
		provaTouro.pernasPostVistaLateral=new Number(txtProvaTouroPernasPostVistaLateral.text);
		provaTouro.pernasPostVistaPost=new Number(txtProvaTouroPernasPostVistaPost.text);
		provaTouro.profundidadeTalao=new Number(txtProvaTouroProfundidadeTalao.text);

		//Sistema Mamário
		provaTouro.profundidadeUbere=new Number(txtProvaTouroProfundidadeUbere.text);
		provaTouro.ligamentoMedio=new Number(txtProvaTouroLigamentoMedio.text);
		provaTouro.insercaoUbereAnterior=new Number(txtProvaTouroInsersaoUbereAnterior.text);
		provaTouro.colocacaoTetosAnteriores=new Number(txtProvaTouroColocacaoTetorAnteriores.text);
		provaTouro.alturaUberePosterior=new Number(txtProvaTouroAlturaUberePosterior.text);
		provaTouro.larguraUberePosterior=new Number(txtProvaTouroLarguraUberePosterior.text);
		provaTouro.colocacaoTetosPosteriores=new Number(txtProvaTouroColocacaoTetosPosteriores.text);
		provaTouro.comprimentoTetos=new Number(txtProvaTouroComprimentoTetos.text);

		//Classificação Final
		provaTouro.confiabilidadeConformacao=new Number(txtProvaTouroConfiabilidadeConformacao.text);
		provaTouro.confiabilidadeProducao=new Number(txtProvaTouroConfiabilidadeProducao.text);

		provaTouro.animal=animalSelecionado;

		provaTouroService.salvar(provaTouro);
	}
}

protected function btnClickVoltarClassificacaoLista():void
{
	currentState=ConstantesUtils.STATE_CLASSIFICACAO_LINEAR_LISTA;
	PopUpManager.centerPopUp(this);
}

protected function btnClickVoltarDetalhe():void
{
	currentState=ConstantesUtils.STATE_DETALHE;
	PopUpManager.centerPopUp(this);
}

protected function btnClickVoltarProvaTouroLista():void
{
	currentState=ConstantesUtils.STATE_PROVA_TOURO_LISTA;
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
		btnClassificacaoProva.removeEventListener(MouseEvent.CLICK, btnClickProvaTouro);
		btnClassificacaoProva.addEventListener(MouseEvent.CLICK, btnClickClassificacaoLinear);
		btnClassificacaoProva.visible=true;
		btnAcasalar.visible=true;
		cmbDetalheStatusFemea.text=animalSelecionado.status;
		detalheStatusFemea.visible=true;
	}
	else if (animalSelecionado.sexo == ConstantesUtils.SEXO_MACHO)
	{
		btnClassificacaoProva.label=ConstantesUtils.PROVA_TOURO;
		btnClassificacaoProva.removeEventListener(MouseEvent.CLICK, btnClickClassificacaoLinear);
		btnClassificacaoProva.addEventListener(MouseEvent.CLICK, btnClickProvaTouro);
		btnClassificacaoProva.visible=true;
		btnAcasalar.visible=false;
		detalheStatusFemea.visible=false;
	}

	PopUpManager.centerPopUp(this);
}

protected function gridClickResultadoClassificacao(event:ListEvent):void
{
	currentState=ConstantesUtils.STATE_CLASSIFICACAO_LINEAR_EDITAR;

	classificacaoLinearSelecionada=event.currentTarget.selectedItem;

	//Dados Gerais
	txtClassificacaoDataClassificacao.selectedDate=classificacaoLinearSelecionada.dataClassificacao;
	txtClassificacaoLactacao.value=classificacaoLinearSelecionada.lactacao;

	//Força Leiteira
	txtClassificacaoEstatura.text=classificacaoLinearSelecionada.estatura.toString();
	txtClassificacaoNivLinhaSup.text=classificacaoLinearSelecionada.nivelamentoNivelSuperior.toString();
	txtClassificacaoLarguraPeito.text=classificacaoLinearSelecionada.larguraPeito.toString();
	txtClassificacaoProfCorporal.text=classificacaoLinearSelecionada.profundidadeCorporal.toString();
	txtClassificacaoAngulosidade.text=classificacaoLinearSelecionada.angulosidade.toString();
	txtClassificacaoEscoreCorporal.text=classificacaoLinearSelecionada.escoreCorporal.toString();
	txtClassificacaoTotalForcaLeiteira.text=classificacaoLinearSelecionada.pontuacaoForcaLeiteira.toString();

	//Garupa
	txtClassificacaoAnguloGarupa.text=classificacaoLinearSelecionada.anguloGarupa.toString();
	txtClassificacaoLarguraGarupa.text=classificacaoLinearSelecionada.larguraGarupa.toString();
	txtClassificacaoForcaLombo.text=classificacaoLinearSelecionada.forcaLombo.toString();
	txtClassificacaoTotalGarupa.text=classificacaoLinearSelecionada.pontuacaoGarupa.toString();

	//Pernas e Pés
	txtClassificacaoAnguloCasco.text=classificacaoLinearSelecionada.anguloCasco.toString();
	txtClassificacaoProfundidadeTalao.text=classificacaoLinearSelecionada.profundidadeTalao.toString();
	txtClassificacaoQualidadeOssea.text=classificacaoLinearSelecionada.qualidadeOssea.toString();
	txtClassificacaoPernasPostLateral.text=classificacaoLinearSelecionada.pernasPostVistaLateral.toString();
	txtClassificacaoPernasPostPosterior.text=classificacaoLinearSelecionada.pernasPostVistaPost.toString();
	txtClassificacaoTotalPernasPes.text=classificacaoLinearSelecionada.pontuacaoPernasPes.toString();

	//Sistema Mamário
	txtClassificacaoProfundidadeUbere.text=classificacaoLinearSelecionada.profundidadeUbere.toString();
	txtClassificacaoTexturaUbere.text=classificacaoLinearSelecionada.texturaUbere.toString();
	txtClassificacaoLigamentoMedio.text=classificacaoLinearSelecionada.ligamentoMedio.toString();
	txtClassificacaoInsersaoUbereAnt.text=classificacaoLinearSelecionada.insercaoUbereAnterior.toString();
	txtClassificacaoColocacaoTetosAnt.text=classificacaoLinearSelecionada.colocacaoTetosAnteriores.toString();
	txtClassificacaoAlturaUberePost.text=classificacaoLinearSelecionada.alturaUberePosterior.toString();
	txtClassificacaoLarguraUberePost.text=classificacaoLinearSelecionada.larguraUberePosterior.toString();
	txtClassificacaoColocacaoTetosPost.text=classificacaoLinearSelecionada.colocacaoTetosPosteriores.toString();
	txtClassificacaoComprimentoTetos.text=classificacaoLinearSelecionada.comprimentoTetos.toString();
	txtClassificacaoTotalSistemaMamario.text=classificacaoLinearSelecionada.pontuacaoSistemaMamario.toString();

	// Classificação Final
	txtClassificacaoPontuacaoFinal.text=classificacaoLinearSelecionada.pontuacaoFinal.toString();
	txtClassificacaoClassificacaoFinal.text=classificacaoLinearSelecionada.classificacaoFinal;

	btnClassificacaoExcluir.visible=true;

	txtClassificacaoDataClassificacao.focusManager.setFocus(txtClassificacaoDataClassificacao);
	PopUpManager.centerPopUp(this);
}


protected function gridClickResultadoProvaTouro(event:ListEvent):void
{
	currentState=ConstantesUtils.STATE_PROVA_TOURO_EDITAR;

	provaTouroSelecionada=event.currentTarget.selectedItem;

	//Dados Gerais
	txtProvaTouroDataProva.selectedDate=provaTouroSelecionada.dataUltimaAtualizacao;
	txtProvaTouroQtdFilhas.text=provaTouroSelecionada.quantidadeFilhas.toString();
	var precoTemp:String="";
	for (var i:int=0; i < provaTouroSelecionada.preco.toString().length; i++)
	{
		if (provaTouroSelecionada.preco.toString().length - i == 2)
			precoTemp=precoTemp + "," + provaTouroSelecionada.preco.toString().charAt(i);
		else
			precoTemp=precoTemp + provaTouroSelecionada.preco.toString().charAt(i);
	}
	txtProvaTouroPreco.text=currencyFormatter.format(precoTemp);
	//Produção 
	txtProvaTouroPercentualProteina.text=provaTouroSelecionada.proteina.toString();
	txtProvaTouroPercentualGordura.text=provaTouroSelecionada.gordura.toString();
	txtProvaTouroQuiloLeite.text=provaTouroSelecionada.quiloLeite.toString();
	// Força Leiteira
	txtProvaTouroEstatura.text=provaTouroSelecionada.estatura.toString();
	txtProvaTouroAngulosidade.text=provaTouroSelecionada.angulosidade.toString();
	txtProvaTouroLarguraPeito.text=provaTouroSelecionada.larguraPeito.toString();
	txtProvaTouroProfundidadeCorporal.text=provaTouroSelecionada.profundidadeCorporal.toString();
	//Garupa 
	txtProvaTouroAnguloGarupa.text=provaTouroSelecionada.anguloGarupa.toString();
	txtProvaTouroLarguraGarupa.text=provaTouroSelecionada.larguraGarupa.toString();
	// Pernas e Pes
	txtProvaTouroAnguloCasco.text=provaTouroSelecionada.anguloCasco.toString();
	txtProvaTouroPernasPostVistaLateral.text=provaTouroSelecionada.pernasPostVistaLateral.toString();
	txtProvaTouroPernasPostVistaPost.text=provaTouroSelecionada.pernasPostVistaPost.toString();
	txtProvaTouroProfundidadeTalao.text=provaTouroSelecionada.profundidadeTalao.toString();
	// Sistema Mamário
	txtProvaTouroProfundidadeUbere.text=provaTouroSelecionada.profundidadeUbere.toString();
	txtProvaTouroColocacaoTetorAnteriores.text=provaTouroSelecionada.colocacaoTetosAnteriores.toString();
	txtProvaTouroColocacaoTetosPosteriores.text=provaTouroSelecionada.colocacaoTetosPosteriores.toString();
	txtProvaTouroLigamentoMedio.text=provaTouroSelecionada.ligamentoMedio.toString();
	txtProvaTouroAlturaUberePosterior.text=provaTouroSelecionada.alturaUberePosterior.toString();
	txtProvaTouroComprimentoTetos.text=provaTouroSelecionada.comprimentoTetos.toString();
	txtProvaTouroInsersaoUbereAnterior.text=provaTouroSelecionada.insercaoUbereAnterior.toString();
	txtProvaTouroLarguraUberePosterior.text=provaTouroSelecionada.larguraUberePosterior.toString();
	// Dados Finais 
	txtProvaTouroConfiabilidadeProducao.text=provaTouroSelecionada.confiabilidadeProducao.toString();
	txtProvaTouroConfiabilidadeConformacao.text=provaTouroSelecionada.confiabilidadeConformacao.toString();

	btnProvaTouroExcluir.visible=true;

	txtProvaTouroDataProva.focusManager.setFocus(txtProvaTouroDataProva);
	PopUpManager.centerPopUp(this);
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

protected function labelFunctionDataClassificacao(item:Object, column:AdvancedDataGridColumn):String
{
	var dateFormat:DateFormatter=new DateFormatter();
	dateFormat.formatString="DD/MM/YYYY";

	return dateFormat.format(item.dataClassificacao);
}

protected function labelFunctionDataProvaTouro(item:Object, column:AdvancedDataGridColumn):String
{
	var dateFormat:DateFormatter=new DateFormatter();
	dateFormat.formatString="DD/MM/YYYY";

	return dateFormat.format(item.dataUltimaAtualizacao);
}

protected function labelFunctionPreco(item:Object, column:AdvancedDataGridColumn):String
{

	var precoTemp:String="";
	for (var i:int=0; i < item.preco.toString().length; i++)
	{
		if (item.preco.toString().length - i == 2)
			precoTemp=precoTemp + "," + item.preco.toString().charAt(i);
		else
			precoTemp=precoTemp + item.preco.toString().charAt(i);
	}
	return currencyFormatter.format(precoTemp);
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

protected function radioChangeNovoSexo():void
{
	if (radioGroupNovoSexo.selectedValue == ConstantesUtils.SEXO_FEMEA)
	{
		checkBoxNovoDescarte.visible=true;
	}
	else
	{
		checkBoxNovoDescarte.visible=false;
	}
}

//protected function radioChangeNovoSexo():void
//{
//	if (radioGroupNovoSexo.selectedValue == ConstantesUtils.SEXO_FEMEA)
//	{
//		novoStatusFemea.visible=true;
//		numValStatusFemea.enabled=true;
//	}
//	else
//	{
//		novoStatusFemea.visible=false;
//		numValStatusFemea.enabled=false;
//	}
//}



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
		btnAcasalar.visible=true;
		cmbDetalheStatusFemea.text=animalSelecionado.status;
		detalheStatusFemea.visible=true;
	}
	else if (animalSelecionado.sexo == ConstantesUtils.SEXO_MACHO)
	{
		btnClassificacaoProva.label=ConstantesUtils.PROVA_TOURO;
		btnClassificacaoProva.addEventListener(MouseEvent.CLICK, btnClickProvaTouro);
		btnClassificacaoProva.visible=true;
		detalheStatusFemea.visible=false;
	}

	PopUpManager.centerPopUp(this);

	panelSucesso.visible=true;
}

protected function serviceResultPesquisarClassificacaoLinear(event:ResultEvent):void
{
	var listaClassificacao:ArrayCollection=event.result as ArrayCollection;
	if (listaClassificacao != null || listaClassificacao.length > 0)
	{
		dataGridResultadoClassificacao.dataProvider=listaClassificacao;
	}
	else
	{
		dataGridResultadoClassificacao.dataProvider=null;
	}
	PopUpManager.centerPopUp(this);

}

protected function serviceResultPesquisarProvaTouro(event:ResultEvent):void
{
	var listaProvaTouro:ArrayCollection=event.result as ArrayCollection;

	if (listaProvaTouro != null || listaProvaTouro.length > 0)
	{
		dataGridResultadoProvaTouro.dataProvider=listaProvaTouro;
	}
	else
	{
		dataGridResultadoProvaTouro.dataProvider=null;
	}
	PopUpManager.centerPopUp(this);

}

protected function serviceResultPesquisarUltimaClassificacao(event:ResultEvent):void
{
	var classificacaoVacaSelecionada:ClassificacaoLinear=event.result as ClassificacaoLinear;
	var popUpPesquisarReprodutor:pesquisarReprodutor=pesquisarReprodutor(PopUpManager.createPopUp(this.parent, pesquisarReprodutor, true));
	popUpPesquisarReprodutor.classificacaoVacaSelecionada=classificacaoVacaSelecionada;
	popUpPesquisarReprodutor.txtPesquisaRegistroVaca.text=animalSelecionado.registro;
	popUpPesquisarReprodutor.txtPesquisaApelidoVaca.text=animalSelecionado.apelido;
	PopUpManager.centerPopUp(popUpPesquisarReprodutor);
	PopUpManager.centerPopUp(this);
	PopUpManager.removePopUp(this);
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
	classificacaoLinearSelecionada=null;
}

protected function serviceResultSalvarProvaTouro(event:ResultEvent):void
{
	btnClickProvaTouro(null);
	provaTouroSelecionada=null;
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
			if (txtClassificacaoDataClassificacao.selectedDate < animalSelecionado.dataNascimento)
			{
				txtClassificacaoDataClassificacao.errorString="Data da classificação deve ser postorior a data de nascimento do animal";
				txtClassificacaoDataClassificacao.focusManager.setFocus(txtClassificacaoDataClassificacao);
			}
			else
			{
				panelErrorClassificacao.visible=false;
				return true;
			}
		}
	}
	else
	{
		errors[0].target.source.focusManager.setFocus(errors[0].target.source);
		scroll.viewport.verticalScrollPosition=0;
	}
	panelErrorClassificacao.visible=true;

	return false;
}

protected function validarProvaTouro():Boolean
{
	var errors:Array=Validator.validateAll(valProvaTouro);

	//se não existem erros 
	if (errors.length == 0)
	{
		if (txtProvaTouroDataProva.selectedDate > new Date())
		{
			txtProvaTouroDataProva.errorString="Data da prova de touro deve ser igual ou menor que a data atual";
			txtProvaTouroDataProva.focusManager.setFocus(txtProvaTouroDataProva);
		}
		else
		{
			if (txtProvaTouroDataProva.selectedDate < animalSelecionado.dataNascimento)
			{
				txtProvaTouroDataProva.errorString="Data da prova de touro deve ser posterior a data de nascimento do animal";
				txtProvaTouroDataProva.focusManager.setFocus(txtProvaTouroDataProva);
			}
			else
			{
				panelErrorProvaTouro.visible=false;
				return true;
			}
		}
	}
	else
	{
		errors[0].target.source.focusManager.setFocus(errors[0].target.source);
		scroll.viewport.verticalScrollPosition=0;
	}
	panelErrorProvaTouro.visible=true;

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
