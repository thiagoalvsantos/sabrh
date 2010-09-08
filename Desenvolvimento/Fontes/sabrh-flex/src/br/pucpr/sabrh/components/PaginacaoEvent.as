package br.pucpr.sabrh.components
{
	public class PaginacaoEvent extends Event {
		
		public static const EXIBIR_PAGINA:String = "exibirPagina";
		
		public var botaoPagina:BotaoPagina;
		
		public function PaginacaoEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
	}

}