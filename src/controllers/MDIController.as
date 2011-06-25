package controllers
{
	import events.MDIEvent;
	
	import flexlib.mdi.containers.MDICanvas;
	import flexlib.mdi.containers.MDIWindow;
	
	import mx.collections.ArrayCollection;
	
	public class MDIController extends ControllerBase
	{
		
		[Bindable]
		public var mdiCanvas:MDICanvas;
		
		public function MDIController()
		{
			super();
		}
		
		[Mediate(event="MDIEvent.OPEN_WINDOW",properties="window")]
		public function openWindow(window:MDIWindow):void
		{
			var found:Boolean = false;
			
			for each(var w:MDIWindow in mdiCanvas.windowManager.windowList)
			{
				if (w.title == window.title) 
				{
					mdiCanvas.windowManager.bringToFront(window);
					found = true;
					break;
				}
			}
			
			if (!found)
			{
				this.addWindow(window);
			}
		}
		
		[Mediate(event="MDIEvent.NEW_WINDOW",properties="window")]
		public function newWindow(window:MDIWindow):void
		{
			addWindow(window);
		}

		[Mediate(event="MDIEvent.CLOSE_WINDOW",properties="window")]
		public function closeWindow(window:MDIWindow):void
		{
			this.mdiCanvas.windowManager.remove(window);
		}
		
		[Mediate(event="MDIEvent.CASCADE")]
		public function cascadeWindow():void
		{
			this.mdiCanvas.windowManager.cascade();
		}
		
		[Mediate(event="MDIEvent.TILE")]
		public function tileWindow():void
		{
			this.mdiCanvas.windowManager.tile(true,5);
		}
		
		protected function addWindow(window:MDIWindow):void
		{
			this.mdiCanvas.windowManager.add(window);
		}
		
		
	}
}