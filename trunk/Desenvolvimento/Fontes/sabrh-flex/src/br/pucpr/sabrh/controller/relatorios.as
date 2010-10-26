import br.pucpr.sabrh.components.constantes.ConstantesUtils;
import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.ClassificacaoLinear;

import mx.charts.chartClasses.AxisBase;
import mx.controls.Alert;
import mx.core.FlexGlobals;
import mx.events.CloseEvent;
import mx.managers.PopUpManager;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;

public function init():void
{
	
}

/**
 *	Fechar a tela de pesquisa de reprodutor
 *
 * @param event
 */
protected function fechar(event:CloseEvent):void
{
	// fecha janela atual.
	PopUpManager.removePopUp(this);
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

//Função que recebe o retorno da consulta de Animais.
public function resultConsultarAnimal(atributoDestino:TextInput, tipoConsulta:String, tipoAnimal:String, animal:Animal):void
{
	if (tipoConsulta == "pesquisa" && tipoAnimal == ConstantesUtils.SEXO_FEMEA)
	{
		animalSelecionado=animal;
		atributoDestino.text=animal.apelido;
		txtPesquisaRegistroVaca.text=animal.registro;
		btnEvolucaoGeracao.enabled=true;
	}
	
}

protected function btnClickEvolucaoGeracao():void
{
	classificacaoLinearService.pesquisarGeracao(animalSelecionado);
}

protected function serviceResultAcasalamentoPesquisarGeracao(event:ResultEvent):void
{
	// Recupera lista de animais
	var listaClassificacoes:ArrayCollection=event.result as ArrayCollection;
	listaClassificacaoLinearGrafico=listaClassificacoes;

	currentState="stateEvolucaoGeracao";
	PopUpManager.centerPopUp(this);
}

protected function onFault(event:FaultEvent):void
{
	//Ocorreu uma falha ao chamar o servico. 
	Alert.show(event.fault.rootCause.message);
}

protected function dataFunctionNomeAnimal(axis:AxisBase, item:Object):Object {	
	return(item.animal.nome);
}