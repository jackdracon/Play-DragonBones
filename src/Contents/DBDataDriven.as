package Contents 
{
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * DragonBones data to storage.
	 * @author Jack Dracon
	 */
	public final class DBDataDriven extends Sprite
	{
		private static var _texture : Texture;
		private static var _dataXML : XML;
		private static var _skeletonXML : XML;
		
		/**
		 * Load the texture object.
		 * @param	_text
		 */
		public static function Load_Texture(_text : Texture) : void {
			_texture = _text;
		}
		
		/**
		 * Load the data structure.
		 * @param	_data
		 */
		public static function Load_Data(_data : XML) : void {
			_dataXML = _data;
		}
		
		/**
		 * Load the skeleton object.
		 * @param	_skl, XML object to target as skeleton
		 */
		public static function Load_Skeleton(_skl : XML) : void {
			_skeletonXML = _skl;
		}
		
		/**
		 * Get the current textures element.
		 */
		public static function get Current_Texture() : Texture {
			return _texture;
		}
		
		/**
		 * Get the current skeleton data(XML)
		 */
		public static function get Current_Skeleton() : XML {
			return _skeletonXML;
		}
		
		/**
		 * Get the current data(XML) associated with texture.
		 */
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