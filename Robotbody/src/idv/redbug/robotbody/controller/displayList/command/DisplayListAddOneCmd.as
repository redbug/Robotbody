package idv.redbug.robotbody.controller.displayList.command
{
	import flash.display.DisplayObject;
	
	import idv.redbug.robotbody.controller.displayList.event.DisplayEvent;
	import org.robotlegs.mvcs.Command;
	
	public class DisplayListAddOneCmd extends Command
	{
		[Inject]
		public var _event:DisplayEvent;
		
		override public function execute ():void
		{
			var disObj		:DisplayObject	= _event.disObj;
			var depth		:int			= _event.depth;
			
			if( depth == -1 ){
				contextView.addChild( disObj );
			}else{
				contextView.addChildAt( disObj, depth );
			}
		}
	}
}