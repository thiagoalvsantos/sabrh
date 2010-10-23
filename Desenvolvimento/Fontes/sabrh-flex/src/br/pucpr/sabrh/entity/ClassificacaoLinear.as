package br.pucpr.sabrh.entity
{

	[RemoteClass(alias="br.pucpr.sabrh.entity.ClassificacaoLinear")]
	[Bindable]
	public class ClassificacaoLinear
	{
		public var codigo:Number;
		public var animal:Animal;
		public var dataClassificacao:Date;
		public var lactacao:Number;
		public var estatura:Number;
		public var nivelamentoNivelSuperior:Number;
		public var larguraPeito:Number;
		public var profundidadeCorporal:Number;
		public var angulosidade:Number;
		public var escoreCorporal:Number;
		public var pontuacaoForcaLeiteira:Number;
		public var anguloGarupa:Number;
		public var larguraGarupa:Number;
		public var forcaLombo:Number;
		public var pontuacaoGarupa:Number;
		public var anguloCasco:Number;
		public var profundidadeTalao:Number;
		public var qualidadeOssea:Number;
		public var pernasPostVistaLateral:Number;
		public var pernasPostVistaPost:Number;
		public var pontucaoPernasPes:Number;
		public var profundidadeUbere:Number;
		public var texturaUbere:Number;
		public var ligamentoMedio:Number;
		public var insercaoUbereAnterior:Number;
		public var colocacaoTetosAnteriores:Number;
		public var alturaUberePosterior:Number;
		public var larguraUberePosterior:Number;
		public var colocacaoTetosPosteriores:Number;
		public var comprimentoTetos:Number;
		public var pontuacaoSistemaMamario:Number;
		public var pontuacaoFinal:Number;
		public var classificacaoFinal:String;
	}
}