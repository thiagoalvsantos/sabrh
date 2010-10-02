package br.pucpr.sabrh.components.formatter
{
	import mx.formatters.Formatter;

	public class TelefoneFormatter extends Formatter
	{
		public function TelefoneFormatter()
		{
			super();
		}

		// Override format().
		/**
		 *
		 * @param value
		 * @return
		 *
		 */
		override public function format(value:Object):String
		{
			var telefone:String=value.toString();

			if (value.length == 10)
			{
				telefone = '(' + telefone.substr(0, 2) + ')' + telefone.substr(2, 4) + '-' + telefone.substr(6, 4);
			}
			else
			{
				telefone=telefone.replace('(', '');
				telefone=telefone.replace(')', '');
				telefone=telefone.replace('-', '');

			}

			return telefone;

		}

	}
}