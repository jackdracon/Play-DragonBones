package Components 
{
	import starling.display.Sprite;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.display.Button;
	import Assets.Library;
	import starling.text.TextField;
	
	/**
	 * A window with information about Play-DragonBones.
	 * @author Jack Dracon
	 */
	public class HelpPopUp extends Sprite 
	{
		private var _popUp : Quad;
		
		private var _doIt : Function;
		/**
		 * Constructor
		 * @param	_w, set width
		 * @param	_h, set height 
		 * @param	_f, set the function to handler function to the 'Close' button.
		 */
		public function HelpPopUp(_w : Number, _h : Number, _f : Function) : void
		{
			//super(_w, _h);
			_popUp = new Quad(_w, _h, 0x999999);
			addChild(_popUp);
			_popUp.x = this.x;
			_popUp.y = this.y;
			this.width = _popUp.width;
			this.height = _popUp.height;
			_doIt = _f;
			DescriptionText();
			CloseButton();
		}
		
		/**
		 * Close this pop up window.
		 */
		public function CloseButton() : void 
		{
			var _btn : Button = new Button(Library.Get_Atlas().getTexture("load_clickOff.png"), "Close", Library.Get_Atlas().getTexture("load_clickOn.png"));
			addChild(_btn);
			_btn.name = "Close";
			_btn.scaleX = .7;
			_btn.x =  this.width - (_btn.width * 1.2);
			_btn.y = this.height - (_btn.height * 1.2);
			_btn.addEventListener(Event.TRIGGERED, HandlerConfirm);
		}
		
		/**
		 * A simple description about Play-DragonBones.
		 */
		private function DescriptionText() : void 
		{
			var _str : String = "Play-DragonBones it's free and open source. It's hosted at GitHub. Actually, it's using the version 2.4 of DragonBones framework.";
			var _text:TextField = new TextField(_popUp.width, _popUp.height, _str, "Arial Black", 12);
			addChild(_text);
			_text.x = 0;
			_text.y = 0;
		}
		
		/**
		 * Button Handler
		 * @param	e
		 */
		private function HandlerConfirm(e : Event) : void 
		{
			_doIt();
		}
	}
}