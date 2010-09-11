package br.pucpr.sabrh.components
{
	import br.pucpr.sabrh.components.formatter.CpfCnpjFormatter;

	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;

	import mx.controls.Alert;

	import spark.components.TextInput;


	public class TextInputCPF extends TextInput
	{
		protected var formatter:CpfCnpjFormatter;

		public function TextInputCPF()
		{
			super();
			maxChars=11;
		}

		override protected function focusOutHandler(event:FocusEvent):void
		{

			if (formatter == null)
			{
				formatter=new CpfCnpjFormatter();
			}

			this.text=formatter.format(this.text);

		}

		override protected function focusInHandler(event:FocusEvent):void
		{

			if (formatter == null)
			{
				formatter=new CpfCnpjFormatter();
			}

			this.text=formatter.format(this.text);

		}


		override protected function keyDownHandler(event:KeyboardEvent):void
		{
			Alert.show("opa");
		}


	}
}