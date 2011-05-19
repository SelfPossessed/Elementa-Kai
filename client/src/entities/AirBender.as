package entities {
	import flash.geom.Point;
	
	import flashpunk.graphics.Spritemap;
	import flashpunk.FP;
	import flashpunk.Entity;
	
	import physics.ForceComponent;
	
	import general.Utils;
	
	public class AirBender extends Bender {
		//collision
		public static const COLLISION_TYPE:String = "airbender";
		
		//speed
		private const MAX:Number = 25;
		private const ACCEL:Number = .4;
		private const DECEL:Number = .2;
		
		//size
		private const W:uint = 25;
		private const H:uint = 32;
		
		//sprite
		[Embed(source = '../../images/airbender.PNG')]
		private static const image:Class;
		
		//bounce
		private var shouldBounceVertical:Boolean;
		private var shouldBounceHorizontal:Boolean;
		
		public function AirBender(x:Number = 0, y:Number = 0) {
			//super
			super(x, y, image, W, H);
			
			//size
			width = W;
			height = H;
			
			//collision type
			type = AirBender.COLLISION_TYPE;
			
			//max
			moveForce.max = MAX;
			leftForce.maxVelocity = MAX;
			rightForce.maxVelocity = MAX;
			upForce.maxVelocity = MAX;
			downForce.maxVelocity = MAX;
			
			//accel
			leftForce.acceleration = -ACCEL;
			rightForce.acceleration = ACCEL;
			upForce.acceleration = -ACCEL;
			downForce.acceleration = ACCEL;
			
			//decel
			leftForce.deceleration = DECEL;
			rightForce.deceleration = -DECEL;
			upForce.deceleration = DECEL;
			downForce.deceleration = -DECEL;
		}
		
		override protected function resetShouldVariables():void {
			super.resetShouldVariables();
			shouldBounceVertical = false;
			shouldBounceHorizontal = false;
		}
		
		override protected function collideShouldStop(hitTestResult:int):void {
			if (hitTestResult == HIT_TOP || hitTestResult == HIT_BOTTOM)
				shouldBounceVertical = true;
			else if (hitTestResult == HIT_LEFT || hitTestResult == HIT_RIGHT)
				shouldBounceHorizontal = true;
		}
		
		override protected function didCollideWithBender(e:Entity, hitTestResult:int, intersectSize:Point):void {
			var castedEntity:Bender = e as Bender;
			
			if (hitTestResult == HIT_TOP) {
				shouldBounceVertical = true;
				if (isMovingUp())
					castedEntity.windForce.y += moveForce.y.velocity;
			}else if (hitTestResult == HIT_BOTTOM) {
				shouldBounceVertical = true;
				if (isMovingDown())
					castedEntity.windForce.y += moveForce.y.velocity;
			}else if (hitTestResult == HIT_LEFT) {
				shouldBounceHorizontal = true;
				if (isMovingLeft())
					castedEntity.windForce.x += moveForce.x.velocity;
			}else if (hitTestResult == HIT_RIGHT) {
				shouldBounceHorizontal = true;
				if (isMovingRight())
					castedEntity.windForce.x += moveForce.x.velocity;
			}
		}
		
		override protected function resolveShouldVariables():void {
			super.resolveShouldVariables();
			
			//bounce
			if (shouldBounceVertical)
				bounceVertical();
			if (shouldBounceHorizontal)
				bounceHorizontal();
		}
		
		private function bounceVertical():void {
			var temp:Number = upForce.velocity;
			upForce.velocity = -downForce.velocity;
			downForce.velocity = -temp;
		}
		
		private function bounceHorizontal():void {
			var temp:Number = leftForce.velocity;
			leftForce.velocity = -rightForce.velocity;
			rightForce.velocity = -temp;
		}
	}
}