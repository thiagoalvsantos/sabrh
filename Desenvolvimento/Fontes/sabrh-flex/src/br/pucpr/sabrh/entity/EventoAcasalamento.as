package br.pucpr.sabrh.entity
{
	
	[RemoteClass(alias="br.pucpr.sabrh.entity.EventoAcasalamento")]
	[Bindable]
	public class EventoAcasalamento
	{
		public var codigo:Number;
		public var acasalamento:Acasalamento;
		public var tipoEventoAcasalamento:String;
		public var dataEvento:Date;
		public var comentario:String;
	}
}