package Components 
{
	import starling.display.Button;
	import Assets.Library;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.events.Event;
	import starling.display.Quad;
	import starling.core.Starling;
	
	/**
	 * Confirm PopUp window
	 * @author Jack Dracon
	 */
	public class ConfirmDialog extends Sprite 
	{
		private var _f : Function;
		private var _popUp : Quad;
		
		public function ConfirmDialog(_w:Number, _h:Number, _func : Function) : void 
		{			
			_popUp = new Quad(_w, _h, 0x9999FF);
			addChild(_popUp);
			this.width = _popUp.width;
			this.height = _popUp.height;
			var _str:String = "This action will delete all loaded data. Do you want to proceed?";
			var _text:TextField = new TextField(200, 70, _str, "Arial", 16);
			addChild(_text);
			_text.x = 0;
			_text.y = 0;
			YesButton();
			NoButton();
			_f = _func;
		}
		
		public function YesButton() : void {
			var _btn : Button = new Button(Library.Get_Atlas().getTexture("load_clickOff.png"), "Yes", Library.Get_Atlas().getTexture("load_clickOn.png"));
			addChild(_btn);
			_btn.name = "yes";
			_btn.x = 10;
			_btn.y = _btn.height * 2;
			_btn.addEventListener(Event.TRIGGERED, HandlerConfirm);
		}
		
		private function HandlerConfirm(e:Event):void 
		{
			var _name : String = Button(e.currentTarget).name;
			if (_name == "yes") {
				_f(true);
			}else {
				_f(false);
			}
		}
		
		public function NoButton() : void {
			var _btn : Button = new Button(Library.Get_Atlas().getTexture("load_clickOff.png"), "No", Library.Get_Atlas().getTexture("load_clickOn.png"));
			addChild(_btn);
			_btn.name = "no";
			_btn.x = _btn.width * 1.2;
			_btn.y = _btn.height * 2;
			_btn.addEventListener(Event.TRIGGERED, HandlerConfirm);
		}
	}
}