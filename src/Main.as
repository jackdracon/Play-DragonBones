package 
{
	import flash.display.Sprite;
	import starling.core.Starling;
	import flash.events.Event;
	/**
	 * Main class.
	 * Just to initialize the project.
	 * @author Jack Dracon
	 */
	public class Main extends Sprite 
	{
		private var _starling : Starling;
		private var version : String = "0.22";
		public function Main() : void 
		{
			if (stage) {	init();	}
			else { this.addEventListener(Event.ADDED_TO_STAGE, init); }
		}
		
		public function init(e : Event = null) : void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.nativeWindow.title = "Play-DragonBones #v" + version;
			_starling = new Starling(Visualizer, stage);
			_starling.antiAliasing = 1;
			_starling.start();
		}
	}
}