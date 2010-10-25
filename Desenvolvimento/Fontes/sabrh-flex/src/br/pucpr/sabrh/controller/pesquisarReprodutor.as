import br.pucpr.sabrh.components.constantes.ConstantesUtils;
import br.pucpr.sabrh.entity.FiltroAcasalamento;

import mx.collections.ArrayCollection;
import mx.collections.Sort;
import mx.collections.SortField;
import mx.controls.Alert;
import mx.controls.DataGrid;
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

/**
 *	Verifica o limite de atributos a serem pesquisados
 */
protected function verificaLimiteDataGrid():void
{
	if (dataGridConformacaoSelecionado != null)
	{
		if (arrayAtributoConformacaoSelecionado.length == 3)
		{
			dataGridConformacaoSelecionado.dropEnabled=false;
			btnMoverDireita.enabled=false;
			dataGridConformacao.doubleClickEnabled=false;
		}
		else
		{
			dataGridConformacaoSelecionado.dropEnabled=true;
			btnMoverDireita.enabled=true;
			dataGridConformacao.doubleClickEnabled=true;
		}

		if (arrayAtributoConformacaoSelecionado.length > 0)
		{
			btnMoverCima.enabled=true;
			btnMoverBaixo.enabled=true;
		}
		else
		{
			btnMoverCima.enabled=false;
			btnMoverBaixo.enabled=false;
		}

	}
}

/**
 * Move um atributo da lista de atributos para a lista de atributos para pesquisa
 */
protected function btnClickMoverDireita():void
{
	var itemSelecionado:Object=dataGridConformacao.selectedItem;
	if (itemSelecionado)
	{
		var index:int=arrayAtributoConformacao.getItemIndex(itemSelecionado);
		arrayAtributoConformacaoSelecionado.addItem(itemSelecionado);
		arrayAtributoConformacao.removeItemAt(index);
	}
}

/**
 * Move um atributo da lista de atributos para pesquisa para a lista de atributos
 */
protected function btnClickMoverEsquerda():void
{
	var itemSelecionado:Object=dataGridConformacaoSelecionado.selectedItem;
	if (itemSelecionado)
	{
		var index:int=arrayAtributoConformacaoSelecionado.getItemIndex(itemSelecionado);
		arrayAtributoConformacao.addItem(itemSelecionado);
		ordenarLista("atributo", arrayAtributoConformacao);
		arrayAtributoConformacaoSelecionado.removeItemAt(index);
	}
}

/**
 * Altera a ordem de um item para cima da lista de atributos para pesquisa
 */
protected function btnClickMoverCima():void
{
	var itemSelecionado:Object=dataGridConformacaoSelecionado.selectedItem;
	if (itemSelecionado)
	{
		var index:int=arrayAtributoConformacaoSelecionado.getItemIndex(itemSelecionado);
		if (index != 0)
		{
			arrayAtributoConformacaoSelecionado.removeItemAt(index);
			arrayAtributoConformacaoSelecionado.addItemAt(itemSelecionado, index - 1);
			dataGridConformacaoSelecionado.selectedIndex=index;
		}
	}
}

/**
 * Altera a ordem de um item para baixo da lista de atributos para pesquisa
 */
protected function btnClickMoverBaixo():void
{
	var itemSelecionado:Object=dataGridConformacaoSelecionado.selectedItem;
	if (itemSelecionado)
	{
		var index:int=arrayAtributoConformacaoSelecionado.getItemIndex(itemSelecionado);
		if (index != arrayAtributoConformacaoSelecionado.length - 1)
		{
			arrayAtributoConformacaoSelecionado.removeItemAt(index);
			arrayAtributoConformacaoSelecionado.addItemAt(itemSelecionado, index + 1);
			dataGridConformacaoSelecionado.selectedIndex=index;
		}
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

//Função que recebe o retorno da consulta de Animais.
public function resultConsultarAnimal(atributoDestino:TextInput, tipoConsulta:String, tipoAnimal:String, animal:Animal):void
{
	if (tipoConsulta == "pesquisa" && tipoAnimal == ConstantesUtils.SEXO_FEMEA)
	{
		atributoDestino.text=animal.apelido;
		txtPesquisaRegistroVaca.text=animal.registro;
		vacaSelecionada=animal;
	}

}

protected function btnClickDetalhe():void
{
	currentState=ConstantesUtils.STATE_DETALHE;
}

/**
 * Método para ordenar uma lista de acordo com uma coluna
 *
 * @param ordenarPor:String
 * @param arrayCollection:ArrayCollection
 */
protected function ordenarLista(ordenarPor:String, arrayCollection:ArrayCollection):void
{
	var ordenar:Sort=new Sort();
	ordenar.fields=[new SortField(ordenarPor)];
	arrayCollection.sort=ordenar;
	arrayCollection.refresh();
}

/**
 * Método para retirar a seleção de dois grids ao mesmo tempo.
 */
protected function dataGridSelect(dataGrid:DataGrid):void
{
	if (dataGrid == dataGridConformacao)
		dataGridConformacaoSelecionado.selectedIndex=-1;
	else
		dataGridConformacao.selectedIndex=-1;
}

/**
 *	Evento botão de pesquisar animais.
 *
 * @param event
 */
protected function btnClickPesquisar():void
{
	var filtroAcasalamento:FiltroAcasalamento=new FiltroAcasalamento();
	var listaProducao:ArrayCollection=new ArrayCollection();
	var listaConformacao:ArrayCollection=new ArrayCollection();
	
	if (vacaSelecionada != null)
		filtroAcasalamento.femea=vacaSelecionada;
	
	// PRODUÇÃO
	if (checkBoxKgLeite.selected)
		listaProducao.addItem("quiloLeite");
	
	if (checkBoxPerGordura.selected)
		listaProducao.addItem("gordura");
	
	if (checkBoxPerProteina.selected)
		listaProducao.addItem("proteina");
	
	if (checkBoxQntFilhas.selected)
		listaProducao.addItem("quantidadeFilhas");
	
	// CONFORMAÇÃO
	for(var i:int=0; i < arrayAtributoConformacaoSelecionado.length; i++)
	{
		var elemento:Object=arrayAtributoConformacaoSelecionado.getItemIndex(i);
		listaConformacao.addItem(elemento.value);
	}
	
	if (txtPesquisaConfiabilidadeConformacao.text != null && txtPesquisaConfiabilidadeConformacao.text != "") 
		filtroAcasalamento.confiabilidadeConformacao=new Number(txtPesquisaConfiabilidadeConformacao.text);
	
	if (txtPesquisaConfiabilidadeProducao.text != null && txtPesquisaConfiabilidadeProducao.text != "") 
		filtroAcasalamento.confiabilidadeProducao=new Number(txtPesquisaConfiabilidadeProducao.text);
	
	filtroAcasalamento.listaConformacao=listaConformacao;
	filtroAcasalamento.listaProducao=listaProducao;
	
	provaTouroService.pesquisarReprodutor(filtroAcasalamento);
	
}

protected function serviceResultPesquisarReprodutor(event:ResultEvent):void
{
	var listaProvaTouro:ArrayCollection=event.result as ArrayCollection;
	
	// Altera estado da tela para "RESULTADO"
	currentState=ConstantesUtils.STATE_RESULTADO;
	
	// Atribui a lista de animais para a grid de resultado
	dataGridResultado.dataProvider=listaTemp;
	
	// Informa o número de registros encontrados 
	//panelResultado.title=ConstantesUtils.RESULTADO_GRID + "";
	PopUpManager.centerPopUp(this);
}

protected function onFault(event:FaultEvent):void
{
	//Ocorreu uma falha ao chamar o servico. 
	Alert.show(event.fault.rootCause.message);
}

protected function controlarSelecoes():void
{
//	var itemSelecionado:Object=dataGridResultado.selectedItem;
	switch (dataGridResultado.selectedIndices.length)
	{
		case 1:
			btnComparar.enabled=false;
			btnDetalhe.enabled=true;
			break;
		case 2:
			btnComparar.enabled=true;
			btnDetalhe.enabled=false;
			break;
		case 3:
			var itensSelecionado:Array=dataGridResultado.selectedItems;
			itensSelecionado.pop();
			dataGridResultado.selectedItems=itensSelecionado;
			break;

	}
}

