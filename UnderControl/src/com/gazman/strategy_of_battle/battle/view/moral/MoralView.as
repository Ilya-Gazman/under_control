package com.gazman.strategy_of_battle.battle.view.moral 
{
	import com.gazman.life_cycle.inject;
	import com.gazman.strategy_of_battle.battle.model.Resources;
	import com.gazman.strategy_of_battle.battle.view.GameJuggler;
	import com.gazman.ui.group.Group;
	import com.gazman.ui.layouts.AlignLayout;
	import com.gazman.ui.layouts.ContainerLayout;
	import starling.animation.Tween;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	public class MoralView extends Group 
	{
		private var resources:Resources = inject(Resources);
		private var image:Image;
		private var textField:TextField;
		public var ratio:Number = 0.5;
		private var gameJuggler:GameJuggler = inject(GameJuggler);
		private var animation:Tween;
		
		public function MoralView() {}
		
		public function handleHit():void 
		{
			visible = true;
			ratio += 0.035;
			if (ratio > 1.5) {
				ratio = 1.5;
			}
			scaleDown();
		}
		
		private function scaleDown():void 
		{
			image.alpha = 1;
			if (animation) {
				gameJuggler.remove(animation);				
			}
			animation = new Tween(this, 2);
			animation.animate("ratio", ratio / 2);
			animation.onComplete = animationCompleteHandler;
			animation.onUpdate = update;
			gameJuggler.add(animation);
		}
		
		private function animationCompleteHandler():void 
		{
			visible = false;
		}
		
		private function update():void 
		{
			textField.alpha = image.alpha;
			scaleX = scaleY = ratio;
		}
		
		override protected function initilize():void 
		{	
			addEventListener(TouchEvent.TOUCH, onTouch);
			initTitle();
			initImage();
			layout();
			visible = false;
		}
		
		private function onTouch(event:TouchEvent):void 
		{
			var touch:Touch = event.getTouch(this, TouchPhase.BEGAN);
			if (!touch) {
				return;
			}
			handleHit();
		}
		
		private function layout():void 
		{
			var alignLayout:AlignLayout = new AlignLayout();
			alignLayout.below = 0;
			alignLayout.applyLayoutOn(textField, image);
			
			var containerLayout:ContainerLayout = new ContainerLayout();
			containerLayout.horizontalCenter = 0;
			containerLayout.applyLayoutOn(image, textField);
		}
		
		private function initImage():void 
		{
			var texture:Texture = resources.getTexture("ball.png");
			image = new Image(texture);
			image.scaleX = image.scaleY = ratio;
			addChild(image);
		}
		
		private function initTitle():void 
		{
			textField = new TextField(80, 20, "Moral");
			addChild(textField);
		}
	}

}