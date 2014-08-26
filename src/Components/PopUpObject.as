package src.Components {
	import starling.display.Quad;
	import starling.display.Sprite;
	/**
	 * Base popup window
	 * @author Jack Dracon
	 */
	public class PopUpObject extends Sprite
	{
		private var _popUp : Quad;
		public function PopUpObject(_w:Number, _h:Number) : void
		{
			_popUp = new Quad(_w, _h, 0x999999);
			addChild(_popUp);
			_popUp.x = this.x;
			_popUp.y = this.y;
			this.width = _popUp.width;
			this.height = _popUp.height;
		}
	}
}