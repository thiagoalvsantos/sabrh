package br.pucpr.sabrh.entity
{
	import mx.collections.ArrayCollection;
	import mx.collections.ListCollectionView;
	
	[RemoteClass(alias="br.pucpr.sabrh.entity.FiltroAcasalamento")]
	[Bindable]
	public class FiltroAcasalamento
	{
		public var listaConformacao:ArrayCollection;
		public var listaProducao:ArrayCollection
		public var confiabilidadeConformacao:Number;
		public var confiabilidadeProducao:Number;
		public var femea:Animal;
	}
}