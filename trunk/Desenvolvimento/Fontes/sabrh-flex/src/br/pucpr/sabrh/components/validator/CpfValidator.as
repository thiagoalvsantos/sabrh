package br.pucpr.sabrh.components.validator
{
	import mx.utils.StringUtil;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;

	public class CpfValidator extends Validator
	{
		public function CpfValidator()
		{
			super();
		}

		override protected function doValidation(value:Object):Array
		{
			var inputValue:String=StringUtil.trim(String(value));

			var ValidatorResults:Array=new Array();
			ValidatorResults=super.doValidation(value);
			if (ValidatorResults.length > 0)
			{
				return ValidatorResults;
			}
			if (String(value).length == 0)
			{
				return ValidatorResults;
			}
			/////////////////////////////////

				inputValue=inputValue.replace('.', '');
				inputValue=inputValue.replace('.', '');
				inputValue=inputValue.replace('-', '');
			if (inputValue.length == 11)
			{

				var RegPattern:RegExp=/\D/;

				var a:Array=RegPattern.exec(String(value));

				if (a == null)
				{
					ValidatorResults.push(new ValidationResult(true, null, "CPF Inválido", "CPF deve conter apenas números"));
					return ValidatorResults;
				}
				else
				{
					if (inputValue == "00000000000" ||
						inputValue == "11111111111" ||
						inputValue == "22222222222" ||
						inputValue == "33333333333" ||
						inputValue == "44444444444" ||
						inputValue == "55555555555" ||
						inputValue == "66666666666" ||
						inputValue == "77777777777" ||
						inputValue == "88888888888" ||
						inputValue == "99999999999")
					{
						ValidatorResults.push(new ValidationResult(true, null, "CPF Inválido", "Número de CPF inválido"));
						return ValidatorResults;
					}

					var a:Array=new Array();
					var b:Number=new Number();
					var c:Number=11;

					for (var i:Number=0; i < 11; i++)
					{
						a[i]=inputValue.charAt(i);
						if (i < 9)
						{
							b+=(a[i] * --c);
						}
					}
					var x:Number;
					var y:Number;
					if ((x=(b % 11)) < 2)
					{
						a[9]=0;
					}
					else
					{
						a[9]=11 - x;
					}
					b=0;
					c=11;

					for (y=0; y < 10; y++)
						b+=(a[y] * c--);

					if ((x=b % 11) < 2)
					{
						a[10]=0;
					}
					else
					{
						a[10]=11 - x;
					}
	
					if ((inputValue.charAt(9) != a[9]) || (inputValue.charAt(10) != a[10]))
					{
						ValidatorResults.push(new ValidationResult(true, null, "CPF Inválido", "Número de CPF inválido"));
						return ValidatorResults;

					}
				}
			}
			else
			{
				if (inputValue.length == 0)
					return ValidatorResults;
				else
					ValidatorResults.push(new ValidationResult(true, null, "CPF Inválido", "Número de CPF inválido"));
				return ValidatorResults;
			}


			return ValidatorResults;



			/////////////////////////////////



			return ValidatorResults;

		}
	}
}