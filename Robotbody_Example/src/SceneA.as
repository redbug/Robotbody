package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.media.Sound;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.engine.TextBaseline;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import idv.redbug.robotbody.CoreContext;
	import idv.redbug.robotbody.model.scene.BaseScene;
	import idv.redbug.robotbody.model.scene.IScene;
	import idv.redbug.robotbody.util.MyKeyCode;
	import idv.redbug.robotbody.util.Toolkits;

	
	
	public class SceneA extends BaseScene
	{
		private const MY_SWF		:Array = ["preloader_A.swf", "swf_A.swf"];
		private const MY_TXT		:Array = ["text_A.txt"];
		private const MY_MUSIC		:Array = ["music_A.mp3"];
		private const MY_XML		:Array = ["shortcut_A.xml"];

        private const MUSIC_INDEX       :int  = 0;
		
        private var preloader_mc        :MovieClip;
        private var progress_bar_mc     :MovieClip;

        private var shortcut            :Shortcut;
        private var text_txt            :TextField;
        
        private var isMusicPlaying      :Boolean; 
        private var	isPreloaderLoaded   :Boolean;        
        
        private function progressHandler( itemName:String, percentLoaded_item:String, percentLoaded_total:String  ):void
        {
            if( resManager.get("preloader_A.swf") != null && !isPreloaderLoaded )
            {
                isPreloaderLoaded = true;

                var preloader_swf:MovieClip = resManager.get( "preloader_A.swf" ) as MovieClip;
                preloader_mc = preloader_swf.getChildByName( "preloader_mc" ) as MovieClip;
                progress_bar_mc = preloader_mc.getChildByName("progress_bar_mc") as MovieClip;
                preloader_mc.x = sceneManager.stageWidth >> 1;
                preloader_mc.y = sceneManager.stageHeight >> 1;
                
                addToContextView( preloader_mc );
            }
            else if( isPreloaderLoaded ){
                progress_bar_mc.gotoAndStop( percentLoaded_total );
            }

        }
        
        
		//---------------------------------------------------------------------
		//  Override following functions for using the core framework of Robotbody:
		//		init()
		//		run()
		//		destroy()
		//		switchTo()		
		//		accessSWF()
		//		accessTXT()
		//		accessMP3()
		//		accessXML()
		//---------------------------------------------------------------------
		
		override public function init():void
		{
            isMusicPlaying = false; 
            isPreloaderLoaded = false;  

            shortcut = new Shortcut();
            
			resManager.progressHandler = progressHandler;

			/***********************************************
			 * make a resource list for loading "SWF" files 
			 ***********************************************/
			super.makeSWFList(MY_SWF);

			/***********************************************
			 * make a resource list for loading "Text" files 
			 ***********************************************/
			super.makeTXTList(MY_TXT);
			
			/***********************************************
			 * make a resource list for loading "MP3" files 
			 ***********************************************/
			super.makeMP3List(MY_MUSIC);

			/***********************************************
			 * make a resource list for loading "XML" files 
			 ***********************************************/
			super.makeXMLList(MY_XML);
			
			
			super.init();
		}	
		
		override public function run():void
		{
			/***************************************
			 * access the resource from a Swf file
			 ***************************************/
			accessSWF();
			
			/***************************************
			 * access the resource from a text file
			 ***************************************/
			accessTXT();
			
			/***************************************
			 * access the resource from a mp3 file
			 ***************************************/
			accessMP3();
			
			/***************************************
			 * access the resource from a xml file
			 ***************************************/
			accessXML();

		}
		
		override public function destroy():void
		{
			//-----make sure performing folllowing tasks before calling the parent's destory().------------------------
			//Unregister all event listners (particularly Event.ENTER_FRAME, and mouse and keyboard listener).
			//Stop any currently running intervals (via clearInterval()).
			//Stop any Timer objects(via the Time's class instance method stop()).
			//Stop any sounds from playing.
			//Stop the main timeline if it's currently playing.
			//Stop any movie clips that are currently playing.
			//Close any connected nework object, such as an instances of Loader, URLLoader, Socket, XMLSocket, LocalConnection, NetConnection, and NetStream
			//Nullify all references to Camera or Microphone.
			//--------------------------------------------------------------------------------------------------------
			
			super.destroy();
		}

		override public function switchTo(targetScene:IScene):void
		{
			super.switchTo(targetScene);
		}
		
		override public function accessSWF():void
		{
            removeFromContextView( preloader_mc );
            
			var swf_A_swf   :MovieClip = resManager.get("swf_A.swf") as MovieClip;
            var symbol_mc   :MovieClip = swf_A_swf.getChildByName("symbol_mc") as MovieClip;
			addToContextView(symbol_mc);
            Toolkits.playFromAToEND( symbol_mc, 0);

            shortcut.key_txt = swf_A_swf.getChildByName("key_txt") as TextField;
            shortcut.func_txt = swf_A_swf.getChildByName("func_txt") as TextField;
            var title_txt:TextField = swf_A_swf.getChildByName("title_txt") as TextField;
            addToContextView( title_txt );
            
            text_txt = swf_A_swf.getChildByName("source_txt") as TextField;
		}	

		override public function accessTXT():void
		{
			var myPattern	:RegExp = /[\r]/g;
            text_txt.text = String( resManager.get("text_A.txt") ).replace( myPattern, "");
            
			addToContextView(text_txt);
		}	
		
		override public function accessMP3():void
		{
			var music:Sound	= resManager.get("music_A.mp3") as Sound;
			soundManager.registerMusic( MUSIC_INDEX, music );
			soundManager.playMusic( MUSIC_INDEX );
            isMusicPlaying = true;
		}
		
		override public function accessXML():void
		{
            var xml:XML = resManager.get("shortcut_A.xml") as XML;
            
            for each(var s:* in xml.*)
            {
                shortcut.key_txt.appendText( s.key + "\n");
                shortcut.func_txt.appendText( s.func  + "\n");
            }            
            
            addToContextView( shortcut.key_txt );
            addToContextView( shortcut.func_txt );
		}
		
		override public function onKeyDown(event:KeyboardEvent):void
		{
			
			switch(event.keyCode){				
				
                case Keyboard.F3: 
					sceneManager.switchPerformancePanel();
					break;
                
                case MyKeyCode.N_KEY:
                    clearContextView();
                    switchTo( sceneManager.getScene("SceneB") );
                    break;
                
                case MyKeyCode.X_KEY:
                    if ( isMusicPlaying ){
                        soundManager.stopMusic( MUSIC_INDEX );
                        isMusicPlaying = false;
                    }
                    
                    break;
                
                case MyKeyCode.Y_KEY:
                    
                    if( !isMusicPlaying ){
                        
                        isMusicPlaying = true;
                        
                        if( soundManager.isMusicResumable( MUSIC_INDEX ) ){
                            soundManager.resumeMusic( MUSIC_INDEX );
                        }else{
                            soundManager.playMusic( MUSIC_INDEX );                        
                        }
                        
                    }
                    
                    break;
                
                case Keyboard.UP:
                    if( isMusicPlaying ){
                        soundManager.musicVolume += 0.1;
                    }
                    break;
                
                case Keyboard.DOWN:
                    if( isMusicPlaying ){
                        soundManager.musicVolume -= 0.1;    
                    }
                    break;
			}
			
		}
		
		override public function onClick(event:MouseEvent):void
		{
		}
	}
}