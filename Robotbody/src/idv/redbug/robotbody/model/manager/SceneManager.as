package idv.redbug.robotbody.model.manager
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import idv.redbug.robotbody.controller.infoText.event.InfoTextEvent;
	import idv.redbug.robotbody.model.scene.IScene;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SceneManager extends Actor
	{
		private var _firstScene		:IScene;
		private var _currentScene	:IScene;
		private var _targetScene	:IScene;
		private var _root			:DisplayObject;
		private var _stage			:Stage;
		
        private var _stageWidth     :int;
        private var _stageHeight    :int;
        
		private var _manager		:BaseManager;
		
		public function SceneManager():void
		{
			super();
			_manager = new BaseManager();
		}	
		
		public function activateScene( targetScene:IScene ):void
		{
			_currentScene = targetScene;
			_currentScene.init();
			
			_targetScene = null;
		}	
		
		public function executeScene():void
		{
			_currentScene.run();
		}	
		
		public function discardScene():void
		{
			_currentScene.destroy();
		}
		
		public function switchToNextScene():void
		{
			if(_targetScene != null)
			{
				activateScene( _targetScene );
			}
		}	
	
		public function set targetScene( targetScene:IScene ):void
		{
			_targetScene = targetScene;
		}	
		
		
		public function add( key:String, value:Object ):void
		{
			_manager.add( key, value );
		}	
		
		public function getScene( key:String ):IScene
		{
			return IScene( _manager.get( key ) );
		}	
		
		public function length():int
		{
			return _manager.length();
		}	
		
		public function clearAll():void
		{
			_manager.clearAll();
		}	
		
		public function onClick( event:MouseEvent ):void
		{
			_currentScene.onClick( event );
		}
		
		public function onKeyDown( event:KeyboardEvent ):void
		{
			_currentScene.onKeyDown( event );
		}
		
		public function onMouseMove( event:MouseEvent ):void
		{
			_currentScene.onMouseMove( event );
		}

		public function switchPerformancePanel():void
		{
			dispatch( new InfoTextEvent( InfoTextEvent.SWTICH_VISIBLE ) );
		}
		
		public function set firstScene( scene:IScene ):void
		{
			_firstScene = scene;
		}

		public function get firstScene():IScene
		{
			return _firstScene;
		}	
		
		public function get currentScene():IScene
		{
			return _currentScene;
		}
		

		public function set root( val:DisplayObject ):void
		{
			_root = val;
		}

		public function get root():DisplayObject
		{
			return _root;
		}

		public function set stage( val:Stage ):void
		{
			_stage = val;
            _stageWidth = _stage.stageWidth;
            _stageHeight = _stage.stageHeight;
		}

		public function get stage():Stage
		{
			return _stage;
		}

        public function get stageWidth():int
        {
            return _stageWidth;
        }

        public function get stageHeight():int
        {
            return _stageHeight;
        }
	}
}