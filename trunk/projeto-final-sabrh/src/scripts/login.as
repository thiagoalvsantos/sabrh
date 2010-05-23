// login
import mx.controls.Alert;
import mx.core.Application;


private function actionEntrar():void
{
	Application.application.vs.selectedChild=Application.application.painelHome;
	Application.application.menu.enabled = true;
}

private function actionRecuperaSenha():void{
	currentState = "RecuperarSenha"; 
}

private function actionResetCurrentState():void{
	currentState = ""; 
}
