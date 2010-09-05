// login
import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.events.CloseEvent;
import mx.managers.PopUpManager;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;

/**
 *
 * @param event
 */
public function fechar(event:CloseEvent):void
{
	// fecha tela de manter usuário
	PopUpManager.removePopUp(this);
}


/**
 *
 * @param event
 */
public function pesquisar():void
{
	usuarioService.listarUsuarios();
}

public function listarResult(event:ResultEvent):void
{
	gridUsuario.dataProvider=event.result as ArrayCollection;
	panelResultado.visible=true;
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

