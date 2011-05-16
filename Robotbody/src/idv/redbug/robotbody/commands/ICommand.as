package idv.redbug.robotbody.commands
{
	import flash.events.TimerEvent;

	public interface ICommand
	{
		function execute():void;
		function complete():void;
		function start():void;
		function onTimerComplete(event:TimerEvent):void;
	}
}