package idv.redbug.robotbody.util
{
//	import com.adobe.images.JPGEncoder;
	
	import flash.display.*;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.media.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.*;
	
	import org.osflash.signals.natives.NativeSignal;
	
	public class Toolkits
	{
		static public var designatedFrameRate	:Number		= 0;  
		static private var lastFrameTime		:Number;
		
		public function Toolkits( enforcer:SingletonEnforcer ){
			if( enforcer == null )
				throw "Toolkits can not be instantiated!" 
		}
		
		static public function traverseAllDescendants( container:DisplayObjectContainer, handler:Function=null ):void
		{
			var len:int = container.numChildren;
			for( var i:int = 0; i < len; ++i ){
				
				var thisChild:DisplayObject = container.getChildAt(i);
				
				if( thisChild is DisplayObjectContainer ){
					traverseAllDescendants( DisplayObjectContainer( thisChild), handler );
				}
				else{
					
					if ( handler == null ){
						trace( thisChild.name );
					}
					else{
						handler( thisChild );
					}
					
				}
				
			}
		}

		static public function removeAllChildren( container:DisplayObjectContainer ):void
		{
			while( container.numChildren > 0 ){
				container.removeChildAt( 0 );
			}
		}
		
//		static public function captureScreenShot(stage:Stage):void
//		{
//			var bitmapData	:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight, true);
//			var bitmap		:Bitmap		= new Bitmap(bitmapData, "auto", true);
//			var jpgEncoder	:JPGEncoder	= new JPGEncoder(90);
//			
//			bitmapData.draw(stage);
//			
//			var byteData	:ByteArray	= jpgEncoder.encode(bitmapData);
//			
//			var file:FileReference = new FileReference();
//			file.save(byteData, "screenshop.jpg");			
//		}
		
		static public function showFrameRate():String
		{
			var now				:Number = getTimer();
			var	elapsed			:Number = now - lastFrameTime;
			var framePerSecond	:Number = Math.floor( 1000 / elapsed );
			lastFrameTime = now;
			
			return "Frame Rate: " + String( framePerSecond ) + " / " + String( designatedFrameRate );
		}
		
		static public function showMemory():String
		{
			return "Memory Usage: " + String( System.totalMemory / 1024 ) + " kb";
		}
		
		static public function showFlashPlayerVersion():String
		{
			return "Flash Player Version: " + Capabilities.version;
		}

		static public function showPlayerType():String
		{
			return "Flash Player Type: " + Capabilities.playerType;
		}
		
		static public function showIsDebugPlayer():String
		{
			if( Capabilities.isDebugger ){
				return "Debug Player: Yes";
			}
			else{
				return "Debug Player: No";
			}
		}
				
		static public function extractExtension( fileName:String ):String
		{
			return fileName.substring( fileName.indexOf(".") + 1, fileName.length );
		}	
		
		static public function playFromAToB( mc:MovieClip, from:Object, to:Object, callBack:Function=null ):void
		{
			var sgEnterFrame:NativeSignal = new NativeSignal( mc, Event.ENTER_FRAME, Event );
			
			sgEnterFrame.add(
				function( event:Event ):void{
					if( mc.currentFrameLabel == to ){
						mc.stop();
						sgEnterFrame.removeAll();
						if( callBack != null ){
							callBack();
						}
					}
				}
			);
			
			mc.gotoAndPlay( from );
		}
		
		static public function playFromAToEND( mc:MovieClip, from:Object, callBack:Function=null ):void
		{
			var sgEnterFrame:NativeSignal = new NativeSignal( mc, Event.ENTER_FRAME, Event );
			
			sgEnterFrame.add(
				function( event:Event ):void{
					if( mc.currentFrame == mc.totalFrames ){
						mc.stop();
						sgEnterFrame.removeAll();
						if( callBack != null ){
							callBack();
						}
					}
				}
			);
			
			mc.gotoAndPlay( from );
		}
		
		static public function playToEnd( mc:MovieClip, callBack:Function=null ):void
		{
			var sgEnterFrame:NativeSignal = new NativeSignal( mc, Event.ENTER_FRAME, Event );
			
			sgEnterFrame.add(
				function( event:Event ):void{
					if( mc.currentFrame == mc.totalFrames ){
						mc.stop();
						sgEnterFrame.removeAll();
						if( callBack != null ){
							callBack();
						}	
					}
				}
			);
			
			mc.play();
		}
		
		static public function checkIfReachFrameLabel( mc:MovieClip, targetLabel:Object, callBack:Function ):void
		{
			var sgEnterFrame:NativeSignal = new NativeSignal( mc, Event.ENTER_FRAME, Event );
			
			sgEnterFrame.add(
				function( event:Event ):void{
					if( mc.currentFrameLabel == targetLabel ){
						sgEnterFrame.removeAll();
						if( callBack != null ){
							callBack();
						}
					}
				}
			);
		}

		static public function timerTrigger( timer:Timer, callBack:Function ):void
		{
			var sgTimer:NativeSignal = new NativeSignal( timer, TimerEvent.TIMER, TimerEvent );
			sgTimer.addOnce( callBack );
			timer.start();
		}
        
        
        static public function getQueryStringFromHTML():Object
        {
            if ( !ExternalInterface.available) {
                return null;
            }
            
            var params:Object = {};
            
            var queryStr:String = ExternalInterface.call( "window.location.search.substring", 1 );
            
            if( queryStr ){
                
                var pairs:Array = queryStr.split("&");
                var pos:int; 
                var key:String;
                var value:String;
                
                for(var i:uint=0; i < pairs.length; ++i) {

                    pos = pairs[i].indexOf("=");
                    
                    if(pos != -1) {
                        key = pairs[i].substring(0, pos);
                        value = pairs[i].substring(pos+1);
                        
                        params[key] = value;
                    }
                }
            }
            
            return params;
        }
        

        static public function getFlashVars( root:DisplayObject ):Object
        {
            return root.loaderInfo.parameters;
        }
        
	}
}

class SingletonEnforcer{}