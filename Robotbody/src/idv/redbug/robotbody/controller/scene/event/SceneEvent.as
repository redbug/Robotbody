package idv.redbug.robotbody.controller.scene.event
{
	import flash.events.Event;
	
	import idv.redbug.robotbody.model.scene.IScene;
	
	public class SceneEvent extends Event
	{
		public static const SCENE_SWITCH	:String	= "sceneSwitch";
		
		private var _targetScene:IScene;
		
		public function SceneEvent( type:String, targetScene:IScene )
		{
			super( type );
			_targetScene = targetScene;
		}
		
		override public function clone():Event
		{
			return new SceneEvent( type, _targetScene );
		}
		
		override public function toString():String
		{
			return formatToString( "SceneEvent", "type", "_targetScene" );
		}	

		public function get targetScene():IScene
		{
			return _targetScene;
		}

		public function set targetScene( value:IScene ):void
		{
			_targetScene = value;
		}
	}
}