package idv.redbug.robotbody.view.ui
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import idv.redbug.robotbody.util.Toolkits;
	
	
	public class InfoText extends Sprite
	{
		protected var _memory_txt		:TextField;
		protected var _frameRate_txt	:TextField;
		
		public function InfoText ()
		{
			init();
		}

		protected function init ():void
		{
			_memory_txt = new TextField();
			_memory_txt.x = 0;
			_memory_txt.y = 0;
			_memory_txt.width = 200;
			_memory_txt.height = 30;
			_memory_txt.mouseEnabled = false;
			_memory_txt.visible = false;
            _memory_txt.defaultTextFormat = new TextFormat( "Arial", 14, 0x00CCFF, true );
            
			_frameRate_txt = new TextField();
			_frameRate_txt.x = 0;
			_frameRate_txt.y = 20;
			_frameRate_txt.width = 200;
			_frameRate_txt.height = 30;
			_frameRate_txt.mouseEnabled = false;
			_frameRate_txt.visible = false;
            _frameRate_txt.defaultTextFormat = new TextFormat( "Arial", 14, 0x00CCFF, true );
			
			addChild( _memory_txt );
			addChild( _frameRate_txt );
			
			this.addEventListener( Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true );	//removed in onAddedToStage()
			
		}
		
		public function showMemory( event:Event = null ):void
		{
			_memory_txt.text = Toolkits.showMemory();
		}	
		
		public function showFrameRate( event:Event = null ):void
		{
			_frameRate_txt.text = Toolkits.showFrameRate();
		}
		
		public function switchVisible():void
		{
			_memory_txt.visible = !_memory_txt.visible;
			_frameRate_txt.visible = !_frameRate_txt.visible
		}
		
		private function onAddedToStage( event:Event ):void
		{
			this.removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );	
			
			this.buttonMode		= true;
			this.useHandCursor	= true;
			
			this.addEventListener( MouseEvent.MOUSE_DOWN, onStratDragging, false, 0, true );				
			this.addEventListener( MouseEvent.MOUSE_UP, onStopDragging, false, 0, true );
			this.addEventListener( MouseEvent.CLICK, onClick, false, 0, true );
		}
		
		private function onClick( event:MouseEvent ):void
		{
			event.stopImmediatePropagation();
		}
		
		private function onStratDragging( event:MouseEvent ):void
		{
			this.startDrag();
			event.stopImmediatePropagation();
		}
		
		private function onStopDragging( event:MouseEvent ):void
		{
			this.stopDrag();
			event.stopImmediatePropagation();
		}
	}
}