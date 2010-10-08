// login
import br.pucpr.sabrh.entity.Usuario;
import br.pucpr.sabrh.index;
import br.pucpr.sabrh.view.manterUsuario;

import flash.events.MouseEvent;
import flash.utils.flash_proxy;

import mx.controls.Alert;
import mx.controls.Image;
import mx.core.FlexGlobals;
import mx.core.UIComponent;
import mx.managers.PopUpManager;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.validators.Validator;

private var usuario:Usuario;

/**
 * Cria elemento com a imagem de Manter Usuário
 * 
 **/
[Embed(source="../assets/img/btn-usuarios.png")]
[Bindable]
private var iconeManterUsuario:Class;

/**
 * Cria elemento com a imagem de Manter Propriedade
 * 
 **/
[Embed(source="../assets/img/btn-propriedades.png")]
[Bindable]
private var iconeManterPropriedade:Class;

/**
 * Cria elemento com a imagem de Manter Animal
 * 
 **/
[Embed(source="../assets/img/btn-animal.png")]
[Bindable]
private var iconeManterAnimal:Class;

/**
 * Cria elemento com a imagem de Relatório
 * 
 **/
[Embed(source="../assets/img/btn-graficos.png")]
[Bindable]
private var iconeRelatorio:Class;

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

		//verifica o perfil do usuário para limitar suas ações
		switch (usuario.perfil)
		{
			case "ADMINISTRADOR":
				app.barraIcones.visible=true;
				break;
			case "ESPECIALISTA":
				app.barraIcones.visible=true;
				break;
			case "EMPRESA":
				app.barraIconesPersonalizada.addElement(app.barraIcones.getChildByName("iconeManterAnimal"));
				app.barraIconesPersonalizada.addElement(app.barraIcones.getChildByName("iconeRelatorios"));
				break;
			case "PRODUTOR":
				app.barraIcones.getChildByName("iconeManterUsuario").toolTip="Editar Perfil";
				app.barraIcones.visible=true;
				break;
		}

		// abilita aplicação
		app.visible=true;
	}
	else
	{
		Alert.show("Usuário e/ou senha inválidos!", ".:: Login ::.");
	}
}

/**
 * Método para criar o elemento icone automático
 * 
 * @param:id:String
 * @param imagem:Class
 * @param toolTip:String
 * 
 * 
 * @return icone:Image
 */
private function criarIcone(id:String, classe:Class, toolTip:String):Image
{
	var icone:Image=new Image();
	icone.id=id;
	icone.source=classe;
	icone.toolTip=toolTip;
	
	return icone;
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

