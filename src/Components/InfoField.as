package Components 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	/**
	 * ...
	 * @author Jack Dracon
	 */
	public final class InfoField extends Sprite
	{
		private var _quad:Quad;
		public function InfoField(_str : String) 
		{
			_quad = new Quad(100, 50, 0x00);
			addChild(_quad);
			var _field : TextField = new TextField(100, 50, _str);
			addChild(_field);
		}
	}
}