package br.pucpr.sabrh.entity
{
	import flashx.textLayout.formats.Float;

	[RemoteClass(alias="br.pucpr.sabrh.entity.ProvaTouro")]
	[Bindable]
	public class ProvaTouro
	{

		public var codigo:Number;
		public var animal:Animal;
		public var preco:Float;
		public var dataUltimaAtualizacao:Date;
		public var quantidadeFilhas:Number;
		public var proteina:Number;
		public var gordura:Number;
		public var quiloLeite:Float;
		public var estatura:Number;
		public var larguraPeito:Number;
		public var profundidadeCorporal:Number;
		public var angulosidade:Number;
		public var anguloGarupa:Number;
		public var larguraGarupa:Number;
		public var anguloCasco:Number;
		public var pernasPostVistaLateral:Number;
		public var pernasPostVistaPost:Number;
		public var pontucaoPernasPes:Number;
		public var insercaoUbereAnterior:Number;
		public var ligamentoMedio:Number;
		public var alturaUberePosterior:Number;
		public var larguraUberePosterior:Number;
		public var profundidadeUbere:Number;
		public var colocacaoTetosAnteriores:Number;
		public var colocacaoTetosPosteriores:Number;
		public var comprimentoTetos:Number;
		public var confiabilidadeProducao:Number;
		public var confiabilidadeConformacao:Number;
	}
}