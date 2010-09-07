package br.pucpr.sabrh.entity
{

	[RemoteClass(alias="br.pucpr.sabrh.entity.Usuario")]
	[Bindable]
	public class Usuario
	{
		public var codigo:Number;

		public var login:String;

		public var senha:String;

		public var status:String;

		public var perfil:String;

		public var cpf:String;

		public var nome:String;

		public var municipio:Municipio;

	}
}