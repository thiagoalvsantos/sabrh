////////////////////////////////////////
//
//	Index.as
//
////////////////////////////////////////
import modulos.cadastros.ConsultarProdutores;
import modulos.cadastros.CadastroPropriedade;


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
public function initTimer():void
{
	this.timer=new Timer(1000 * 1);
	timer.addEventListener("timer", incrementa);
	timer.start();
}

/**
 *
 */
public function action(action:String):void
{	
	if (acaoAtual != action)
	{
		acaoAtual=action;
		var p=null;
		switch (action)
		{
			case 'CadastroProdutor':
				painelConteudo.label = "Consultar Produtores"
				p=new ConsultarProdutores();
				break;
			case 'CadastroPropriedade':
				p=new CadastroPropriedade();
				break;
			default:
				p=null;


		}
		painelConteudo.removeAllChildren();

		painelConteudo.addChild(p);
	}



}



