import mocks.ProdutorDTO;

import mx.collections.ArrayCollection;
import mx.collections.ListCollectionView;
import mx.controls.Alert;
import mx.core.Application;
import mx.events.FlexEvent;

[Bindable]
private var listaProdutores:ListCollectionView;

private function initializeHandler(event:FlexEvent):void
{

	listaProdutores=new ArrayCollection();

	for (var i:int=0; i < 50; i++)
	{
		var produtor:ProdutorDTO;
		produtor=new ProdutorDTO();
		produtor.codigo=i;
		produtor.email=i + "@apcbrh.com.br";
		produtor.municipio="Curitiba";
		produtor.nome="Produtor " + i;
		produtor.uf="PR";

		listaProdutores.addItem(produtor);

	}

}

private function close():void
{

	Application.application.carregarPaginaInicial();


}

private function showLog():void
{

	Alert.show("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor tempor nunc, quis imperdiet ligula condimentum sed. Sed elementum pretium posuere. Duis in euismod justo. Fusce eu risus id arcu luctus auctor. In hac habitasse platea dictumst. Nulla dapibus malesuada magna vel euismod. Nullam nibh risus, fermentum non sagittis eget, ornare eget turpis. Ut imperdiet porttitor massa sed commodo. Etiam arcu nisi, dignissim ac faucibus ullamcorper, bibendum ut nunc. Nulla tincidunt dictum metus ac sagittis. Ut varius, est ut pretium rhoncus, lectus ipsum condimentum diam, vitae aliquet felis ante vitae enim. Aliquam interdum lacus eget dui dictum vulputate sollicitudin nisl volutpat. Proin vel iaculis est. Sed egestas nulla nec metus pulvinar id tempor odio fermentum.", "Log");

}
/*
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
   var label:String=item.nome;
   var result:Boolean=label.toLocaleLowerCase().search(textToDisplay.toLocaleLowerCase()) != -1;
   return result;
   }

 */