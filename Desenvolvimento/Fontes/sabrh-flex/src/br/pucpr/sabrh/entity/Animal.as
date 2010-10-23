package br.pucpr.sabrh.entity
{
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;

	import spark.components.List;
	import spark.primitives.Line;

	[RemoteClass(alias="br.pucpr.sabrh.entity.Animal")]
	[Bindable]
	public class Animal
	{
		public var registro:String;
		public var nome:String;
		public var apelido:String;
		public var propriedade:Propriedade;
		public var pai:Animal;
		public var mae:Animal;
		public var dataNascimento:Date;
		public var sexo:String;
		public var listaClassificacao:Array;
		public var status:String;
	}
}