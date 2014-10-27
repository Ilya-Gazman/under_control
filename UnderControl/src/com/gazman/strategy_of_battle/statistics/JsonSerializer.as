package com.gazman.strategy_of_battle.statistics 
{
	import avmplus.getQualifiedClassName;
	import avmplus.getQualifiedSuperclassName;
	import flash.net.SharedObject;
	import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	public class JsonSerializer 
	{
		private var coockieKey:String;
		private var valueKey:String;
		
		public function JsonSerializer(){}
		
		public function setKeys(coockieKey:String, valueKey:String = null):void {
			this.valueKey = valueKey != null ? valueKey.split(" ").join("_") : null;
			this.coockieKey = coockieKey.split(" ").join("_");
		}
		
		public function save():void {
			var cookie:SharedObject = SharedObject.getLocal(coockieKey);
			var data:String = JSON.stringify(this);
			cookie.data[valueKey != null ? valueKey : coockieKey] = data;
			cookie.flush();
		}
		
		public function load():void {
			var cookie:SharedObject = SharedObject.getLocal(coockieKey);
			var data:String = cookie.data[valueKey != null ? valueKey : coockieKey];
			if (data == null) {
				return;
			}
			var objectData:Object = JSON.parse(data);
			for (var key:String in objectData) {
				if (hasOwnProperty(key) && getClass(objectData[key]) != Object) {
					try{
						this[key] = objectData[key];
					}
					catch (error:ReferenceError) {
						// parameter is read only
					}
				}
			}
		}
		
		
		
		public function getClass(obj:Object):Class {
			return Class(getDefinitionByName(getQualifiedClassName(obj)));
		}
	}
}