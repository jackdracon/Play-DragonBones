package Contents
{
	import Components.CheckButton;
	import Components.ControllerButton;
	import Components.DefaultButton;
	import Components.InfoField;
	import Components.ResetButton;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import starling.display.Image;
	import starling.textures.Texture;
	
	import Assets.Library;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.core.Starling;
	import starling.text.TextField;
	import starling.utils.Color;
	
	import flash.net.FileReference;
	import flash.net.FileFilter;
	import flash.events.Event;
	
	/**
	 * Side bar with the informations from the loaded object.
	 * Load button
	 * --------------
	 * Animation List
	 * Speed value
	 * Debug Mode
	 * --------------
	 * current frame
	 * backward button
	 * play button
	 * forward button
	 * stop button
	 * @author Jack Dracon
	 */
	public final class PropertiesBar extends Sprite
	{
		private var _fieldAnimationName:String;
		
		private var debugModeCheckBox:CheckButton;
		
		private var loopingCheckBox:CheckButton;
		private var onLoop:Boolean = true;
		
		// Load data buttons
		private var loadTextureButton:DefaultButton;
		private var loadSkeletonButton:DefaultButton;
		private var loadDataButton:DefaultButton;
		
		//Button Controllers
		private var playButton:DefaultButton;
		private var stopButton:DefaultButton;
		private var resetButton:ResetButton;
		
		
		//File's reference
		private var file:FileReference;
		private var fileLoader:Loader;
		
		//DragonBones assets
		private var dataDriven:DBDataDriven;
		
		public var activeButtonName:String;
		
		public function PropertiesBar():void
		{
			Background();
			DrawComponents();
			dataDriven = new DBDataDriven();
		}
		
		private function DrawComponents():void
		{
			//Load Texture
			loadTextureButton = new DefaultButton(Dialog, "Images (*.jpg, *.png)", "*.jpg; *.png");
			addChild(loadTextureButton);
			loadTextureButton.name = "load_Texture";
			loadTextureButton.x = loadTextureButton.width + 80;
			loadTextureButton.y = 15;
			
			var _descriptionTexture:TextField = new TextField(150, 50, "Load Texture: ", "Arial Black", 16, 0x00);
			addChild(_descriptionTexture);
			_descriptionTexture.x = 10;
			_descriptionTexture.y = loadTextureButton.y - 10;
			//-----------------------------------------------------------------------------------------------------------
			//Load Skeleton
			loadSkeletonButton = new DefaultButton(Dialog, "Skeleton (.xml)", "*.xml");
			addChild(loadSkeletonButton);
			loadSkeletonButton.name = "load_Skeleton";
			loadSkeletonButton.x = loadTextureButton.x;
			loadSkeletonButton.y = (loadTextureButton.y + (loadSkeletonButton.height * 1.2));
			
			var _descriptionSkeleton:TextField = new TextField(150, 50, "Load Skeleton: ", "Arial Black", 16, 0x00);
			addChild(_descriptionSkeleton);
			_descriptionSkeleton.x = 10;
			_descriptionSkeleton.y = loadSkeletonButton.y - 10;
			//-----------------------------------------------------------------------------------------------------------
			//Load Data
			loadDataButton = new DefaultButton(Dialog, "Data (.xml)", "*.xml");
			addChild(loadDataButton);
			loadDataButton.name = "load_Data";
			loadDataButton.x = loadTextureButton.x;
			loadDataButton.y = (loadSkeletonButton.y + (loadDataButton.height * 1.2));
			
			var _descriptionData:TextField = new TextField(150, 50, "Load Data: ", "Arial Black", 16, 0x00);
			addChild(_descriptionData);
			_descriptionData.x = 10;
			_descriptionData.y = loadDataButton.y - 10;
			//-----------------------------------------------------------------------------------------------------------
			//Reset Button
			resetButton = new ResetButton(Reset);
			addChild(resetButton);
			resetButton.x = resetButton.width;
			resetButton.y = (loadDataButton.y + (resetButton.height * 3));
			
			//Debug value
			debugModeCheckBox = new CheckButton(DebugDraw);
			addChild(debugModeCheckBox);
			debugModeCheckBox.x = 200;
			debugModeCheckBox.y = Starling.current.stage.stageHeight * .35;
			debugModeCheckBox.scaleX = debugModeCheckBox.scaleY = .5;
			
			//description 
			var _descriptionDebugMode:TextField = new TextField(150, 50, "Debug Mode: ", "Arial Black", 20, 0x00, true);
			addChild(_descriptionDebugMode);
			_descriptionDebugMode.x = 10;
			_descriptionDebugMode.y = debugModeCheckBox.y - 10;
			//-----------------------------------------------------------------------------------------------------------
			
			/*//Loop value
			loopingCheckBox = new CheckButton(PlayInLoop);
			addChild(loopingCheckBox);
			loopingCheckBox.x = 200;
			loopingCheckBox.y = (debugModeCheckBox.y + loopingCheckBox.height);
			loopingCheckBox.scaleX = loopingCheckBox.scaleY = .5;
			
			//description
			var _descriptionLoop:TextField = new TextField(75, 50, "Loop: ", "Arial Black", 20, 0x00, true);
			addChild(_descriptionLoop);
			_descriptionLoop.x = 10;
			_descriptionLoop.y = loopingCheckBox.y - 10;
			//-----------------------------------------------------------------------------------------------------------
			var _playButton : ControllerButton = new ControllerButton(Library.Get_Atlas().getTexture("play_clickOff.png"), Library.Get_Atlas().getTexture("play_clickOn.png"), null);
			addChild(_playButton);
			_playButton.x = (_playButton.width * 4);
			_playButton.y = (Starling.current.stage.stageHeight - (_playButton.height + 15));
			//-----------------------------------------------------------------------------------------------------------
			var _stopButton : ControllerButton = new ControllerButton(Library.Get_Atlas().getTexture("stop_clickOff.png"), Library.Get_Atlas().getTexture("stop_clickOn.png"), null);
			addChild(_stopButton);
			_stopButton.x = (_stopButton.width);
			_stopButton.y = (Starling.current.stage.stageHeight - (_stopButton.height + 15));*/
		}
		
		public function DebugDraw(_active : Boolean = false):void
		{
			if (_active)
			{
				Starling.current.showStats = true;
				Starling.current.showStatsAt("right", "top");
			}
			else
			{
				Starling.current.showStats = false;
			}
		}
		
		//public function PlayInLoop(_active : Boolean = false):void
		//{
			//onLoop = _active;
		//}
		
		/**
		 * Show the Dialog box
		 * @param	_desc, description for the type of file.
		 * @param	_ext, extension to be searched.
		 */
		public function Dialog(_desc:String, _ext:String):void
		{
			file = new FileReference();
			var _filterImgs:FileFilter = new FileFilter(_desc, _ext);
			file.browse([_filterImgs]);
			file.addEventListener(Event.SELECT, SelectFile);
			file.addEventListener(Event.COMPLETE, ReadFile);
		}
		
		/**
		 * Load selected files
		 * @param	e
		 */
		private function SelectFile(e:Event):void
		{
			file.load();
		}
		
		/**
		 * Import files.
		 * @param	e
		 */
		private function ReadFile(e:Event):void
		{
			file.removeEventListener(Event.COMPLETE, ReadFile);
			if (file.data)
			{
				if (activeButtonName == "load_Texture")
				{
					fileLoader = new Loader();
					fileLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, CompleteLoad);
					fileLoader.loadBytes(file.data);
				}
				else
				{
					var _xml:XML = new XML(file.data);
					switch (activeButtonName)
					{
						case("load_Skeleton"): 
							DBDataDriven.Load_Skeleton(_xml);
							(parent as Visualizer).StatusInfo("Skeleton Done");
							break;
						case("load_Data"): 
							DBDataDriven.Load_Data(_xml);
							(parent as Visualizer).StatusInfo("Data Done");
							break;
					}
					//if all assets its already done
					if (DBDataDriven.Assets_Complete())
					{
						activeButtonName = "";
						(parent as Visualizer).Load_DragonBones();
					}
						//file.addEventListener(Event.COMPLETE, CompleteLoad);
				}
			}
			else
			{
				(parent as Visualizer).StatusInfo("Error");
			}
		}
		
		/**
		 * Handler for complete load of files.
		 * @param	e
		 */
		private function CompleteLoad(e:Event):void
		{			
			var _bmp:Bitmap = fileLoader.content as Bitmap;
			DBDataDriven.Load_Texture(Texture.fromBitmap(_bmp));
			(parent as Visualizer).StatusInfo("Image Done");			
			
			fileLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, CompleteLoad);
			file = null;
			fileLoader = null;
			
			//if all assets its already done
			if (DBDataDriven.Assets_Complete())
			{
				activeButtonName = "";
				(parent as Visualizer).Load_DragonBones();
			}
		}
		
		/**
		 * Reset Objects to null.
		 */
		public function Reset() : void {
			if (this.parent != null) 
			{
				(parent as Visualizer).Delete_DragonBones();
			}
		}
		
		/**
		 * Background
		 */
		private function Background() : void
		{
			var _quad:Quad = new Quad((Starling.current.stage.stageWidth * .35), Starling.current.stage.stageHeight);
			_quad.setVertexColor(0, Color.SILVER);
			_quad.setVertexColor(1, Color.SILVER);
			_quad.setVertexColor(2, Color.GRAY);
			_quad.setVertexColor(3, Color.GRAY);
			addChild(_quad);
			_quad.pivotX = 0;
			_quad.pivotY = 0;
			this.width = _quad.width;
			this.height = _quad.height;
		}
	}
}