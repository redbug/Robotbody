package idv.redbug.robotbody.controller.resLoader.event
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	public class ResLoaderEvent extends Event
	{
		public static const LOADING_COMPLETE	:String = "loadingComplete";
		public static const LOADING_START		:String = "loadingStart";
		public static const REMOVE_START		:String = "resRemoveStart";
		public static const REMOVE_COMPLETE		:String = "resComplete";
		
		private var _assetList		:Vector.<String>;	
		private var _assetContent	:Vector.<Object>;
		
		public function ResLoaderEvent( type:String, assetList:Vector.<String>, assetContent:Vector.<Object> = null )
		{
			super( type );
			
			_assetList		= assetList;
			_assetContent	= assetContent;
		}
		
		override public function clone():Event
		{
			return new ResLoaderEvent( type, _assetList, _assetContent );
		}
		
		override public function toString():String
		{
			return formatToString( "ResLoaderEvent", "type", "_assetList", "_assetContent" );
		}
		
		public function get assetList():Vector.<String>
		{
			return _assetList;
		}
		
		public function set assetList( value:Vector.<String> ):void
		{
			_assetList = value;
		}
		
		public function get assetContent():Vector.<Object>
		{
			return _assetContent;
		}
		
		public function set assetContent( value:Vector.<Object> ):void
		{
			_assetContent = value;
		}
	}
}