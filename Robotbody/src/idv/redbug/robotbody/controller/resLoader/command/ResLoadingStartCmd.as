package idv.redbug.robotbody.controller.resLoader.command
{
	import idv.redbug.robotbody.controller.resLoader.event.ResLoaderEvent;
	import idv.redbug.robotbody.model.resource.ResLoader;
	import org.robotlegs.mvcs.Command;
	
	public class ResLoadingStartCmd extends Command
	{
		[Inject]
		public var _resLoader		:ResLoader;
		
		[Inject]
		public var _event			:ResLoaderEvent;
		
		override public function execute ():void
		{
			_resLoader.addList( _event.assetList );
			_resLoader.startLoading();
		}
	}
}