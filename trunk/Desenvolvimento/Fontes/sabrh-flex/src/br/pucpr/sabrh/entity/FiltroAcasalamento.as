package br.pucpr.sabrh.entity
{
	
	[RemoteClass(alias="br.pucpr.sabrh.entity.FiltroAcasalamento")]
	[Bindable]
	public class FiltroAcasalamento
	{
		public var listaConformacao:Array;
		public var listaProducao:Array;
		public var confiabilidadeConformacao:Number;
		public var confiabilidadeProducao:Number;
		public var femea:Animal;
	}
}