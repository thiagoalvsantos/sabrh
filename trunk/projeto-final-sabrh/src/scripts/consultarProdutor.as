import components.quicksearch.ListQuickViewEvent;

import mocks.ProdutorDTO;

import mx.collections.ArrayCollection;
import mx.collections.ListCollectionView;
import mx.events.FlexEvent;

[Bindable]
private var listaProdutores:ListCollectionView;

private function initializeHandler(event:FlexEvent):void
{

	listaProdutores=new ArrayCollection();

	for (var i:int=0; i < 5; i++)
	{
		var produtor:ProdutorDTO;
		produtor=new ProdutorDTO();
		produtor.codigo= i;
		produtor.email= i + "@apcbrh.com.br";
		produtor.municipio="Curitiba";
		produtor.nome="Produtor " + i;
		produtor.uf="PR";

		listaProdutores.addItem(produtor);
	}

}

private function quickViewClickHandler(event:ListQuickViewEvent):void
{
	quickView.display(event.item);
}

private function filterChangeHandler(event:Event):void
{
	list.dataProvider.filterFunction=listFilterFunction;
	list.dataProvider.refresh();
}

private function clearHandler(event:Event):void
{
	list.dataProvider.filterFunction=null;
	list.dataProvider.refresh();
}

private function listFilterFunction(item:Object):Boolean
{
	var textToDisplay:String=filterInput.text;
	var label:String=item.name;
	var result:Boolean=label.toLocaleLowerCase().search(textToDisplay.toLocaleLowerCase()) != -1;
	return result;
}

