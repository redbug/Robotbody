package idv.redbug.robotbody.view.mediator
{
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	import idv.redbug.robotbody.view.ui.InfoText;
	import idv.redbug.robotbody.controller.infoText.event.InfoTextEvent;
	
	public class InfoTextMediator extends Mediator
	{
		[Inject]
		public var _view:InfoText;
		
		override public function onRegister ():void
		{
			eventMap.mapListener( _view, Event.ENTER_FRAME, _view.showMemory );
			eventMap.mapListener( _view, Event.ENTER_FRAME, _view.showFrameRate );
			eventMap.mapListener( eventDispatcher, InfoTextEvent.SWTICH_VISIBLE, switchVisible ); 
		}
		
		public function switchVisible( event:InfoTextEvent ):void
		{
			contextView.addChild( _view );
			_view.switchVisible();
		}
		
	}
}