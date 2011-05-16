package idv.redbug.robotbody.view.mediator
{
	import idv.redbug.robotbody.controller.infoText.event.InfoTextEvent;
	import idv.redbug.robotbody.model.manager.SceneManager;
	import idv.redbug.robotbody.view.ui.InfoText;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	public class StageMediator extends Mediator
	{
		[Inject]
		public var _sceneManager	:SceneManager;
		
		override public function onRegister ():void
		{
			eventMap.mapListener( contextView.stage, MouseEvent.MOUSE_MOVE, onMouseMove );
			eventMap.mapListener( contextView.stage, MouseEvent.CLICK, onClick );
			eventMap.mapListener( contextView.stage, KeyboardEvent.KEY_DOWN, onKeyDown );
		}
		
		protected function onMouseMove( event:MouseEvent ):void
		{
			_sceneManager.onMouseMove( event );
		}
		
		protected function onClick( event:MouseEvent ):void
		{
			_sceneManager.onClick( event );
		}
		
		protected function onKeyDown( event:KeyboardEvent ):void
		{
			_sceneManager.onKeyDown( event );
		}
	}
}