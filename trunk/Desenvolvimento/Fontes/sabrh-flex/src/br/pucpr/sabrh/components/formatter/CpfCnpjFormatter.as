package br.pucpr.sabrh.components.formatter
{
	import mx.formatters.Formatter;

	public class CpfCnpjFormatter extends Formatter
	{
		public function CpfCnpjFormatter()
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
			var cpf:String=value.toString();



			if (value.length == 11)
			{
				cpf=cpf.substr(0, 3) + '.' + cpf.substr(3, 3) + '.' + cpf.substr(6, 3) + '-' + cpf.substr(9, 2);
			}
			else
			{
				cpf=cpf.replace('.', '');
				cpf=cpf.replace('.', '');
				cpf=cpf.replace('-', '');

			}

			return cpf;

		}

	}
}