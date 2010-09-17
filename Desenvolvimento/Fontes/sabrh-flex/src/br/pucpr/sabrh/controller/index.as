import br.pucpr.sabrh.view.login;
import br.pucpr.sabrh.view.manterPropriedade;
import br.pucpr.sabrh.view.manterUsuario;

import mx.controls.Image;
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

//Função para abrir a tela de Manuntenção de Usuários.
public function abrirManterUsuario():void
{
	var popUpManterUsuario:manterUsuario=manterUsuario(PopUpManager.createPopUp(this,manterUsuario, true));
	PopUpManager.centerPopUp(popUpManterUsuario);
	popUpEffect.target=popUpManterUsuario;
	popUpEffect.play();
}


//Função para abrir a tela de Manuntenção de Usuários.
public function abrirManterPropriedade():void
{
	var popUpManterPropriedade:manterPropriedade=manterPropriedade(PopUpManager.createPopUp(this,manterPropriedade, true));
	PopUpManager.centerPopUp(popUpManterPropriedade);
	popUpEffect.target=popUpManterPropriedade;
	popUpEffect.play();
}


public function iconMoveDown(id:Image):void
{
	id.x=id.x + 2;
	id.y=id.y + 2;
}

public function iconMoveUp(id:Image):void
{
	id.x=id.x - 2;
	id.y=id.y - 2;
}

public function iconMD(id:Image):void
{
	id.y=id.y + 2;
}

public function iconMU(id:Image):void
{
	id.y=id.y - 2;
}


