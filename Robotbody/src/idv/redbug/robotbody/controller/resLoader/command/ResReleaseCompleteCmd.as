package idv.redbug.robotbody.controller.resLoader.command
{
	import org.robotlegs.mvcs.Command;
	import idv.redbug.robotbody.model.manager.SceneManager;
	
	public class ResReleaseCompleteCmd extends Command
	{
		[Inject]
		public var _sceneManager	:SceneManager;
		
		override public function execute ():void
		{
			_sceneManager.switchToNextScene();	
		}	
	}
}