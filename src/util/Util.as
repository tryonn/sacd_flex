package util
{
	import mx.formatters.DateFormatter;
	
	public class Util
	{
					
		public static function stringToDate(data:String):Date{
			
			if (data != "") {
				var novaData:String = data.substring(3,5) +"/"+ data.substring(0,2) +"/"+ data.substring(6);						
				var dateTime:Date = new Date(novaData);
				dateTime.setHours(12,0,0,0); 
				return dateTime;											
			} 
			else {
				return null;
			}						
			
		}
		
		public static function dateToString(data:Date):String{
			
			var format:DateFormatter = new DateFormatter();
			
			format.formatString = "DD/MM/YYYY";
			
			return format.format(data);						
			
		}		
		
	}
}