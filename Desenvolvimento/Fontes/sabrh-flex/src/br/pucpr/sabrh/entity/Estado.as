package br.pucpr.sabrh.entity
{
	import mx.collections.ArrayCollection;

	[RemoteClass(alias="br.pucpr.sabrh.entity.Estado")]
	[Bindable]
	public class Estado
	{
		public var sigla:String;
		public var descricao:String;
	}
}