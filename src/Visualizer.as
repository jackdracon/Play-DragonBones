package  
{
	import Components.InfoField;
	import Contents.DragonBonesObject;
	import Contents.PropertiesBar;
	import Contents.DBDataDriven;
	import dragonBones.textures.StarlingTextureAtlas;
	
	import starling.display.Sprite;
	import starling.core.Starling;
	import starling.text.TextField;
	import starling.display.Quad;
	import starling.animation.Transitions;
	
	/**
	 * Main component.
	 * - Create the sidebar
	 * - Object with the project of the DragonBones
	 * - Status from the objects
	 * @author Jack Dracon
	 */
	public class Visualizer extends Sprite
	{
		private var _properties : PropertiesBar;
		private var _statusDelay : Number = .25;
		private var _busyStatus : Boolean = false;
		
		private var _dbObject : DragonBonesObject;
		
		private var _arrFields : Array = [];
		
		private var infoFieldNextPositionX : Number = 0;
		private var infoFieldNextPositionY : Number = 0;
		
		public function Visualizer() : void
		{
			_properties = new PropertiesBar();
			addChild(_properties);
		}
		
		/**
		 * Status about some info on the right bottom side.
		 * @param	_str, text to be showed.
		 */
		public function StatusInfo(_str : String = "") : void 
		{
			var _black : Quad = new Quad(100, 50);
			addChild(_black);
			
			_black.x = Starling.current.stage.stageWidth - _black.width;
			_black.y = Starling.current.stage.stageHeight - _black.height;
			_black.setVertexColor(0, 0x0);
			_black.setVertexColor(1, 0x0);
			_black.setVertexColor(2, 0x0);
			_black.setVertexColor(3, 0x0);
			_black.alpha = 0.25;
			
			var _field : TextField = new TextField(100, 50, _str, "Arial", 12, 0xffffff);
			addChild(_field);
			_field.x = _black.x;
			_field.y = _black.y;
			trace(_str );
			
			Starling.juggler.delayCall(function() : void {
			Starling.juggler.tween(_black, 1, { alpha : 0, transition: Transitions.EASE_OUT, onComplete: function complete() : void {
				Starling.juggler.purge();
				removeChild(_black);
				removeChild(_field);
				_statusDelay -= .25;
			}});
			}, _statusDelay);
			_statusDelay += .25;
		}
		
		/**
		 * Load the files and turn them able to create the DragonBones object.
		 */
		public function Load_DragonBones() : void 
		{
			if (DBDataDriven.Assets_Complete()) 
			{
				var _atlas : StarlingTextureAtlas = new StarlingTextureAtlas(DBDataDriven.Current_Texture, DBDataDriven.Current_Data);
				Create_DragonBones(_atlas, DBDataDriven.Current_Skeleton);
				UpdateAnimations();
			} else {
				StatusInfo("LOAD ERROR");
			}
		}
		
		public function UpdateAnimations() : void {
			if (_dbObject) {
				if (_dbObject.AnimationCollection.length > 0) {
					for each(var _str:String in _dbObject.AnimationCollection) {
						DragonBonesInfo(_str);
					}
				}
			}
		}
		
		public function DragonBonesInfo(_str : String) : void {
			var _info : InfoField = new InfoField(_str, _dbObject.Play);
			addChild(_info);
			if (infoFieldNextPositionY >= Starling.current.stage.stageHeight) {
				infoFieldNextPositionX = _info.width;
				infoFieldNextPositionY = 0;
			}
			_info.x = _properties.width + infoFieldNextPositionX;
			_info.y = infoFieldNextPositionY;
			infoFieldNextPositionY += (_info.height + 10);
		}
		
		/**
		* Create the DragonBones object.
		* @param	_atlas, StarlingTextureAtlas
		* @param	_skeleton, Data(XML) with the skeleton info to combine with texture atlas of DragonBones
		*/
		public function Create_DragonBones(_atlas : StarlingTextureAtlas, _skeleton : XML) : void 
		{
			_dbObject = new DragonBonesObject(_atlas, _skeleton);
			addChild(_dbObject);
			_dbObject.pivotX = _dbObject.width * .5;
			_dbObject.pivotY = _dbObject.height * .5;
			_dbObject.x = _properties.width + (Starling.current.stage.stageWidth * .65);// (Starling.current.stage.stageWidth - Starling.current.stage.stageWidth * .35);
			_dbObject.y = Starling.current.stage.stageHeight * .65;
		}
		
		/**
		* @return if the object still already exists.
		*/
		public function Has_DragonBonesObject() : Boolean 
		{
			return (_dbObject) ? true : false;
		}
	}
}