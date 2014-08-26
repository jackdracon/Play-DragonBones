package Components 
{
	import starling.display.Button;
	import starling.events.Event;
	import Assets.Library;
	/**
	 * ...
	 * @author Jack Dracon
	 */
	public final class HelpButton extends Button
	{
		private var _func : Function;
		public function HelpButton(_f : Function) : void 
		{
			super(Library.Get_Atlas().getTexture("help_clickOff.png"), "", Library.Get_Atlas().getTexture("help_clickOn.png"));
			_func = _f;
			addEventListener(Event.TRIGGERED, HandlerTrigger);
		}
		
		private function HandlerTrigger(e:Event):void 
		{
			_func();
		}
	}
}