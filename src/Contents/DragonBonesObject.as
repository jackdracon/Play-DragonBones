package Contents 
{
	import dragonBones.objects.SkeletonData;
	import dragonBones.textures.StarlingTextureAtlas;
	import dragonBones.factorys.StarlingFactory;
	import dragonBones.Armature;
	import dragonBones.objects.XMLDataParser;
	import dragonBones.animation.WorldClock;
	import starling.events.Event;
	
	import starling.textures.Texture;
	import starling.display.Sprite;
	
	import flash.utils.Dictionary;
	
	/**
	 * Animate object with the properties from the loaded element.
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
		public function DragonBonesObject(_atlas :StarlingTextureAtlas, _skl : XML) : void
		{			
			factory = new StarlingFactory();
			var _parsedSkeletonData : SkeletonData = XMLDataParser.parseSkeletonData(_skl);
			armatureCollection = _parsedSkeletonData.armatureNames;
			factory.addSkeletonData(_parsedSkeletonData);
			factory.addTextureAtlas(_atlas);
			armature = factory.buildArmature(armatureCollection[0]);
			//trace(armature + " $$ " + armatureCollection[0]);
			if (armature) 
			{
				trace("Load Armature");
				animationList = armature.animation.animationList;
				spriteArmature = armature.display as Sprite;
				addChild(spriteArmature);
				WorldClock.clock.add(armature);
				addEventListener(Event.ENTER_FRAME, Update);
				Play(animationList[0]);
			}
		}
		
		public function Stop() : void {
			armature.animation.stop();
		}
		
		public function Play(_str : String): void {
			armature.animation.gotoAndPlay(_str);
		}
		
		private function Update(e:Event):void 
		{
			WorldClock.clock.advanceTime( -1);
		}
	}
}