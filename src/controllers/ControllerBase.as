package controllers
{
	import flash.events.IEventDispatcher;
	
	import org.swizframework.utils.services.ServiceHelper;

	public class ControllerBase
	{
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var serviceHelper:ServiceHelper;
	}
}