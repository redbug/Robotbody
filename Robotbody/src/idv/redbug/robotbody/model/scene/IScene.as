package idv.redbug.robotbody.model.scene
{
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	public interface IScene
	{
		function init()		:void;			//call back by sceneManager 
		function run()		:void;			//call back by sceneManager
		function destroy()	:void;			//call back by sceneMaanger
		
		function switchTo( targetScene:IScene ):void;
		
		function addToContextView( disObj:DisplayObject, depth:int = -1 ):void;
		function removeFromContextView( disObj:DisplayObject ):void;
		function clearContextView():void;
		function reset( object:* = null ):void
		
		function onClick( event:MouseEvent ):void;
		function onMouseMove( event:MouseEvent ):void;
		function onKeyDown( event:KeyboardEvent ):void;
		
		function makeSWFList( list:Array ):void;
		function makeTXTList( list:Array ):void;
		function makeMP3List( list:Array ):void;
		function makeXMLList( list:Array ):void;
		
		function accessSWF():void;
		function accessTXT():void;
		function accessMP3():void;
		function accessXML():void;
		
		function get assetList():Vector.<String>;
	}
}