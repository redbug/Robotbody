package idv.redbug.robotbody.model.manager
{
	public interface IManager
	{
		function add( key:String, value:Object ):void;
		function get( key:String ):Object;
		function length():int;
		function clearAll():void;
	}
}