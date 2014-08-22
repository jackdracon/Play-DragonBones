package Components 
{
	import starling.display.Button;
	import Assets.Library;
	import starling.events.Event;
	
	/**
	 * Simple Reset Button 
	 * @author Jack Dracon
	 */
	public final class ResetButton extends Button
	{
		
		private var _func:Function;
		public function ResetButton(_f : Function) : void
		{
			super(Library.Get_Atlas().getTexture("reset_clickOff.png"), "", Library.Get_Atlas().getTexture("reset_clickOn.png"));
			addEventListener(Event.TRIGGERED, HandlerTrigger);
			_func = _f;
		}
		
		private function HandlerTrigger(e:Event):void 
		{
			_func();
		}
	}
}