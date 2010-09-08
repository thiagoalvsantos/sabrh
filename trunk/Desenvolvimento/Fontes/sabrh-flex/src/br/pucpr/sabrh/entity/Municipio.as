package br.pucpr.sabrh.entity
{

	[RemoteClass(alias="br.pucpr.sabrh.entity.Municipio")]
	[Bindable]
	public class Municipio
	{
		public function Municipio()
		{
		}
			public var codigo:Number;
			public var descricao:String;
			public var estado:Estado;
			
	}
}