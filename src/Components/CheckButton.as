package Components 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.events.Event;
	import Assets.Library;
	
	/**
	 * A simple checkbox using starling objects.
	 * @author Jack Dracon
	 */
	public class CheckButton extends Sprite
	{
		private var isCheck : Boolean = false;
		
		private var checkImg : Image;
		
		private var doIt : Function;
		public function CheckButton(_func : Function) 
		{
			doIt = _func;
			checkImg = new Image(Library.Get_Atlas().getTexture("check_clickOff.png"));
			addChild(checkImg);
			checkImg.x = this.x;
			checkImg.y = this.y;
			addEventListener(TouchEvent.TOUCH, Touch_Mark);
			addEventListener(Event.TRIGGERED, Act_Trigger);
		}
		
		private function Act_Trigger(e : Event) : void 
		{
			trace("Click");
			doIt(isCheck);
		}
		
		private function Touch_Mark(e : TouchEvent) : void 
		{
			var _touching : Touch = e.getTouch(this);
			if (_touching) {
				if (_touching.phase == TouchPhase.ENDED) 
				{
					isCheck = !isCheck;
					trace("Check $$ " + isCheck);
					if (isCheck) 
					{
						checkImg.texture = Library.Get_Atlas().getTexture("check_clickOn.png");
					}
					else 
					{
						checkImg.texture = Library.Get_Atlas().getTexture("check_clickOff.png");
					}
					doIt(isCheck);
				}
			}
		}
	}
}