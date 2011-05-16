package idv.redbug.robotbody.controller.resLoader.command
{
	import idv.redbug.robotbody.controller.resLoader.event.ResItemLoadedEvent;
	import idv.redbug.robotbody.model.manager.ResManager;
	
	import org.robotlegs.mvcs.Command;
	
	public class ItemLoadingCompleteCmd extends Command
	{
		[Inject]
		public var _event			:ResItemLoadedEvent;

		[Inject]
		public var _resManager		:ResManager;
		
		override public function execute ():void
		{
			var key		:String		= _event.key;
			var value	:Object		= _event.value;	
			
			_resManager.add( key, value );
		}
	}
}