package Assets 
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * Library Manager.
	 * Responsable to create and store new visual elements of the projects.
	 * @author Jack Dracon
	 */
	public class Library 
	{
		[Embed(source="../../assets/sprites.png")]
		public static const _imgs : Class;
		
		[Embed(source="../../assets/sprites.xml", mimeType= "application/octet-stream")]
		public static const _xml : Class;
		
		public static var _library : Dictionary = new Dictionary();
		
		/**
		* Get the atlas with the tool's objects.
		*/
		public static function Get_Atlas() : TextureAtlas 
		{
			if (_library["Atlas"] == undefined) 
			{
				//var _bmp : Bitmap = new Library["img"]();
				var _texture : Texture = Texture.fromBitmap(Bitmap(new Library["_imgs"]()));
				var _xml : XML = XML(new Library["_xml"]());
				_library["Atlas"] = new TextureAtlas(_texture, _xml);
			}
			return _library["Atlas"];
		}
		
	}
}