package idv.redbug.robotbody.controller.robotlegs.command
{
	import flash.display.Scene;
	
	import idv.redbug.robotbody.view.ui.InfoText;
	import idv.redbug.robotbody.model.manager.SceneManager;
	
	import org.robotlegs.mvcs.Command;
	
	public class StartupCmd extends Command
	{
		[Inject]
		public var _sceneManager		:SceneManager;
		
		override public function execute():void
		{
			contextView.addChild( new InfoText() );
			_sceneManager.activateScene( _sceneManager.firstScene );
		}
		
	}
}