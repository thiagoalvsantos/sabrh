import mx.collections.ArrayCollection;
import mx.collections.Sort;
import mx.collections.SortField;
import mx.controls.Alert;
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
		}
		else 
		{
			dataGridConformacaoSelecionado.dropEnabled=true;
			btnMoverDireita.enabled=true;
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
		//ordenarLista("atributo", arrayAtributoConformacaoSelecionado);
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

