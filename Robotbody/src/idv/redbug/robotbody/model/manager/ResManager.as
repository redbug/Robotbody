package idv.redbug.robotbody.model.manager
{
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import idv.redbug.robotbody.model.resource.ResLoader;
	
	public class ResManager
	{
		[Inject]
		public var _resLoader		:ResLoader;
		
		private var _manager		:BaseManager;
		
		public function ResManager():void
		{
			super();
			
			_manager = new BaseManager();
		}
	
		public function add( key:String, value:Object ):void
		{
			_manager.add( key, value );
		}	
		
		public function get( key:String ):Object
		{
			return _manager.get( key );
		}	
		
		public function length():int
		{
			return _manager.length();
		}	
		
		public function clearAll():void
		{
			_manager.clearAll();
            _resLoader.sgProgress.removeAll();
		}	
		
		public function set progressHandler( val:Function ):void
		{
			_resLoader.sgProgress.add( val );
		}

        public function get dir_asset():String
        {
            return _resLoader.dir_asset;
        }

        public function set dir_asset(value:String):void
        {
            _resLoader.dir_asset = value;
        }
	}
}