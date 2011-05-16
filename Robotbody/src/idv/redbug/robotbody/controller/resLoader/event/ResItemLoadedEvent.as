package idv.redbug.robotbody.controller.resLoader.event
{
	import flash.events.Event;
	
	public class ResItemLoadedEvent extends Event
	{
		public static const LOADING_COMPLETE:String = "itemLoadedComplete";
		
		private var _key	:String;	
		private var _value	:Object;
		
		
		public function ResItemLoadedEvent( type:String, key:String, value:Object )
		{
			super( type );
			
			_key	= key;
			_value	= value;
		}
		
		override public function clone():Event
		{
			return new ResItemLoadedEvent( type, _key, _value );
		}
		
		override public function toString():String
		{
			return formatToString( "ResItemLoadedEvent", "type", "_key", "_value" );
		}

		public function get key():String
		{
			return _key;
		}

		public function set key( value:String ):void
		{
			_key = value;
		}

		public function get value():Object
		{
			return _value;
		}

		public function set value( value:Object ):void
		{
			_value = value;
		}
	}
}