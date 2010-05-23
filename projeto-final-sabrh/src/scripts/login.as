// login
import modulos.Home;

import mx.core.Application;


private function actionEntrar():void
{
	Application.application.vs.selectedChild=Application.application.painelHome;
	Application.application.menu.enabled = true;
}
