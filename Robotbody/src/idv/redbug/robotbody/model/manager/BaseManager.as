package idv.redbug.robotbody.model.manager
{
	import flash.utils.Dictionary;

	public class BaseManager implements IManager
	{
		private var _map:Dictionary;
		
		public function BaseManager()
		{
			_map = new Dictionary( true );
		}
		
		public function add( key:String, value:Object ):void
		{
			_map[ key ] = value;
		}
		
		public function get( key:String ):Object
		{
			return _map[ key ];
		}
		
		public function length():int
		{
			var num	:int = 0;
			
			for each( var key:* in _map )
			{
				num++;
			}

			return num;
		}
		
		public function clearAll():void
		{
			for each ( var key:String in _map )
			{
				delete _map[ key ];
			}
            
            _map = new Dictionary( true );
		}	
	}
}