package idv.redbug.robotbody.controller.infoText.event
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class InfoTextEvent extends Event
	{
		public static const SWTICH_VISIBLE:String = "switchVisible";
		
		public function InfoTextEvent( type:String )
		{
			super( type );
		}
		
		override public function clone():Event
		{
			return new InfoTextEvent( type );
		}
		
		override public function toString():String
		{
			return formatToString( "InfoTextEvent", "type" );
		}		
		
	}
}