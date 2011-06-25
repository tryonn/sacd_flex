package events
{
	import flash.events.Event;
	
	import flexlib.mdi.containers.MDIWindow;
	
	public class MDIEvent extends Event
	{
		public static const OPEN_WINDOW : String = "MDIEvent.OPEN_WINDOW";
		public static const NEW_WINDOW : String = "MDIEvent.NEW_WINDOW";
		public static const CLOSE_WINDOW : String = "MDIEvent.CLOSE_WINDOW";
		public static const CASCADE : String = "MDIEvent.CASCADE";
		public static const TILE : String = "MDIEvent.TILE";
		
		public var window : MDIWindow;
		
		public function MDIEvent( type:String, window:MDIWindow = null)
		{
			this.window = window;
			super( type, true );
		}
	}
}