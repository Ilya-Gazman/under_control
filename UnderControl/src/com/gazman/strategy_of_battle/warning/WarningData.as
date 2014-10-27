package com.gazman.strategy_of_battle.warning
{
	public class WarningData
	{
		public var icon:IconData = new IconData();
		public var message:String = "Warning";
		public var positive:ButtonData = new ButtonData("OK");
		public var negative:ButtonData = new ButtonData("Cancel");
		public var oneButton:Boolean;
		
		public function WarningData() 
		{
			super();
		}
	}
}
import com.gazman.life_cycle.inject;
import com.gazman.strategy_of_battle.battle.model.Resources;

import starling.textures.Texture;

class IconData{
	private var _image:Texture = null;
	private var resources:Resources = inject(Resources);
	public var description:String = "System";

	public function IconData() 
	{
		super();
	}
	
	public function get image():Texture
	{
		return _image != null ? _image : defaultImage();
	}
	
	private function defaultImage():Texture
	{
		return resources.getTexture("house.jpg");
	}
	
	public function set image(value:Texture):void
	{
		_image = value;
	}
}
class ButtonData
{
	public var action:Function = function():void{};
	public var label:String;
	
	public function ButtonData(label:String){
		this.label = label;
	}
}