package services
{
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	public class ServiceBase extends RemoteObject
	{
		public function ServiceBase(source:String)
		{
			super("amfphp");
			this.source = source;
			this.endpoint = "amfphp/gateway.php";
			this.showBusyCursor = true;
			this.addEventListener(FaultEvent.FAULT,OnFault);
		}
		
		protected function OnFault(e:FaultEvent):void
		{
			Alert.show(e.fault.faultString,"Erro" );
		}
	}
}