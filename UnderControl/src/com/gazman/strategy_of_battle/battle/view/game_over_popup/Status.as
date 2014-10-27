package com.gazman.strategy_of_battle.battle.view.game_over_popup 
{
	import com.gazman.life_cycle.inject;
	import com.gazman.strategy_of_battle.battle.view.GameJuggler;
	import com.gazman.ui.background.Background;
	import com.gazman.ui.group.Group;
	import com.gazman.ui.layouts.AlignLayout;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.layouts.Layout;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	public class Status extends Group
	{
		private var background:Background = inject(Background);
		private var container:Group = inject(Group);
		private var current:TextField = new TextField(80, 22, "");
		private var bonus:TextField = new TextField(80, 22, "");
		private var title:TextField = new TextField(80, 22, "");
		private var currentValue:NumberHodlder = new NumberHodlder();
		
		public function setCurrent(value:int):void {
			currentValue.value = value;
			current.text = value.toString();
		}
		
		public function setBonuse(value:int):void {
			bonus.text = value.toString();
		}
		
		public function setTitle(title:String):void {
			this.title.text = title;
		}
		
		public function animate():void {
			var time:int = 2;
			var tween:Tween = new Tween(bonus, time);
			tween.scaleTo(0.8);
			var tween2:Tween = new Tween(currentValue, time, Transitions.EASE_OUT);
			tween2.animate("value", currentValue.value + Number(bonus.text));
			tween2.onUpdate = updateHandler;
			
			Starling.juggler.add(tween);
			Starling.juggler.add(tween2);
		}
		
		private function updateHandler():void 
		{
			current.text = Math.round(currentValue.value).toString();
		}
		
		override protected function initilize():void 
		{
			super.initilize();
			addChild(background);
			addChild(container);
			addText(title, 0, this);
			addText(current, 0x000080, container);
			addText(bonus, 0xFF8000, container);
			layout();
		}
		
		private function addText(textFiled:TextField, color:uint, container:Group):void 
		{
			container.addChild(textFiled);
			textFiled.color = color;
			//textFiled.hAlign = HAlign.LEFT;
		}
		
		private function layout():void 
		{
			var alignLayout:AlignLayout = new AlignLayout();
			alignLayout.below = 0;
			alignLayout.applyLayoutOn(container, title);
			alignLayout.below = Layout.CLEAR_VALUE;
			alignLayout.toRight = 5;
			alignLayout.applyLayoutOn(bonus, current);
			
			background.color = 0xFFFF80;
			background.alpha = 0.8;
			background.removeFrame();
		}
	}
}
class NumberHodlder{
	public var value:Number;
}