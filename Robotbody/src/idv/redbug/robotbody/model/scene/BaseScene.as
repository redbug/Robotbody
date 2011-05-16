package idv.redbug.robotbody.model.scene
{
	import idv.redbug.robotbody.controller.displayList.event.DisplayEvent;
	import idv.redbug.robotbody.controller.resLoader.event.*;
	import idv.redbug.robotbody.controller.scene.event.SceneEvent;
	import idv.redbug.robotbody.model.resource.*;
	import idv.redbug.robotbody.model.manager.ResManager;
	import idv.redbug.robotbody.util.SoundManager;
	
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Actor;
	import idv.redbug.robotbody.model.manager.SceneManager;
	
	public class BaseScene extends Actor implements IScene
	{
		//TODO: It would be better if the asset list could be loaded from a XML file.
		protected const LIST_SWF		:Vector.< String >	= new Vector.< String >();
		protected const LIST_MUSIC		:Vector.< String >	= new Vector.< String >();
		protected const LIST_TXT		:Vector.< String >	= new Vector.< String >();
		protected const LIST_XML		:Vector.< String >	= new Vector.< String >();
		
		protected var _assetList		:Vector.< String >	= new Vector.< String >();
		private var _soundManager		:SoundManager		= SoundManager.instance;
		
		
		[Inject]
		public var resManager		:ResManager;
		
		[Inject]
		public var sceneManager     :SceneManager;
		
		//Constructor
		public function BaseScene()
		{
		
		}
		
		//-----------------------------------------------------
		//  Implementation for IScene Interface:
		//		init()
		//		run()
		//		destroy()
		//		switchTo()
		//		clearContextView()
		//		addToContextView()
		//		get assetList()		
		//-----------------------------------------------------
		
		public function init():void
		{
			_assetList = _assetList.concat( LIST_SWF ).concat( LIST_MUSIC ).concat( LIST_TXT ).concat( LIST_XML );
			dispatch( new ResLoaderEvent( ResLoaderEvent.LOADING_START, _assetList ) );
		}
		
		public function run():void
		{
			
		}
		
		public function destroy():void
		{
			//-----the override function must make sure performing folllowing tasks.-----------------------------------
			//Unregister all event listners (particularly Event.ENTER_FRAME, and mouse and keyboard listener).
			//Stop any currently running intervals (via clearInterval()).
			//Stop any Timer objects(via the Time's class instance method stop()).
			//Stop any sounds from playing.
			//Stop the main timeline if it's currently playing.
			//Stop any movie clips that are currently playing.
			//Close any connected nework object, such as an instances of Loader, URLLoader, Socket, XMLSocket, LocalConnection, NetConnection, and NetStream
			//Nullify all references to Camera or Microphone.
			//--------------------------------------------------------------------------------------------------------
			
			_soundManager.clearAll();
			dispatch( new ResLoaderEvent( ResLoaderEvent.REMOVE_START, null) );
		}
		
		public function switchTo( targetScene:IScene ):void
		{
			dispatch( new SceneEvent( SceneEvent.SCENE_SWITCH, targetScene ) );
		}
		
		/****************************************************************************
		 * @param disObj the display object you're gonna add to the display list.
		 * @param depth The depth to which the child is added. Just use the default value 
		 * 				if you wanna add your display object on the topmost layer.   
		 ****************************************************************************/
		public function addToContextView( disObj:DisplayObject, depth:int=-1 ):void
		{
			dispatch( new DisplayEvent( DisplayEvent.ADD_TO_CONTEXTVIEW, disObj, depth ) ); 
		}
		
		public function removeFromContextView( disObj:DisplayObject ):void
		{
			dispatch( new DisplayEvent( DisplayEvent.REMOVE_ONE, disObj ) );
		}
		
		public function clearContextView():void
		{
			dispatch( new DisplayEvent( DisplayEvent.CLEAR_CONTEXTVIEW ) ); 
		}
		
		public function reset( object:* = null ):void
		{
			
		}
		
		public function makeSWFList( list:Array ):void{

			for each( var fileName:String in list ){
				LIST_SWF.push( fileName );
			}
			
		}
		
		public function makeTXTList( list:Array ):void{
		
			for each( var fileName:String in list ){
				LIST_TXT.push( fileName );
			}
			
		}
		
		public function makeMP3List( list:Array ):void{
		
			for each( var fileName:String in list ){
				LIST_MUSIC.push( fileName );
			}
			
		}
		
		public function makeXMLList( list:Array ):void{
			
			for each( var fileName:String in list ){
				LIST_XML.push( fileName );
			}
			
		}
		
		public function onClick( event:MouseEvent ):void{}
		public function onMouseMove( event:MouseEvent ):void{}
		public function onKeyDown( event:KeyboardEvent ):void{}
		
		public function accessSWF():void{}
		public function accessTXT():void{}
		public function accessMP3():void{}
		public function accessXML():void{}
		
		public function get assetList():Vector.<String>
		{
			return _assetList;
		}

        public function get soundManager():SoundManager
        {
            return _soundManager;
        }

	}
}