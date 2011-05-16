package idv.redbug.robotbody.controller.resLoader.command
{
	import idv.redbug.robotbody.controller.resLoader.event.*;
	import idv.redbug.robotbody.controller.resLoader.command.*;
	import idv.redbug.robotbody.model.manager.ResManager;
	
	import org.robotlegs.mvcs.Command;
	
	public class ResReleaseStartCmd extends Command
	{
		[Inject]
		public var _resManager		:ResManager;
		
		override public function execute ():void
		{
			_resManager.clearAll();		
			dispatch( new ResLoaderEvent( ResLoaderEvent.REMOVE_COMPLETE, null ) );
		}
	}
}