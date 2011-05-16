package idv.redbug.robotbody.commands
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osflash.signals.Signal;
	import org.osflash.signals.events.GenericEvent;
	import org.osflash.signals.natives.NativeSignal;
	
	public class SimpleCommand implements ICommand
	{
		private var _sgCommandComplete		:Signal;
		
		private var _sgCommandTimer         :NativeSignal;
		private var _cmdTimer               :Timer;
		
		public function SimpleCommand( delay:Number = 0 ) 
		{
			_cmdTimer				= new Timer( int( 1000 * delay ), 1 );
			
			_sgCommandComplete		= new Signal();
			_sgCommandTimer			= new NativeSignal(_cmdTimer, TimerEvent.TIMER_COMPLETE, TimerEvent);
			_sgCommandTimer.addOnce( onTimerComplete );
		}
		
		public function execute():void
		{
		
		}
		
		public final function start():void
		{
			_cmdTimer.start();
		}
		
		public final function complete():void
		{
			_sgCommandComplete.dispatch();
			destroy();
		}
		
		public final function onTimerComplete(event:TimerEvent):void
		{
			execute();
		}

		private function destroy():void
		{
			_sgCommandComplete.removeAll();
			_sgCommandTimer.removeAll();
			_cmdTimer.stop();
			_cmdTimer = null;
		}

        public function get sgCommandComplete():Signal
        {
            return _sgCommandComplete;
        }
        
	}
}