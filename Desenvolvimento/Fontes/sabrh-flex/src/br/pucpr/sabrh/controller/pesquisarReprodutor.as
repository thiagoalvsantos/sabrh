import br.pucpr.sabrh.components.constantes.ConstantesUtils;

import mx.collections.ArrayCollection;
import mx.collections.Sort;
import mx.collections.SortField;
import mx.controls.Alert;
import mx.controls.DataGrid;
import mx.events.CloseEvent;
import mx.managers.PopUpManager;

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
		if (index != arrayAtributoConformacaoSelecionado.length-1)
		{
			arrayAtributoConformacaoSelecionado.removeItemAt(index);
			arrayAtributoConformacaoSelecionado.addItemAt(itemSelecionado, index + 1);
			dataGridConformacaoSelecionado.selectedIndex=index;
		}
	}
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
	// Altera estado da tela para "RESULTADO"
	currentState=ConstantesUtils.STATE_RESULTADO;
	
	// Atribui a lista de animais para a grid de resultado
	//dataGridResultado.dataProvider=listaAnimais;
	
	// Informa o número de registros encontrados 
	panelResultado.title=ConstantesUtils.RESULTADO_GRID + "";
	PopUpManager.centerPopUp(this);
}

