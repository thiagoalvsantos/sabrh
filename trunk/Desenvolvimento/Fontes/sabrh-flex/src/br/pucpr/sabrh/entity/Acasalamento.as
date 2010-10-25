package br.pucpr.sabrh.entity
{

	[RemoteClass(alias="br.pucpr.sabrh.entity.Acasalamento")]
	[Bindable]
	public class Acasalamento
	{
		public var codigo:Number;
		public var macho:Animal;
		public var femea:Animal;
		public var cria:Animal;
		public var dataAcasalamento:Date;
		public var tipoAcasalamento:String;
		public var classificacaoLinear:ClassificacaoLinear;
		public var provaTouro:ProvaTouro;
	}
}