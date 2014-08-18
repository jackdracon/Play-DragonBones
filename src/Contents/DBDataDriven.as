package Contents 
{
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * 
	 * @author Jack Dracon
	 */
	public final class DBDataDriven extends Sprite
	{
		private static var _texture : Texture;
		private static var _dataXML : XML;
		private static var _skeletonXML : XML;
		
		public static function Load_Texture(_text : Texture) : void {
			_texture = _text;
		}
		
		public static function Load_Data(_data : XML) : void {
			_dataXML = _data;
		}
		
		public static function Load_Skeleton(_skl : XML) : void {
			_skeletonXML = _skl;
		}
		
		public static function get Current_Texture() : Texture {
			return _texture;
		}
		
		public static function get Current_Skeleton() : XML {
			return _skeletonXML;
		}
		
		public static function get Current_Data() : XML {
			return _dataXML;
		}
		
		/**
		* Analysize the assets.
		* @return all data is aleady loaded or not.
		*/
		public static function Assets_Complete() : Boolean {
			return (_dataXML && _skeletonXML && _texture) ? true : false;
		}
		
		/**
		 * Check if the assets could be cleared.
		 */
		public static function Clear_Asset() : void 
		{
			if (DBDataDriven.Assets_Complete()) {
				_dataXML = null;
				_skeletonXML = null;
				_texture = null;
				//DBDataDriven.Current_Data;
				//DBDataDriven.Current_Skeleton = null;
				//DBDataDriven.Current_Texture = null;
			}
		}
	}
}