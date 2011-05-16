package idv.redbug.robotbody.controller.displayList.event
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class DisplayEvent extends Event
	{
		public static const ADD_TO_CONTEXTVIEW	:String = "addToContextView";
		public static const REMOVE_ONE			:String = "removeOneFromContextView";
		public static const CLEAR_CONTEXTVIEW	:String = "clearContextView";
		
		private var _disObj	:DisplayObject;
		private var _depth	:int;
		
		public function DisplayEvent( type:String, disObj:DisplayObject = null, depth:int = -1 )
		{
			super( type );
			
			_disObj = disObj;
			_depth	= depth;
		}
		
		override public function clone():Event
		{
			return new DisplayEvent( type, _disObj, _depth );
		}
		
		override public function toString():String
		{
			return formatToString( "DisplayEvent", "type", "_disObj", "_depth" );
		}
		
		public function get disObj():DisplayObject
		{
			return _disObj
		}
		
		public function set disObj( value:DisplayObject ):void
		{
			_disObj = value;
		}
		
		public function get depth():int
		{
			return _depth;
		}
		
		public function set depth( value:int ):void
		{
			_depth = value;
		}
		
	}
}