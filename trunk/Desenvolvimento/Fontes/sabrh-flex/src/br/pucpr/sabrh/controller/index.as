import br.pucpr.sabrh.view.login;
import br.pucpr.sabrh.view.manterAcasalamento;
import br.pucpr.sabrh.view.manterAnimal;
import br.pucpr.sabrh.view.manterPropriedade;
import br.pucpr.sabrh.view.manterUsuario;
import br.pucpr.sabrh.view.pesquisarReprodutor;
import br.pucpr.sabrh.view.relatorios;

import flash.display.InteractiveObject;
import flash.events.TimerEvent;
import flash.external.ExternalInterface;

import mx.controls.Alert;
import mx.controls.Image;
import mx.events.CloseEvent;
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
	ExternalInterface.call('window.document.index.focus()');
	this.timer=new Timer(1000 * 1);
	timer.addEventListener(TimerEvent.TIMER, incrementa);
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
	var popUpManterUsuario:manterUsuario=manterUsuario(PopUpManager.createPopUp(this, manterUsuario, true));
	PopUpManager.centerPopUp(popUpManterUsuario);
	popUpEffect.target=popUpManterUsuario;
	popUpEffect.play();
}


//Função para abrir a tela de Manuntenção de Propriedades.
public function abrirManterPropriedade():void
{
	var popUpManterPropriedade:manterPropriedade=manterPropriedade(PopUpManager.createPopUp(this, manterPropriedade, true));
	PopUpManager.centerPopUp(popUpManterPropriedade);
	popUpEffect.target=popUpManterPropriedade;
	popUpEffect.play();
}


//Função para abrir a tela de Manuntenção de Animais.
public function abrirManterAnimais():void
{
	var popUpManterAnimal:manterAnimal=manterAnimal(PopUpManager.createPopUp(this, manterAnimal, true));
	PopUpManager.centerPopUp(popUpManterAnimal);
	popUpEffect.target=popUpManterAnimal;
	popUpEffect.play();
}

//Função para abrir a tela de Pesquisa de Reprodutor.
public function abrirPesquisarReprodutor():void
{
	var popUpPesquisarReprodutor:pesquisarReprodutor=pesquisarReprodutor(PopUpManager.createPopUp(this, pesquisarReprodutor, true));
	PopUpManager.centerPopUp(popUpPesquisarReprodutor);
	popUpEffect.target=popUpPesquisarReprodutor;
	popUpEffect.play();
}

//Função para abrir a tela de Pesquisa de Reprodutor.
public function abrirManterAcasalamento():void
{
	var popUpManterAcasalamento:manterAcasalamento=manterAcasalamento(PopUpManager.createPopUp(this, manterAcasalamento, true));
	PopUpManager.centerPopUp(popUpManterAcasalamento);
	popUpEffect.target=popUpManterAcasalamento;
	popUpEffect.play();
}

//Função para abrir a tela de Relatórios.
public function abrirRelatorios():void
{
	var popUpRelatorios:relatorios=relatorios(PopUpManager.createPopUp(this, relatorios, true));
	PopUpManager.centerPopUp(popUpRelatorios);
	popUpEffect.target=popUpRelatorios;
	popUpEffect.play();
}

//Função para fazer logoff da aplicação.
public function fazerLogoff():void
{
	Alert.show("Tem certeza de sair da aplicação?", "Logoff", Alert.YES | Alert.NO, this, encerrar);
}

//Função para setar o encerramento da aplicação.
public function encerrar(event:CloseEvent):void
{
	if (event.detail == Alert.YES)
	{
		// remove usuário da aplicação
		user=null;

		init();

		resetIcones();

		this.visible=false;
	}
}


/**
 * Metodo para resetar os dados dos icones principais.
 *
 */
protected function resetIcones():void
{
	if (barraIconesPersonalizada.numElements > 0)
		do
		{
			var elemento:InteractiveObject=barraIconesPersonalizada.getElementAt(0) as InteractiveObject;
			if (barraIcones.numElements > elemento.tabIndex)
				barraIcones.addElementAt(barraIconesPersonalizada.getElementAt(0), elemento.tabIndex);
			else
				barraIcones.addElementAt(barraIconesPersonalizada.getElementAt(0), barraIcones.numElements);
		} while (barraIconesPersonalizada.numElements > 0);
	iconeManterUsuario.toolTip="Manutenção de Usuários";
	barraIcones.visible=false;
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


