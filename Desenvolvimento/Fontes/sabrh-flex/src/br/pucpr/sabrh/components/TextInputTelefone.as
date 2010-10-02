package br.pucpr.sabrh.components
{
	import br.pucpr.sabrh.components.formatter.TelefoneFormatter;
	
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	
	import mx.controls.Alert;
	import mx.events.Request;
	
	import spark.components.TextInput;


	public class TextInputTelefone extends TextInput
	{
		protected var formatter:TelefoneFormatter;

		public function TextInputTelefone()
		{
			super();
			maxChars=10;
			restrict="0-9";

		}

		override protected function focusOutHandler(event:FocusEvent):void
		{

			if (formatter == null)
			{
				formatter=new TelefoneFormatter();
			}

			this.text=formatter.format(this.text);

		}

		override protected function focusInHandler(event:FocusEvent):void
		{

			if (formatter == null)
			{
				formatter=new TelefoneFormatter();
			}

			this.text=formatter.format(this.text);

		}

	}
}