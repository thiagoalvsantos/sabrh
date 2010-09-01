import br.pucpr.sabrh.view.login;

import mx.managers.PopUpManager;

[Bindable]
/**
 *
 * @default
 */
public var hora:String;
private var timer:Timer=null;
private var moduloAtual:String;

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
	fazerLogin();

}

/**
 * 
 */
public function fazerLogin():void
{	
	var popUplogin:login=login(PopUpManager.createPopUp(this, login, true));
	popUplogin.txtUsuario.setFocus();
	PopUpManager.centerPopUp(popUplogin);
	loginEffect.target=popUplogin;
	loginEffect.play();
}


