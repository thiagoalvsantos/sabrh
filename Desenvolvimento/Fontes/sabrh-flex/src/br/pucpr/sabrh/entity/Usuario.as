package br.pucpr.sabrh.entity
{
	[RemoteClass(alias="br.pucpr.br.entity.Usuario")]
	[Bindable]
	public class Usuario
	{
		public var codigo:Number;
		
		public var login:String;
		
		public var senha:String;
		
		public var status:String;
		
		public var perfil: String;

	}
}