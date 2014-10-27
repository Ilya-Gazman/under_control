package com.gazman.strategy_of_battle.server_time
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class ServerTime
	{
		/**
		 * Return UTC time in seconds since 1970, or -1 if error occur
		 */
		public static function getTime(callBack:Function):void{
			var uRLLoader:URLLoader = new URLLoader();
			uRLLoader.addEventListener(Event.COMPLETE, function(event:Event):void{
				callBack(int(uRLLoader.data));
			});
			uRLLoader.addEventListener(IOErrorEvent.IO_ERROR, function(event:Event):void{
				event.preventDefault();
				callBack(-1);
			});
			uRLLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function(event:Event):void{
				event.preventDefault();
				callBack(-1);
			});
			uRLLoader.load(new URLRequest("http://www.timeapi.org/utc/now?\\s"));
		}
	}
}