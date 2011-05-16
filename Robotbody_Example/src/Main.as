package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;

	import idv.redbug.robotbody.CoreContext;
	
	[SWF(width="800", height="600", frameRate="40", backgroundColor="#000000")]
	public class Main extends Sprite
	{
		protected var _context:CoreContext;
		
		public function Main()
		{
			this._context = new CoreContext(this, SceneA, SceneB, SceneC);
		}
	}
}