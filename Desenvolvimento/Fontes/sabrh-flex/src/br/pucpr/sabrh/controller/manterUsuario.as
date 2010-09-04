// login
import mx.events.CloseEvent;
import mx.managers.PopUpManager;

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
	panelResultado.visible=true;
}


