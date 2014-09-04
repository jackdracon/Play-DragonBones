package Contents 
{
	import dragonBones.objects.SkeletonData;
	import dragonBones.textures.StarlingTextureAtlas;
	import dragonBones.factorys.StarlingFactory;
	import dragonBones.Armature;
	import dragonBones.objects.XMLDataParser;
	import dragonBones.animation.WorldClock;
	import flash.geom.Point;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	
	import starling.textures.Texture;
	import starling.display.Sprite;
	
	import flash.utils.Dictionary;
	
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * Object with DragonBones structure.
	 * @author Jack Dracon
	 */
	public final class DragonBonesObject extends Sprite
	{
		private var _animationCollections : Array = [];
		private var armature : Armature;
		private var factory : StarlingFactory;
		private var spriteArmature : Sprite;
		
		private var armatureCollection : Vector.<String>;
		private var animationList:Vector.<String>;
		private var currentAnimationName : String;
		
		/**
		 * Constructor for the DragonBones object.
		 * @param	_atlas, texture to generate the object.
		 * @param	_skl, Skeleton data.
		 */
		public function DragonBonesObject(_atlas : StarlingTextureAtlas, _skl : XML, _handlerMove:Function) : void
		{			
			factory = new StarlingFactory();
			var _parsedSkeletonData : SkeletonData = XMLDataParser.parseSkeletonData(_skl);
			armatureCollection = _parsedSkeletonData.armatureNames;
			factory.addSkeletonData(_parsedSkeletonData);
			factory.addTextureAtlas(_atlas);
			armature = factory.buildArmature(armatureCollection[0]);
			if (armature) 
			{
				trace("Load Armature");
				animationList = armature.animation.animationList;
				spriteArmature = armature.display as Sprite;
				this.width = spriteArmature.width;
				this.height = spriteArmature.height;
				
				addChild(spriteArmature);
				WorldClock.clock.add(armature);
				addEventListener(Event.ENTER_FRAME, Update);
				Play(animationList[0]);
			}
			addEventListener(TouchEvent.TOUCH, _handlerMove);
		}
		
		/**
		 * Touch handler 
		 * @param	e
		 */
		private function OnTouch(e:TouchEvent) : void 
		{
			var _touch:Touch = e.getTouch(this);
			if (_touch) {
				switch(_touch.phase) {
					case(TouchPhase.MOVED):
						var _point:Point = _touch.getLocation(parent);
						this.x = _point.x + (this.width * .5);
						this.y = _point.y + (this.height * .75);
					break;
				}
			}
		}
		/**
		* Stop the current animation 
		*/
		public function Stop() : void {
			armature.animation.stop();
		}
		/**
		 * Play the specific animation
		 * @param	_str, the name of animation to play.
		 */
		public function Play(_str : String): void {
			currentAnimationName = _str;
			armature.animation.gotoAndPlay(currentAnimationName);
		}
		
		/**
		 * Get the name of the current animation.
		 */
		public function get CurrentAnimation():String { return currentAnimationName;}
		
		/**
		 * A collection list with animations name.
		 */
		public function get AnimationCollection():Vector.<String> {	return animationList;	}
		
		/**
		* Get the armatures list.
		*/
		public function get ArmatureList():Vector.<String> { return armatureCollection;	}
		
		/**
		 * Update Handler to this object.
		 * @param	e
		 */
		private function Update(e:Event):void 
		{
			WorldClock.clock.advanceTime( -1);
		}
		
		/**
		* Remove the current listener over this object.
		*/
		public function RemoveEventListener():void {
			removeEventListener(EnterFrameEvent.ENTER_FRAME, Update);
		}
	}
}