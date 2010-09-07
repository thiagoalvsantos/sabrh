// login
import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.events.CloseEvent;
import mx.events.FlexEvent;
import mx.managers.PopUpManager;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;


public function init(event:FlexEvent):void
{
	municipioService.listarMunicipios();
}

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

public function listarUsuariosResult(event:ResultEvent):void
{
	gridUsuario.dataProvider=event.result as ArrayCollection;
	panelResultado.visible=true;
}

public function listarMunicipiosResult(event:ResultEvent):void
{
	cmbPesquisaMunicipio.dataProvider=event.result as ArrayCollection;
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

