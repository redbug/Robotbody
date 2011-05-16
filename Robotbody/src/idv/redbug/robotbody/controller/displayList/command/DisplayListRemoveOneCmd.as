package idv.redbug.robotbody.controller.displayList.command
{
	import flash.display.DisplayObject;
	import idv.redbug.robotbody.controller.displayList.event.DisplayEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class DisplayListRemoveOneCmd extends Command
	{
		[Inject]
		public var _event:DisplayEvent;
		
		override public function execute ():void
		{
			contextView.removeChild( _event.disObj );
		}
	}
}