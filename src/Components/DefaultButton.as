package Components 
{
	import Contents.PropertiesBar;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import Assets.Library;
	
	/**
	 * ...
	 * @author Jack Dracon
	 */
	public final class DefaultButton extends Sprite
	{
		private var _btn : Button;
		private var _doIt: Function;
		private var _description : String;
		private var _extensions : String;
		public function DefaultButton(_func : Function, _desc:String, _ext:String)
		{
			_btn = new Button(Library.Get_Atlas().getTexture("load_clickOff.png"), "Load", Library.Get_Atlas().getTexture("load_clickOn.png"));
			addChild(_btn);
			_btn.addEventListener(Event.TRIGGERED, Trigger);
			_description = _desc;
			_extensions = _ext;
			_doIt = _func;
		}
		
		private function Trigger(e : Event) : void 
		{
			(parent as PropertiesBar).activeButtonName = this.name;
			_doIt(_description, _extensions);
		}
	}
}