package com.gazman.strategy_of_battle.utils 
{
	import com.gazman.life_cycle.inject;
	import com.gazman.ui.background.Background;
	import com.gazman.ui.group.Group;
	import starling.text.TextField;
	import starling.utils.HAlign;
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	public class Label extends Group 
	{
		private var background:Background = inject(Background);
		private var container:Group = inject(Group);
		private var textBox:TextField = new TextField(80, 18, "");
		
		public function set text(text:String):void {
			this.textBox.text = text;
		}
		
		public function set bold(value:Boolean):void 
		{
			textBox.bold = value;
		}
		
		public function set hAlign(value:String):void 
		{
			textBox.hAlign = value;
		}
		
		override protected function initilize():void 
		{
			addChild(background);
			addChild(textBox);
			background.color = 0xFFFF80;
			background.alpha = 0.8;
			background.removeFrame();
		}
		
		public function set backgroundAlpha(value:Number):void 
		{
			background.alpha = value;
		}
		
		public function set color(value:uint):void {
			textBox.color = value;
		}
		
		public function set backgroundColor(value:uint):void {
			background.color = value;
		}
	}
}