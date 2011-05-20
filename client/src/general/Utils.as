package general {
	import entities.MovableEntity;
	import entities.AirBender;
	import entities.EarthBender;
	import entities.FireBender;
	import entities.WaterBender;
	
	import flash.external.ExternalInterface;
	import flash.geom.Point

	public class Utils {
		/**
		 * Deals with floating point precision desyncs
		 * @param	number
		 * @param	factor
		 * @return
		 */
		public static function toFixed(number:Number, factor:int):Number {
			return (Math.round(number * factor)/factor);
		}
		
		/**
		 * Sends message to JavaScript
		 * @param	data
		 */
		public static function log(data:String):void {
			//temporary - for logging purposes
			ExternalInterface.call("log", data.toString());
			//trace(data.toString());
		}
		
		public static function swap(a:Object, b:Object):void {
			var c:Object = a;
			a = b;
			b = c;
		}
		
		public static function isBender(e:MovableEntity):Boolean {
			return (e.type == WaterBender.COLLISION_TYPE || e.type == FireBender.COLLISION_TYPE || e.type == EarthBender.COLLISION_TYPE || e.type == AirBender.COLLISION_TYPE);
		}
		
		public static function negative(n:Number):Number {
			if (n < 0)
				return n;
			return -n;
		}
		
		public static function distance(x1:Number, y1:Number, x2:Number, y2:Number):Number {
			var dx:Number = x2 - x1;
			var dy:Number = y2 - y1;
			return Math.sqrt((dx * dx) + (dy * dy));
		}
		
		public static function didChangeSign(n1:Number, n2:Number):Boolean {
			if (n1 < 0 && n2 > 0)
				return true;
			if (n1 > 0 && n2 < 0)
				return true;
			return false;
		}
		
		public static function direction(p1:Point, p2:Point):int {
			//declare variables
			var dx:Number = p1.x - p2.x;
			var dy:Number = p1.y - p2.y;
			var rotation:int = rotation(dx, dy);
			
			//Utils.log("rotation is " + rotation);
			
			//return direction
			if(rotation >= 337 || rotation <= 23)
				return 4; //left
			if (rotation < 67)
				return 7; //top left
			if (rotation <= 113)
				return 8; //top
			if (rotation < 157)
				return 9; //top right
			if (rotation <= 203)
				return 6; //right
			if (rotation < 247)
				return 3; //bottom right
			if (rotation <= 293)
				return 2; //bottom
			if (rotation < 337)
				return 1; //bottom left
			
			//default
			return 0;
		}
		
		/**
		 * Returns the rotation angle in degrees
		 * Note that it is still using Flash points, so left/right and up/down are mixed up
		 * @param	dx
		 * @param	dy
		 * @return
		 */
		public static function rotation(dx:Number, dy:Number):Number {
			var result:Number = Math.atan2(dy, dx) * 180 / Math.PI;
			if (result < 0)
				result += 360
			return result;
		}
		
		public function Utils() {
			
		}
	}

}