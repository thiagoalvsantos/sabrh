package br.pucpr.sabrh.entity
{

	[RemoteClass(alias="br.pucpr.sabrh.entity.Estado")]
	[Bindable]
	public class Estado
	{
		public function Estado()
		{
		}

		public var sigla:String;
		public var descricao:String;
	}
}