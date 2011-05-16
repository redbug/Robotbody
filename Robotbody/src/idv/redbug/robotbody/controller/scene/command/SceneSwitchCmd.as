package idv.redbug.robotbody.controller.scene.command
{
	
	import idv.redbug.robotbody.model.manager.SceneManager;
	import idv.redbug.robotbody.controller.scene.event.*;
	import org.robotlegs.mvcs.Command;
	
	
	public class SceneSwitchCmd extends Command
	{
		[Inject]
		public var _sceneManager		:SceneManager;
		
		[Inject]
		public var _event				:SceneEvent;
		
		override public function execute ():void
		{
			_sceneManager.targetScene = _event.targetScene;
			_sceneManager.discardScene();	//discard current scene.
		}	
	}
}