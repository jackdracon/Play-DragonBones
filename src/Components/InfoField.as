package Components 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.text.TextField;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author Jack Dracon
	 */
	public final class InfoField extends Sprite
	{
		private var _quad : Quad;
		private var _value : String;
		private var _func : Function;
		public function InfoField(_str : String, _f : Function) 
		{
			_func = _f;
			useHandCursor = true;
			_value = _str;
			this.touchable = true;
			_quad = new Quad(100, 50, 0x00);
			addChild(_quad);
			_quad.alpha = .5;
			var _field : TextField = new TextField(100, 50, _str, "Arial", 12, 0xff);
			addChild(_field);
			this.width = _quad.width;
			this.height = _quad.height;
			this.addEventListener(TouchEvent.TOUCH, handlderTrigger);
		}
		
		private function handlderTrigger(e:TouchEvent):void 
		{
			var _t : Touch = e.getTouch(this);
			if (_t) {
				if (_t.phase == TouchPhase.ENDED) 
				{
					_func(_value);
				}
			}
		}
	}
}