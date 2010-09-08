// login
import br.pucpr.sabrh.entity.Usuario;

import flash.display.DisplayObject;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.events.CloseEvent;
import mx.events.FlexEvent;
import mx.managers.PopUpManager;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;

import spark.events.IndexChangeEvent;


public function init(event:FlexEvent):void
{
	estadoService.listarEstados();
	statusService.listarStatus();
	perfilService.listarPerfil();
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

public function inserirUsuarioResult(event:ResultEvent):void
{
	Alert.show("Usuário inserido com sucesso!");
}

public function listarMunicipiosResult(event:ResultEvent):void
{
	var listaMunicipios:ArrayCollection=new ArrayCollection();
	listaMunicipios.addItemAt("Selecione...", 0);
	listaMunicipios.addAllAt(event.result as ArrayCollection, 1);

	if (viewStackUsuario.selectedIndex == 0)
	{
		cmbPesquisaMunicipio.dataProvider=listaMunicipios;
		cmbPesquisaMunicipio.selectedIndex=0;
		cmbPesquisaMunicipio.enabled=true;
	}
	else
	{
		cmbNovoMunicipio.dataProvider=listaMunicipios;
		cmbNovoMunicipio.selectedIndex=0;
		cmbNovoMunicipio.enabled=true;
	}


}

public function listarEstadosResult(event:ResultEvent):void
{
	var listaEstados:ArrayCollection=new ArrayCollection();
	listaEstados.addItemAt("Selecione...", 0);
	listaEstados.addAllAt(event.result as ArrayCollection, 1);
	if (viewStackUsuario.selectedIndex == 0)
	{
		cmbPesquisaEstado.dataProvider=listaEstados;
		cmbPesquisaEstado.selectedIndex=0;
	}
	else
	{
		cmbNovoEstado.dataProvider=listaEstados;
		cmbNovoEstado.selectedIndex=0;
	}

}


public function listarPerfilResult(event:ResultEvent):void
{
	var listaPerfil:ArrayCollection=new ArrayCollection();
	listaPerfil.addItemAt("Selecione...", 0);
	listaPerfil.addAllAt(event.result as ArrayCollection, 1);

	if (viewStackUsuario.selectedIndex == 0)
	{
		cmbPesquisaPerfil.dataProvider=listaPerfil;
		cmbPesquisaPerfil.selectedIndex=0;
	}
	else
	{
		cmbNovoPerfil.dataProvider=listaPerfil;
		cmbNovoPerfil.selectedIndex=0;
	}

}

public function listarStatusResult(event:ResultEvent):void
{
	var listaStatus:ArrayCollection=new ArrayCollection();
	listaStatus.addItemAt("Selecione...", 0);
	listaStatus.addAllAt(event.result as ArrayCollection, 1);

	if (viewStackUsuario.selectedIndex == 0)
	{
		cmbPesquisaStatus.dataProvider=listaStatus;
		cmbPesquisaStatus.selectedIndex=0
	}
	else
	{
		cmbNovoStatus.dataProvider=listaStatus;
		cmbNovoStatus.selectedIndex=0
	}

}

protected function selecionaEstado(event:IndexChangeEvent):void
{
	if (viewStackUsuario.selectedIndex == 0)
	{
		if (cmbPesquisaEstado.selectedIndex != 0)
		{
			municipioService.listarMunicipios(cmbPesquisaEstado.selectedItem);
		}
		else
		{
			cmbPesquisaMunicipio.enabled=false;
			cmbPesquisaMunicipio.dataProvider=null;
		}
	}
	else
	{
		if (cmbNovoEstado.selectedIndex != 0)
		{
			municipioService.listarMunicipios(cmbNovoEstado.selectedItem);
		}
		else
		{
			cmbNovoMunicipio.enabled=false;
			cmbNovoMunicipio.dataProvider=null;
		}
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

protected function actionNovoUsuario(event:MouseEvent):void
{
	viewStackUsuario.selectedIndex=1;
	estadoService.listarEstados();
	statusService.listarStatus();
	perfilService.listarPerfil();
}

protected function salvarUsuario():void
{
	var usuario:Usuario=new Usuario();
	usuario.cpf="123";
	usuario.login="admin";
	usuario.municipio=cmbNovoMunicipio.selectedItem;
	usuario.nome=txtNovoNome.text;
	usuario.perfil=cmbNovoPerfil.selectedItem;
	usuario.status=cmbNovoStatus.selectedItem;

	usuarioService.inserirUsuario(usuario);
}


