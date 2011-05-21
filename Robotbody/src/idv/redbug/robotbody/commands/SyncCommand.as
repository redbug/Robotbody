package idv.redbug.robotbody.commands
{
	public class SyncCommand extends SimpleCommand
	{
		private var _commands				:Vector.<SimpleCommand>;
		private var _numCommandCompleted	:int;
		
		public function SyncCommand( delay:Number, ...commands )
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
			for each ( var command:SimpleCommand in _commands ){
				command.sgCommandComplete.addOnce( oneCommandComplete );
				command.start();
			}
		}
        
        public function addSubCommand( cmd:SimpleCommand ):void
        {
            _commands.push( cmd );
        }
		
		private function oneCommandComplete():void
		{
			_numCommandCompleted++;
			
			if( _numCommandCompleted == _commands.length ){
				complete();
			}
		}
	}
}