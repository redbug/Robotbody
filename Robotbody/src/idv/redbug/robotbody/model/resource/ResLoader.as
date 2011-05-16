package idv.redbug.robotbody.model.resource
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	
	import flash.display.*;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	import flash.utils.Dictionary;
	
	import idv.redbug.robotbody.controller.resLoader.event.*;
	import idv.redbug.robotbody.util.Toolkits;
	
	import org.osflash.signals.Signal;
	import org.robotlegs.mvcs.Actor;
	
	public class ResLoader extends Actor
	{
		public static const TYPE_SWF	:int			= 0;
		public static const TYPE_MUSIC	:int			= 1;
		public static const TYPE_TXT	:int			= 2;
		public static const TYPE_XML	:int			= 3;
		
		private const DIR_SWF			:String			= "swf/";
		private const DIR_MUSIC			:String			= "music/";
		private const DIR_TXT			:String			= "txt/";
		private const DIR_XML			:String			= "xml/";

        private var _dir_asset			:String			= "asset/";
        
		private var _bulkLoader			:BulkLoader;
		private var _sgProgress			:Signal;
		
        private var _percentPerItem     :Number;
        private var _totalItem          :int;
        
		public function ResLoader()
		{
			super();
			
			_sgProgress = new Signal( String, String, String );	//item name, loading percent, total percent 
			_bulkLoader = new BulkLoader( "sceneLoader" );	
		}
		
		/************************************************************
		* Add resource to loading list.
		* @param type	using the static variable of ResLoader class, 
		*				ex. ResLoader.TYPE_SWF for the .swf file.
		* @param name	the file name of the resource. 
		*************************************************************/ 
		public function add( type:int, name:String ):void
		{
			var fullQualifiedFileName	:String;
			
			switch(type)
			{
				case TYPE_SWF:
					fullQualifiedFileName	= new String(_dir_asset + DIR_SWF);
					break;
				
				case TYPE_MUSIC:
					fullQualifiedFileName	= new String(_dir_asset + DIR_MUSIC);
					break;
				
				case TYPE_TXT:
					fullQualifiedFileName	= new String(_dir_asset + DIR_TXT);
					break;
				
				case TYPE_XML:
					fullQualifiedFileName	= new String(_dir_asset + DIR_XML);
					break;
				
				default:
					throw new Error("Resource type is invalid.");
					break;
			}
			
//			var loaderContext: LoaderContext = new LoaderContext();
//			loaderContext.applicationDomain = ApplicationDomain.currentDomain;

			_bulkLoader.add( fullQualifiedFileName + name, {id:name/*, context:loaderContext*/} );

			_bulkLoader.get( name ).addEventListener( BulkLoader.PROGRESS, progressHandler );
			_bulkLoader.get( name ).addEventListener( BulkLoader.COMPLETE, onOneItemLoaded );
		}	
		
		public function addList( assetList:Vector.<String> ):void
		{
			var type		:int;
			var typeName	:String;
			
			for each ( var assetName:String in assetList )
			{
				typeName = Toolkits.extractExtension( assetName );

				switch( typeName )
				{
					case "swf":
						type = ResLoader.TYPE_SWF;
						break;
					
					case "mp3":
						type = ResLoader.TYPE_MUSIC;
						break;
					
					case "txt":
						type = ResLoader.TYPE_TXT;
						break;
					
					case "xml":
						type = ResLoader.TYPE_XML;
						break;
					
					default:
						type = ResLoader.TYPE_TXT;
						break;
				}

				add( type, assetName );	
			}	
		}	
		
		public function startLoading():void
		{
			_bulkLoader.addEventListener( BulkLoader.COMPLETE, onAllItemsLoaded );
            
            _totalItem = _bulkLoader.itemsTotal;
            
            if( _totalItem != 0 ){
                _percentPerItem = 1 / Number( _totalItem );
                _bulkLoader.start();
            }else{
                dispatch( new ResLoaderEvent( ResLoaderEvent.LOADING_COMPLETE, null, null ) );
            }
			
		}
		
		private function onOneItemLoaded( event:Event ):void
		{
			var item:LoadingItem = event.target as LoadingItem;
			
			item.removeEventListener( BulkLoader.COMPLETE, onOneItemLoaded );

			dispatch( new ResItemLoadedEvent( ResItemLoadedEvent.LOADING_COMPLETE, item.id, item.content ) );
		}
		
		private function onAllItemsLoaded( event:Event ):void
		{
			var loader	:BulkLoader = event.target as BulkLoader;
			
			loader.removeEventListener( BulkLoader.COMPLETE, onAllItemsLoaded );
	
			var assetList		:Vector.<String> 		= new Vector.<String>();
			var assetContent	:Vector.<Object>		= new Vector.<Object>();	
			
			for each (var item:LoadingItem in loader.items)
			{
				item.removeEventListener( BulkLoader.PROGRESS, progressHandler );
					
				assetList.push( item.id );
				assetContent.push( item.content );
			}

			loader.removeAll();
			dispatch( new ResLoaderEvent( ResLoaderEvent.LOADING_COMPLETE, assetList, assetContent ) );
		}	

		public function progressHandler( event:ProgressEvent ):void
		{
			var item                 :LoadingItem = event.target as LoadingItem;
            var item_percent_loaded  :Number = item.percentLoaded;
            var total_percent_loaded :Number = ( _bulkLoader.itemsLoaded + item_percent_loaded ) * _percentPerItem; 

			_sgProgress.dispatch( String( item.id ), String( int( item.percentLoaded * 100 ) ), String( int( total_percent_loaded * 100 ) ) );
		}

		public function get sgProgress():Signal
		{
			return _sgProgress;
		}

        public function get dir_asset():String
        {
            return _dir_asset;
        }

        public function set dir_asset(value:String):void
        {
            _dir_asset = value;
        }

	}
}