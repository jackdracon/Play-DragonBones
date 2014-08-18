package Components 
{
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.events.Event;
	
	import Assets.Library;
	
	/**
	 * ...
	 * @author Jack Dracon
	 */
	public final class ControllerButton extends Button
	{
		private var doIt : Function;
		private var _btn : Button;
		public function ControllerButton(_upTexture:Texture, _downTexture:Texture, _doIt : Function) : void
		{
			super(_upTexture,"", _downTexture);
			doIt = _doIt;
			addEventListener(Event.TRIGGERED, Trigger);
		}
		
		private function Trigger(e : Event) : void 
		{
			if(doIt) doIt();
		}
	}
}