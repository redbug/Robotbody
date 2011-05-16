package idv.redbug.robotbody.controller.resLoader.command
{
	import idv.redbug.robotbody.model.manager.SceneManager;
	import org.robotlegs.mvcs.Command;
	
	public class ResLoadingCompleteCmd extends Command
	{
		[Inject]
		public var _sceneManager	:SceneManager;
		
		override public function execute ():void
		{
			_sceneManager.executeScene();
		}
	}
}