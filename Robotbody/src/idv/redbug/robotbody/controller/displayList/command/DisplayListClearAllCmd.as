package idv.redbug.robotbody.controller.displayList.command
{
	import org.robotlegs.mvcs.Command;
	import idv.redbug.robotbody.view.ui.InfoText;
	
	
	public class DisplayListClearAllCmd extends Command
	{
		
		override public function execute():void
		{

			while( contextView.numChildren > 0 ){
				contextView.removeChildAt( 0 );
			}
			
			contextView.addChild( new InfoText() );
		}
	}
}