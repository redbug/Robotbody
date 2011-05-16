package idv.redbug.robotbody.commands
{
	public class AsyncCommand extends SimpleCommand
	{
		private var _commands				:Vector.<SimpleCommand>;
		private var _numCommandCompleted	:int;
		
		public function AsyncCommand( delay:Number, ...commands )
		{
			super( delay );
			
			_numCommandCompleted = 0;
			
			_commands = new Vector.<SimpleCommand>();
			
            if ( commands[0] is Array )
            {
                commands =  commands[0];  
            }
            
			for each ( var command:SimpleCommand in commands ){
				_commands.push( command );
			}
		}
		
		override final public function execute():void
		{
			launchNextCommand();
		}
		
		private function oneCommandComplete():void
		{
			_numCommandCompleted++;
			
			if( _numCommandCompleted == _commands.length ){
				complete();
			}
			else{
				launchNextCommand();		
			}
		}
		
		private function launchNextCommand():void
		{
			_commands[ _numCommandCompleted ].sgCommandComplete.addOnce( oneCommandComplete );
			_commands[ _numCommandCompleted ].start();
		}
		
		
	}
}