package components
{
	
	
	import mx.controls.DateField;
	import mx.events.FlexEvent;
	
	import util.Util;
	
	public class DateFieldpt extends DateField
	{
		

		private const diasNomes:Array = ["D","S","T","Q","Q","S","S"];

		private const mesesNomes:Array = ["Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"];


		public function DateFieldpt() {
			super();

			this.width=95;
			dayNames=diasNomes;
			monthNames=mesesNomes;
			formatString="DD/MM/YYYY";
			restrict="0-9";
			editable=true;			
			showToday=true;
			text = Util.dateToString(new Date());			
			addEventListener(FlexEvent.VALUE_COMMIT,completar);
		}
			
		private function completar(event:FlexEvent):void {
			
			var str:String = event.target.text as String;
			
			if ( str.charAt(2) != "/" || str.charAt(5) != "/" ) {
				
				var mask:String;
				var dataAtual:Date = new Date();

				if ( str.length == 2 ) {
					
					mask = str.substr(0, 2) + "/" + 
					(dataAtual.getMonth()+1).toString() + "/" +
					dataAtual.getFullYear();
					
					event.target.text = mask;
					
				} 
				else if ( str.length == 4 ) {
					
					mask = str.substr(0, 2) + "/" + str.substr(2,2) + "/" + 
					dataAtual.getFullYear().toString();
					
					event.target.text = mask;
					
				} 
				else if ( str.length == 6 ) {

					mask = str.substr(0, 2) + "/" + str.substr(2,2) + "/" + 
						str.substr(4, 4);
					
					event.target.text = mask;
				} 
				else if ( str.length == 8 ) {
					mask = str.substr(0, 2) + "/" + str.substr(2,2) + "/" + 
					str.substr(4, 4);

					event.target.text = mask;
				}

			}

		}
		
					
		
	}
}