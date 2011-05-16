package idv.redbug.robotbody
{
	
	import idv.redbug.robotbody.controller.displayList.command.*;
	import idv.redbug.robotbody.controller.displayList.event.*;
	import idv.redbug.robotBody.controller.infoText.command.*;
	import idv.redbug.robotbody.controller.infoText.event.*;
	import idv.redbug.robotbody.controller.resLoader.command.*;
	import idv.redbug.robotbody.controller.resLoader.event.*;
	import idv.redbug.robotbody.controller.robotlegs.command.StartupCmd;
	import idv.redbug.robotbody.controller.scene.command.*;
	import idv.redbug.robotbody.controller.scene.event.*;
	import idv.redbug.robotbody.model.resource.*;
	import idv.redbug.robotbody.model.scene.*;
	import idv.redbug.robotbody.model.manager.*;
	import idv.redbug.robotbody.view.mediator.*;
	import idv.redbug.robotbody.view.ui.InfoText;
	import idv.redbug.robotbody.util.Toolkits;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.system.Security;
	import flash.utils.getQualifiedClassName;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	
	public class CoreContext extends Context
	{
		
		private var _sceneClasses			:Array;
		
		public function CoreContext(contextView:DisplayObjectContainer, ...sceneClasses)
		{
			_sceneClasses = sceneClasses;
			contextView.tabChildren = false;
			
			super(contextView);
		}
		
		override public function startup ():void
		{
			commandMap.mapEvent( ContextEvent.STARTUP_COMPLETE, StartupCmd, ContextEvent );
			
			commandMap.mapEvent( ResItemLoadedEvent.LOADING_COMPLETE, ItemLoadingCompleteCmd, ResItemLoadedEvent );
			commandMap.mapEvent( ResLoaderEvent.LOADING_COMPLETE, ResLoadingCompleteCmd, ResLoaderEvent );
			commandMap.mapEvent( ResLoaderEvent.LOADING_START, ResLoadingStartCmd, ResLoaderEvent );
			commandMap.mapEvent( ResLoaderEvent.REMOVE_START, ResReleaseStartCmd, ResLoaderEvent );
			commandMap.mapEvent( ResLoaderEvent.REMOVE_COMPLETE, ResReleaseCompleteCmd, ResLoaderEvent );
			
			commandMap.mapEvent( SceneEvent.SCENE_SWITCH, SceneSwitchCmd, SceneEvent );
			
			commandMap.mapEvent( DisplayEvent.REMOVE_ONE, DisplayListRemoveOneCmd, DisplayEvent );
			commandMap.mapEvent( DisplayEvent.ADD_TO_CONTEXTVIEW, DisplayListAddOneCmd, DisplayEvent );
			commandMap.mapEvent( DisplayEvent.CLEAR_CONTEXTVIEW, DisplayListClearAllCmd, DisplayEvent );
			
			injector.mapSingleton( ResLoader );
			injector.mapSingleton( ResManager );
			injector.mapSingleton( SceneManager );

			
			/**************************
			 * scene object injection
			 **************************/
			var sceneManager	:SceneManager = injector.getInstance( SceneManager );
			sceneManager.root = contextView.root;
			sceneManager.stage = contextView.stage;
			
			Toolkits.designatedFrameRate = sceneManager.stage.frameRate;
			
			
			for( var i:int = 0; i < _sceneClasses.length; ++i )
			{
				var sceneClass			:Class				= _sceneClasses[ i ] as Class;
				var moduleClassName		:String 			= getQualifiedClassName( sceneClass );
				
				var index:int	 = moduleClassName.indexOf( "::" );
				
				if( index != -1 ){
					moduleClassName = moduleClassName.substring( index + 2 ); 
				}
				
				injector.mapSingleton( sceneClass );
				sceneManager.add( moduleClassName, injector.getInstance( sceneClass ) );
				
				if( i == 0 ){
					sceneManager.firstScene = injector.getInstance( sceneClass );
				}		
			}
			
			mediatorMap.mapView( contextView, StageMediator );
			mediatorMap.mapView( InfoText, InfoTextMediator );
			
			super.startup();
		}
		
		public function get currentScene():IScene
		{
			return injector.getInstance( SceneManager ).currentScene;
		}
		
	}
}