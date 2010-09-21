package br.pucpr.sabrh.entity
{

	[RemoteClass(alias="br.pucpr.sabrh.entity.Propriedade")]
	[Bindable]
	public class Propriedade
	{

		public var codigo:Number;
		public var proprietario:Usuario;
		public var nome:String;
		public var municipio:Municipio;
		public var telefone:String;
	}

}