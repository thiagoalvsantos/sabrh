// login


import br.pucpr.sabrh.entity.Usuario;

import flash.system.ApplicationDomain;

import mx.controls.Alert;
import mx.controls.Label;
import mx.core.Application;
import mx.core.FlexGlobals;
import mx.managers.PopUpManager;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;


private var usuario:Usuario;

protected function autenticar():void
{
	usuario=new Usuario();
	usuario.login=txtUsuario.text;
	usuario.senha=txtSenha.text;

	//Chama o metodo Save do servico "cargoService"
	usuarioService.autenticar(usuario);

}


public function autenticarResult(event:ResultEvent):void
{
	usuario=event.result as Usuario;

	if (usuario != null)
	{
		Alert.show("Olá " + usuario.login + "!!");
		var app:Object=FlexGlobals.topLevelApplication;



		app.usuarioLogado.text=usuario.login;
		PopUpManager.removePopUp(this);




	}
	else
	{
		Alert.show("Erro ao autenticar usuário!");
	}
}



public function onFault(event:FaultEvent):void
{
	//Ocorreu uma falha ao chamar o servico. 
	Alert.show(event.fault.message);
}
