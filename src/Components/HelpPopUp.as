package Components 
{
	import starling.display.Sprite;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.display.Button;
	import Assets.Library;
	
	/**
	 * ...
	 * @author Jack Dracon
	 */
	public class HelpPopUp extends Sprite 
	{
		private var _popUp : Quad;
		
		public function HelpPopUp(_w:Number, _h:Number) : void
		{
			//super(_w, _h);
			_popUp = new Quad(_w, _h, 0x999999);
			addChild(_popUp);
			_popUp.x = this.x;
			_popUp.y = this.y;
			this.width = _popUp.width;
			this.height = _popUp.height;
		}
		
		public function CloseButton() : void {
			var _btn : Button = new Button(Library.Get_Atlas().getTexture("load_clickOff.png"), "Close", Library.Get_Atlas().getTexture("load_clickOn.png"));
			addChild(_btn);
			_btn.name = "yes";
			_btn.x = _btn.width;
			_btn.y = _btn.height;
			_btn.addEventListener(Event.TRIGGERED, HandlerConfirm);
		}
		
		private function HandlerConfirm(e:Event):void 
		{
			
		}
	}
}