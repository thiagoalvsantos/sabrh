import mx.collections.ArrayCollection;
import mx.collections.Sort;
import mx.collections.SortField;
import mx.controls.Alert;
import mx.controls.DataGrid;
import mx.controls.List;
import mx.core.FlexGlobals;
import mx.events.CloseEvent;
import mx.formatters.DateFormatter;
import mx.managers.PopUpManager;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import br.pucpr.sabrh.components.constantes.ConstantesUtils;
import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.ClassificacaoLinear;
import br.pucpr.sabrh.entity.FiltroAcasalamento;
import br.pucpr.sabrh.entity.ProvaTouro;

public var classificacaoVacaSelecionada:ClassificacaoLinear;

public function init():void
{

}

//Função que recebe o retorno da consulta de Animais.
public function resultConsultarAnimal(atributoDestino:TextInput, tipoConsulta:String, tipoAnimal:String, animal:Animal):void
{
	if (tipoConsulta == "pesquisa" && tipoAnimal == ConstantesUtils.SEXO_FEMEA)
	{
		atributoDestino.text=animal.apelido;
		txtPesquisaRegistroVaca.text=animal.registro;
		classificacaoLinearService.pesquisarUltimaClassificacao(animal);
	}

}

//Função para abrir a tela de Consultar Animais.
protected function abrirConsultarAnimal(atributo:TextInput, tipoConsulta:String, tipoAnimal:String):void
{
	var popUpConsultarAnimal:consultarAnimal=consultarAnimal(PopUpManager.createPopUp(this.parent, consultarAnimal, true));
	popUpConsultarAnimal.janelaOrigem=this;
	popUpConsultarAnimal.tipoConsulta=tipoConsulta;
	popUpConsultarAnimal.atributoDestino=atributo;
	popUpConsultarAnimal.tipoAnimal=tipoAnimal;
	PopUpManager.centerPopUp(popUpConsultarAnimal);
	FlexGlobals.topLevelApplication.popUpEffect.target=popUpConsultarAnimal;
	FlexGlobals.topLevelApplication.popUpEffect.play();
}

/**
 * Adicionar elementos dentro de uma lista para exibição do grafico
 *
 * @param nomeAtributo:String
 * @param valor:Number
 * @param lista:ArrayCollection
 */
protected function adicionarElementoLista(nomeAtributo:String, valorTouro:Number, valorVaca:Number, lista:ArrayCollection):void
{
	var objeto:Object=new Object();
	if (valorVaca == -1)
		objeto={Atributo: nomeAtributo, Touro: valorTouro};
	else
		objeto={Atributo: nomeAtributo, Touro: valorTouro, Vaca: valorVaca};
	lista.addItem(objeto);
}

protected function btnClickDetalhe():void
{
	currentState=ConstantesUtils.STATE_DETALHE;

	provaTouroSelecionado=dataGridResultado.selectedItem as ProvaTouro;

	//Dados Gerais
	txtDetalheTouroRegistro.text=provaTouroSelecionado.animal.registro;
	var df:DateFormatter=new DateFormatter();
	df.formatString="DD/MM/YYYY";
	txtDetalheTouroDataProva.text=df.format(provaTouroSelecionado.dataUltimaAtualizacao);
	txtDetalheTouroQtdFilhas.text=provaTouroSelecionado.quantidadeFilhas.toString();
	txtDetalheTouroApelido.text=provaTouroSelecionado.animal.apelido;
	txtDetalheTouroPreco.text=currencyFormatter.format(provaTouroSelecionado.preco.toString());

	//Produção
	txtDetalheTouroPercentualProteina.text=provaTouroSelecionado.proteina.toString();
	txtDetalheTouroPercentualGordura.text=provaTouroSelecionado.gordura.toString();
	txtDetalheTouroQuiloLeite.text=provaTouroSelecionado.quiloLeite.toString();
	txtDetalheTouroConfiabilidadeProducao.text=provaTouroSelecionado.confiabilidadeProducao.toString();

	//Conformação
	txtDetalheTouroConfiabilidadeConformacao.text=provaTouroSelecionado.confiabilidadeConformacao.toString();

	listaAtributoConformacaoGrafico=new ArrayCollection();
	if (classificacaoVacaSelecionada != null)
	{
		adicionarElementoLista("Profundidade do Talão", provaTouroSelecionado.profundidadeTalao, classificacaoVacaSelecionada.profundidadeTalao, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Profundidade do Úbere", provaTouroSelecionado.profundidadeUbere, classificacaoVacaSelecionada.profundidadeUbere, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Profundidade Corporal", provaTouroSelecionado.profundidadeCorporal, classificacaoVacaSelecionada.profundidadeCorporal, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Pernas Posteriores - Vista Posterior", provaTouroSelecionado.pernasPostVistaPost, classificacaoVacaSelecionada.pernasPostVistaPost, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Pernas Posteriores - Vista Lateral", provaTouroSelecionado.pernasPostVistaLateral, classificacaoVacaSelecionada.pernasPostVistaLateral, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Ligamento Médio", provaTouroSelecionado.ligamentoMedio, classificacaoVacaSelecionada.ligamentoMedio, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Largura Úbere Posterior", provaTouroSelecionado.larguraUberePosterior, classificacaoVacaSelecionada.larguraUberePosterior, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Largura do Peito", provaTouroSelecionado.larguraPeito, classificacaoVacaSelecionada.larguraPeito, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Largura da Garupa", provaTouroSelecionado.larguraGarupa, classificacaoVacaSelecionada.larguraGarupa, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Inserção Úbere Anterior", provaTouroSelecionado.insercaoUbereAnterior, classificacaoVacaSelecionada.insercaoUbereAnterior, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Estatura", provaTouroSelecionado.estatura, classificacaoVacaSelecionada.estatura, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Comprimento Tetos", provaTouroSelecionado.comprimentoTetos, classificacaoVacaSelecionada.comprimentoTetos, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Colocação de Tetos Posteriores", provaTouroSelecionado.colocacaoTetosPosteriores, classificacaoVacaSelecionada.colocacaoTetosPosteriores, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Colocação de Tetos Anteriores", provaTouroSelecionado.colocacaoTetosAnteriores, classificacaoVacaSelecionada.colocacaoTetosAnteriores, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Angulosidade", provaTouroSelecionado.angulosidade, classificacaoVacaSelecionada.angulosidade, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Ângulo Garupa", provaTouroSelecionado.anguloGarupa, classificacaoVacaSelecionada.anguloGarupa, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Ângulo do Casco", provaTouroSelecionado.anguloCasco, classificacaoVacaSelecionada.anguloCasco, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Altura Úbere Posterior", provaTouroSelecionado.alturaUberePosterior, classificacaoVacaSelecionada.alturaUberePosterior, listaAtributoConformacaoGrafico);
	}
	else
	{
		adicionarElementoLista("Profundidade do Talão", provaTouroSelecionado.profundidadeTalao, -1, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Profundidade do Úbere", provaTouroSelecionado.profundidadeUbere, -1, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Profundidade Corporal", provaTouroSelecionado.profundidadeCorporal, -1, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Pernas Posteriores - Vista Posterior", provaTouroSelecionado.pernasPostVistaPost, -1, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Pernas Posteriores - Vista Lateral", provaTouroSelecionado.pernasPostVistaLateral, -1, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Ligamento Médio", provaTouroSelecionado.ligamentoMedio, -1, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Largura Úbere Posterior", provaTouroSelecionado.larguraUberePosterior, -1, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Largura do Peito", provaTouroSelecionado.larguraPeito, -1, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Largura da Garupa", provaTouroSelecionado.larguraGarupa, -1, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Inserção Úbere Anterior", provaTouroSelecionado.insercaoUbereAnterior, -1, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Estatura", provaTouroSelecionado.estatura, -1, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Comprimento Tetos", provaTouroSelecionado.comprimentoTetos, -1, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Colocação de Tetos Posteriores", provaTouroSelecionado.colocacaoTetosPosteriores, -1, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Colocação de Tetos Anteriores", provaTouroSelecionado.colocacaoTetosAnteriores, -1, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Angulosidade", provaTouroSelecionado.angulosidade, -1, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Ângulo Garupa", provaTouroSelecionado.anguloGarupa, -1, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Ângulo do Casco", provaTouroSelecionado.anguloCasco, -1, listaAtributoConformacaoGrafico);
		adicionarElementoLista("Altura Úbere Posterior", provaTouroSelecionado.alturaUberePosterior, -1, listaAtributoConformacaoGrafico);
	}

	barChartProvaTouro.setStyle("gutterLeft", 200);
	listaAtributoConformacaoGrafico.refresh();

	PopUpManager.centerPopUp(this);
}

/**
 * Limpa dados de pesquisa.
 *
 * @param event
 */
protected function btnClickLimparPesquisa():void
{
	classificacaoVacaSelecionada=null;
	txtPesquisaApelidoVaca.text="";
	txtPesquisaConfiabilidadeConformacao.text="";
	txtPesquisaConfiabilidadeProducao.text="";
	txtPesquisaRegistroVaca.text="";

	checkBoxKgLeite.selected=false;
	checkBoxPerGordura.selected=false;
	checkBoxPerProteina.selected=false;
	checkBoxQntFilhas.selected=false;

	if (dataGridConformacaoSelecionado.dataProvider.source.length != 0)
	{
		for (var i:int=0; i < dataGridConformacaoSelecionado.dataProvider.source.length; i++)
		{
			var elemento:Object=dataGridConformacaoSelecionado.dataProvider.source[i];
			arrayAtributoConformacao.addItem(elemento);
		}
		ordenarLista("atributo", arrayAtributoConformacao);
		arrayAtributoConformacaoSelecionado.removeAll();
	}
}

/**
 * Altera a ordem de um item para baixo da lista de atributos para pesquisa
 */
protected function btnClickMoverBaixo():void
{
	var itemSelecionado:Object=dataGridConformacaoSelecionado.selectedItem;
	if (itemSelecionado)
	{
		var index:int=arrayAtributoConformacaoSelecionado.getItemIndex(itemSelecionado);
		if (index != arrayAtributoConformacaoSelecionado.length - 1)
		{
			arrayAtributoConformacaoSelecionado.removeItemAt(index);
			arrayAtributoConformacaoSelecionado.addItemAt(itemSelecionado, index + 1);
			dataGridConformacaoSelecionado.selectedIndex=index;
		}
	}
}

/**
 * Altera a ordem de um item para cima da lista de atributos para pesquisa
 */
protected function btnClickMoverCima():void
{
	var itemSelecionado:Object=dataGridConformacaoSelecionado.selectedItem;
	if (itemSelecionado)
	{
		var index:int=arrayAtributoConformacaoSelecionado.getItemIndex(itemSelecionado);
		if (index != 0)
		{
			arrayAtributoConformacaoSelecionado.removeItemAt(index);
			arrayAtributoConformacaoSelecionado.addItemAt(itemSelecionado, index - 1);
			dataGridConformacaoSelecionado.selectedIndex=index;
		}
	}
}

/**
 * Move um atributo da lista de atributos para a lista de atributos para pesquisa
 */
protected function btnClickMoverDireita():void
{
	var itemSelecionado:Object=dataGridConformacao.selectedItem;
	if (itemSelecionado)
	{
		var index:int=arrayAtributoConformacao.getItemIndex(itemSelecionado);
		arrayAtributoConformacaoSelecionado.addItem(itemSelecionado);
		arrayAtributoConformacao.removeItemAt(index);
	}
}

/**
 * Move um atributo da lista de atributos para pesquisa para a lista de atributos
 */
protected function btnClickMoverEsquerda():void
{
	var itemSelecionado:Object=dataGridConformacaoSelecionado.selectedItem;
	if (itemSelecionado)
	{
		var index:int=arrayAtributoConformacaoSelecionado.getItemIndex(itemSelecionado);
		arrayAtributoConformacao.addItem(itemSelecionado);
		ordenarLista("atributo", arrayAtributoConformacao);
		arrayAtributoConformacaoSelecionado.removeItemAt(index);
	}
}

/**
 *	Evento botão de pesquisar animais.
 *
 * @param event
 */
protected function btnClickPesquisar():void
{
	var filtroAcasalamento:FiltroAcasalamento=new FiltroAcasalamento();
	var listaProducao:Array=new Array();
	var listaConformacao:Array=new Array();

	if (classificacaoVacaSelecionada != null)
		filtroAcasalamento.femea=classificacaoVacaSelecionada.animal;

	// PRODUÇÃO
	if (checkBoxKgLeite.selected)
		listaProducao.push("quiloLeite");

	if (checkBoxPerGordura.selected)
		listaProducao.push("gordura");

	if (checkBoxPerProteina.selected)
		listaProducao.push("proteina");

	if (checkBoxQntFilhas.selected)
		listaProducao.push("quantidadeFilhas");

	// CONFORMAÇÃO
	for (var i:int=0; i < dataGridConformacaoSelecionado.dataProvider.source.length; i++)
	{
		var elemento:Object=dataGridConformacaoSelecionado.dataProvider.source[i];
		listaConformacao.push(elemento.value);
	}

	if (txtPesquisaConfiabilidadeConformacao.text != null && txtPesquisaConfiabilidadeConformacao.text != "")
		filtroAcasalamento.confiabilidadeConformacao=new Number(txtPesquisaConfiabilidadeConformacao.text);

	if (txtPesquisaConfiabilidadeProducao.text != null && txtPesquisaConfiabilidadeProducao.text != "")
		filtroAcasalamento.confiabilidadeProducao=new Number(txtPesquisaConfiabilidadeProducao.text);

	filtroAcasalamento.listaConformacao=listaConformacao;
	filtroAcasalamento.listaProducao=listaProducao;

	provaTouroService.pesquisarReprodutor(filtroAcasalamento);

}

protected function controlarSelecoes():void
{
//	var itemSelecionado:Object=dataGridResultado.selectedItem;
	switch (dataGridResultado.selectedIndices.length)
	{
		case 1:
			btnComparar.enabled=false;
			btnDetalhe.enabled=true;
			break;
		case 2:
			btnComparar.enabled=true;
			btnDetalhe.enabled=false;
			break;
		case 3:
			var itensSelecionado:Array=dataGridResultado.selectedItems;
			itensSelecionado.pop();
			dataGridResultado.selectedItems=itensSelecionado;
			break;

	}
}

/**
 * Método para retirar a seleção de dois grids ao mesmo tempo.
 */
protected function dataGridSelect(dataGrid:DataGrid):void
{
	if (dataGrid == dataGridConformacao)
		dataGridConformacaoSelecionado.selectedIndex=-1;
	else
		dataGridConformacao.selectedIndex=-1;
}

/**
 *	Fechar a tela de pesquisa de reprodutor
 *
 * @param event
 */
protected function fechar(event:CloseEvent):void
{
	// fecha janela atual.
	PopUpManager.removePopUp(this);
}

protected function onFault(event:FaultEvent):void
{
	//Ocorreu uma falha ao chamar o servico. 
	Alert.show(event.fault.rootCause.message);
}

/**
 * Método para ordenar uma lista de acordo com uma coluna
 *
 * @param ordenarPor:String
 * @param arrayCollection:ArrayCollection
 */
protected function ordenarLista(ordenarPor:String, arrayCollection:ArrayCollection):void
{
	var ordenar:Sort=new Sort();
	ordenar.fields=[new SortField(ordenarPor)];
	arrayCollection.sort=ordenar;
	arrayCollection.refresh();
}

protected function serviceResultPesquisarReprodutor(event:ResultEvent):void
{
	var listaReprodutores:ArrayCollection=event.result as ArrayCollection;

	// Altera estado da tela para "RESULTADO"
	currentState=ConstantesUtils.STATE_RESULTADO;

	// Atribui a lista de animais para a grid de resultado
	dataGridResultado.dataProvider=listaReprodutores;

	// Informa o número de registros encontrados 
	//panelResultado.title=ConstantesUtils.RESULTADO_GRID + "";
	PopUpManager.centerPopUp(this);
}

protected function serviceResultPesquisarUltimaClassificacao(event:ResultEvent):void
{
	classificacaoVacaSelecionada=event.result as ClassificacaoLinear;
}

/**
 *	Verifica o limite de atributos a serem pesquisados
 */
protected function verificaLimiteDataGrid():void
{
	if (dataGridConformacaoSelecionado != null)
	{
		if (arrayAtributoConformacaoSelecionado.length == 3)
		{
			dataGridConformacaoSelecionado.dropEnabled=false;
			btnMoverDireita.enabled=false;
			dataGridConformacao.doubleClickEnabled=false;
		}
		else
		{
			dataGridConformacaoSelecionado.dropEnabled=true;
			btnMoverDireita.enabled=true;
			dataGridConformacao.doubleClickEnabled=true;
		}

		if (arrayAtributoConformacaoSelecionado.length > 0)
		{
			btnMoverCima.enabled=true;
			btnMoverBaixo.enabled=true;
		}
		else
		{
			btnMoverCima.enabled=false;
			btnMoverBaixo.enabled=false;
		}

	}
}
