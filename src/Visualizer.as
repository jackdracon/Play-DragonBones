package  
{
	import adobe.utils.CustomActions;
	import Components.ConfirmDialog;
	import Components.HelpPopUp;
	import Components.InfoField;
	import Contents.DragonBonesObject;
	import Contents.PropertiesBar;
	import Contents.DBDataDriven;
	
	import dragonBones.textures.StarlingTextureAtlas;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
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
		
		private var vecInfoFields:Vector.<InfoField>;
		
		private var _helpPopUp:HelpPopUp;
		private var _dialogYesNo:ConfirmDialog;
		
		private var _blackQuad : Quad;
		
		/**
		 * Constructor
		 */
		public function Visualizer() : void
		{
			_properties = new PropertiesBar();
			addChild(_properties);
			setChildIndex(_properties, 1);
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
		
		/**
		 * Update the object animations list
		 */
		public function UpdateAnimations() : void {
			if (_dbObject) {
				vecInfoFields = new Vector.<InfoField>();
				if (_dbObject.AnimationCollection.length > 0) {
					for each(var _str:String in _dbObject.AnimationCollection) {
						DragonBonesInfo(_str);
					}
				}
			}
		}
		
		/**
		 * Black window for cover the background.
		 */
		public function BlackWindow() : void {
			_blackQuad = new Quad(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight, 0x000000);
			addChild(_blackQuad);
			_blackQuad.alpha = 0.75;
			_blackQuad.x = 0;
			_blackQuad.y = 0;
		}
		
		/**
		 * Create the InfoFields.
		 * @param	_str, text to display on InfoField.
		 */
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
			vecInfoFields.push(_info);
		}
		
		public function Handler_MoveDBObject(_evt : TouchEvent) : void 
		{
			var _touch:Touch = _evt.getTouch(DragonBonesObject(_evt.currentTarget));
			if (_touch) {
				switch(_touch.phase) {
					case(TouchPhase.MOVED):
						DragonBonesObject(_evt.currentTarget).x = _properties.width + _touch.globalX;// + (DragonBonesObject(_evt.currentTarget).width * .5);
						DragonBonesObject(_evt.currentTarget).y = _touch.globalY;// + (DragonBonesObject(_evt.currentTarget).height * .75);
					break;
				}
			}
		}
		
		/**
		* Create the DragonBones object.
		* @param	_atlas, StarlingTextureAtlas
		* @param	_skeleton, Data(XML) with the skeleton info to combine with texture atlas of DragonBones
		*/
		public function Create_DragonBones(_atlas : StarlingTextureAtlas, _skeleton : XML) : void 
		{
			_dbObject = new DragonBonesObject(_atlas, _skeleton, Handler_MoveDBObject);
			addChild(_dbObject);
			_dbObject.pivotX = _dbObject.width * .5;
			_dbObject.pivotY = _dbObject.height * .5;
			_dbObject.x = _properties.width + (Starling.current.stage.stageWidth * .65);// (Starling.current.stage.stageWidth - Starling.current.stage.stageWidth * .35);
			_dbObject.y = Starling.current.stage.stageHeight * .65;
			setChildIndex(_dbObject, 0);
		}
		
		/**
		 * Create a Popup for the Yes or No dialog box.
		 * 
		 */
		public function ConfirmDialogPopUp() : void 
		{
			if(_dbObject) {_dbObject.Stop();}
			BlackWindow();
			_dialogYesNo = new ConfirmDialog(200, 150, Delete_DragonBones);
			addChild(_dialogYesNo);
			_dialogYesNo.pivotX = _dialogYesNo.width * .5;
			_dialogYesNo.pivotY = _dialogYesNo.height * .5;
			_dialogYesNo.x = Starling.current.stage.stageWidth * .5;
			_dialogYesNo.y = Starling.current.stage.stageHeight * .5;
		}
		
		/**
		 * Add Help popup window.
		 */
		public function HelpDialogPopUp() : void {
			BlackWindow();
			_helpPopUp = new HelpPopUp(400, 200, Delete_Help);
			addChild(_helpPopUp);
			_helpPopUp.pivotX = _helpPopUp.width * .5;
			_helpPopUp.pivotY = _helpPopUp.height * .5;
			_helpPopUp.x = Starling.current.stage.stageWidth * .5;
			_helpPopUp.y = Starling.current.stage.stageHeight * .5;
		}
		
		/**
		 * Remove Help popup window
		 */
		private function Delete_Help() : void 
		{
			removeChild(_blackQuad);
			removeChild(_helpPopUp);
		}
		
		/**
		* Delete object DragonBones from the space/view.
		*/
		public function Delete_DragonBones(_delete : Boolean) : void {
			if (_delete) {
				if (Has_DragonBonesObject) {
					removeChild(_dbObject);
					_dbObject = null;
					DBDataDriven.Clear_Asset();
					infoFieldNextPositionX = infoFieldNextPositionY = 0;
					while (vecInfoFields.length > 0) {
						removeChild(vecInfoFields.shift());
					}
				}
			}else 
			{
				if(_dbObject) _dbObject.Play(_dbObject.CurrentAnimation);
			}
			removeChild(_blackQuad);
			removeChild(_dialogYesNo);
		}
		
		/**
		 * Zoom function 
		 * @param	_zoom
		 */
		public function Zoom(_in : Boolean) : void {
			var _zoomScale:Number = .25;
			if (Has_DragonBonesObject) {
				if (_in) 
				{
					_dbObject.scaleX += _zoomScale;
					_dbObject.scaleY += _zoomScale;
				}
					else 
				{
					_dbObject.scaleX -= _zoomScale;
					_dbObject.scaleY -= _zoomScale;
				}
			}
		}
		
		/**
		* @return if the object still already exists.
		*/
		public function get Has_DragonBonesObject() : Boolean 
		{
			return (_dbObject) ? true : false;
		}
	}
}