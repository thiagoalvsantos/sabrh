package br.pucpr.sabrh.entity
{
	import flashx.textLayout.formats.Float;

	[RemoteClass(alias="br.pucpr.sabrh.entity.ProvaTouro")]
	[Bindable]
	public class ProvaTouro
	{
		// dados basicos
		public var codigo:Number;
		public var animal:Animal;
		public var preco:Number;
		public var dataUltimaAtualizacao:Date;
		public var quantidadeFilhas:Number;
		
		// producao
		public var proteina:Number;
		public var gordura:Number;
		public var quiloLeite:Number;
		
		// força leiteira
		public var estatura:Number;
		public var larguraPeito:Number;
		public var profundidadeCorporal:Number;
		public var angulosidade:Number;
		
		// garupa
		public var anguloGarupa:Number;
		public var larguraGarupa:Number;	
		
		// pernas e pes
		public var anguloCasco:Number;
		public var pernasPostVistaLateral:Number;
		public var pernasPostVistaPost:Number;
		public var profundidadeTalao:Number;
		
		// sistema mamário
		public var profundidadeUbere:Number;
		public var ligamentoMedio:Number;
		public var insercaoUbereAnterior:Number;
		public var colocacaoTetosAnteriores:Number;
		public var alturaUberePosterior:Number;
		public var larguraUberePosterior:Number;
		public var colocacaoTetosPosteriores:Number;
		public var comprimentoTetos:Number;

		// confiabilidade
		public var confiabilidadeProducao:Number;
		public var confiabilidadeConformacao:Number;
	}
}