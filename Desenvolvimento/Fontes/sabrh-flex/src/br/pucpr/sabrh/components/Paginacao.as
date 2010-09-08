package br.pucpr.sabrh.components
{

	public class Paginacao extends PaginacaoUI
	{
		[Bindable]
		private var _totalPorPagina:int=5;
		[Bindable]
		private var _totalDados:int;
		[Bindable]
		private var _listaBase:ArrayCollection;
		[Bindable]
		private var _listaBaseAux:ArrayCollection;
		private var _bpAux:BotaoPagina;
		private var _bpAtual:BotaoPagina;
		private var _listaAlvo:ListBase;
		private var _botoesPagina:Array=[];
		private var totalBotoes:int;

		public function Paginacao()
		{
			super();
		}

		override protected function childrenCreated():void
		{
			super.childrenCreated();
			/* Adicionando os Listeners */
			this.bpPaginaAnterior.addEventListener(MouseEvent.CLICK, trateExibirPaginaAnterior, false, 0, true);
			this.bpProximaPagina.addEventListener(MouseEvent.CLICK, trateExibirProximaPagina, false, 0, true);
			this.cbIntevalo.addEventListener(ListEvent.CHANGE, trateTrocaIntervalo, false, 0, true);
		}

		override public function invalidateProperties():void
		{
			super.invalidateProperties();
			/* Inicializa a configuração da paginação */
			configurarBotoesPagina();
		}

		/**
		 * @private
		 * Fica escutando quando o usuario trocou o total de interva de dados a ser amostrado na lista
		 * @param evt
		 */
		private function trateTrocaIntervalo(evt:ListEvent):void
		{
			_totalPorPagina=cbIntevalo.selectedItem.value;
			/* Inicializa a configuração da paginação */
			configurarBotoesPagina();
		}

		/**
		 * @private
		 * Responsavel por configurar os botoes de paginação na tela.
		 */
		private function configurarBotoesPagina():void
		{
			/* Calcula a quantidade de botoes que deverao ser criados baseado no total de dados e total de dados por pagina */
			totalBotoes=Math.ceil(totalDados / totalPorPagina);
			/* Se houver BotoesPagina ja configurado no container, deve-se removelos para
			 * recalcular o total de paginas */
			if (containerBpIntermadiarios != null && containerBpIntermadiarios.getChildren() != null)
			{
				containerBpIntermadiarios.removeAllChildren();
				_botoesPagina=[];
			}
			/* Realiza um loop criando os botoes */
			for (var i:int=1; i <= totalBotoes; i++)
			{
				/* Cria e configura o BotaoPagina */
				_bpAux=new BotaoPagina();
				_bpAux.toggle=true;
				_bpAux.pagina=i;
				_bpAux.intervaloInicial=(i - 1) * _totalPorPagina;
				_bpAux.addEventListener(PaginacaoEvent.EXIBIR_PAGINA, trateExibirPagina);
				_botoesPagina[i]=_bpAux;
				/* Se for o primeiro BotaoPagina criado deve-se configurar a lista de dados na componente tipo ListBase */
				if (i == 1)
				{
					_bpAux.selected=true;
					_bpAtual=_bpAux;
					configurarListaNaPagina(_bpAux);
				}
				/* Adiciona os botoes no container */
				containerBpIntermadiarios.addChild(_bpAux);
			}
		}

		/**
		 * @private
		 * Configura e renderiza os dados Base para ser amostrado na tela levendo-se em consideração
		 * o intervalo passado.
		 * @param intervloIncial
		 *
		 */
		private function configurarListaNaPagina(bpAtual:BotaoPagina):void
		{
			_listaBaseAux=new ArrayCollection();
			/* para cada Loop é copiado o objeto que se encontra no intervalo passado como parametro */
			for (var j:int=0; j < _totalPorPagina; j++)
			{
				if (bpAtual.intervaloInicial + j < _totalDados)
					_listaBaseAux.addItem(_listaBase.getItemAt(bpAtual.intervaloInicial + j));
			}
			/* Configurando os botoes de avançar e retornar */
			if (bpAtual.pagina > 1)
			{
				configBpPaginaAnterior();
			}
			else
			{
				configBpPaginaAnterior(false);
			}
			if (bpAtual.pagina == totalBotoes)
			{
				configBpProximaPagina(false);
			}
			else
			{
				configBpProximaPagina();
			}
			/* Define o provider clonado e define na ListBase */
			this._listaAlvo.dataProvider=_listaBaseAux;
		}

		/**
		 * @private
		 * Responsavel por ficar escutando quando o usuario deseja visualizar o conteudo de cada pagina
		 */
		private function trateExibirPagina(evt:PaginacaoEvent):void
		{
			_bpAtual.selected=false;
			_bpAtual=evt.botaoPagina;
			configurarListaNaPagina(_bpAtual);
		}

		/**
		 * @private
		 * Responsavel por exibir os dados da paragina anterior.
		 */
		private function trateExibirPaginaAnterior(evt:MouseEvent):void
		{
			/* Verifica qual a pagina em que esta para pegar a anterior */
			var i:int=(_bpAtual.pagina >= 1) ? _bpAtual.pagina - 1 : 0;
			_bpAtual.selected=false;
			_bpAtual=_botoesPagina[i];
			_bpAtual.selected=true;
			configurarListaNaPagina(_bpAtual);
		}

		/**
		 * @private
		 * Responsavel por amostrar os dados da proxima pagina
		 */
		private function trateExibirProximaPagina(evt:MouseEvent):void
		{
			/* Verifica qual a pagina em que esta para pegar a proxima */
			var i:int=(_bpAtual.pagina < (_botoesPagina.length - 1)) ? _bpAtual.pagina + 1 : _botoesPagina.length;
			if (i < _botoesPagina.length)
			{
				/* Desmarca o botao atual */
				_bpAtual.selected=false;
				/* Recupera o proximo botao e marca o mesmo */
				_bpAtual=_botoesPagina[i];
				_bpAtual.selected=true;
				/* Configura a lista na pagina */
				configurarListaNaPagina(_bpAtual);
			}
		}

		/**
		 * Define o total de dados que serão amostrados em cada pagina
		 * @param value
		 *
		 */
		public function set totalPorPagina(value:int):void
		{
			_totalPorPagina=value;
		}

		/**
		 * Retorna o numero de dados que esta/serão amostrados na tela.
		 * @return
		 */
		public function get totalPorPagina():int
		{
			return _totalPorPagina;
		}

		/**
		 * Define o total de dados que serão amostrados em cada pagina
		 * @param value
		 *
		 */
		public function set totalDados(value:int):void
		{
			_totalDados=value;
		}

		/**
		 * Retorna o numero de dados que esta/serão amostrados na tela.
		 * @return
		 */
		public function get totalDados():int
		{
			return _totalDados;
		}

		public function set listaAlvo(value:ListBase):void
		{
			_listaAlvo=value;
		}

		public function get listaAlvo():ListBase
		{
			return _listaAlvo;
		}

		/**
		 * Define a lista que será utilizada para exibir na paginacao
		 * @param value
		 *
		 */
		public function set listaBase(value:ArrayCollection):void
		{
			_listaBase=value;
			if (_listaBase)
			{
				_totalDados=_listaBase.length;
			}
		}

		public function get listaBase():ArrayCollection
		{
			return _listaBase;
		}

		private function configBpPaginaAnterior(value:Boolean=true):void
		{
			this.bpPaginaAnterior.enabled=value;
		}

		private function configBpProximaPagina(value:Boolean=true):void
		{
			this.bpProximaPagina.enabled=value;
		}
	}

}