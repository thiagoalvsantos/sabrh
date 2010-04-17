////////////////////////////////////////
//
//	Index.as
//
////////////////////////////////////////
import mx.controls.Alert;
import mx.events.ModuleEvent;
import mx.modules.ModuleLoader;




//--------------------------------------
//
//	Variaveis
//
//--------------------------------------
[Bindable]
public var hora:String;
private var timer:Timer=null;
private var acaoAtual:String;

//--------------------------------------
//
//	Funções
//
//--------------------------------------


/**
 *
 * @param event
 */
public function incrementa(event:TimerEvent):void
{
	hora=hf.format(new Date());
}

/**
 *
 */
public function init():void
{
	this.timer=new Timer(1000 * 1);
	timer.addEventListener("timer", incrementa);
	timer.start();

}

/**
 *
 */
public function action():void
{
	
	painelConteudo.title="Consultar Produtores";


	var ml:ModuleLoader = new ModuleLoader();
	
	ml.addEventListener(ModuleEvent.ERROR,onError);
	
	ml.url = "ConsultarProdutores.swf"
	ml.loadModule();
	
	painelConteudo.removeAllChildren();
	painelConteudo.addChild(ml);



}

public function onError(event:ModuleEvent):void{
	Alert.show(event.errorText.toString());
}


