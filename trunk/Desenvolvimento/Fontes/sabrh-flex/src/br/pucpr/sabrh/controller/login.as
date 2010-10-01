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
import mx.validators.Validator;


private var usuario:Usuario;

/**
 * Realiza a autenticação do usuário
 */
protected function autenticar():void
{
	//verifica se formulário está valido
	if (validar())
	{
		//cria objeto Usuário com dados do formulário
		usuario=new Usuario();
		usuario.login=txtUsuario.text;
		usuario.senha=txtSenha.text;

		//chama o serviço para autenticar o usuário
		usuarioService.autenticar(usuario);
	}

}

/**
 *
 * Verifica se existem erros de validação no formulário
 *
 * @return Boolean
 */
protected function validar():Boolean
{
	//executa todos os validadores
	var errors:Array=Validator.validateAll(valArr);

	//se não existem erros 
	if (errors.length == 0)
	{
		return true;
	}
	return false;
}



/**
 *	Se usuário esta autenticado libera aplicação
 *
 * @param event
 */
public function autenticarResult(event:ResultEvent):void
{
	// recupera usuário do evento
	usuario=event.result as Usuario;


	// verifica se usuário é válido
	if (usuario != null)
	{
		// recupera aplicação pai 
		var app:Object=FlexGlobals.topLevelApplication;

		// coloca usuário na aplicação
		app.user=usuario;

		// fecha tela de login
		PopUpManager.removePopUp(this);

		// abilita aplicação
		app.visible=true;
	}
	else
	{
		Alert.show("Usuário e/ou senha inválidos!", ".:: Login ::.");
	}
}



/**
 * Falha ao invocar serviço
 *
 * @param event
 */
public function onFault(event:FaultEvent):void
{
	//Ocorreu uma falha ao chamar o servico. 
	Alert.show(event.fault.rootCause.message);
}

