package worlds {
	import playerio.Connection;
	
	import net.flashpunk.rollback.PlayWorld;
	import net.flashpunk.rollback.PlayerIOGameConnection;
	import net.flashpunk.rollback.GameWorld;
	
	import worlds.AvatarGameWorld;
	
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	
	import general.CommandList;
	import general.Utils;
	
	public class AvatarPlayWorld extends PlayWorld {
		//helper
		private var lostWindowFocus:Boolean = false;
		
		//input command state
		private var space:Boolean = false; //temp debugging
		private var c:Boolean = false; //temp debugging
		private var w:Boolean = false;
		private var a:Boolean = false;
		private var s:Boolean = false;
		private var d:Boolean = false;
		private var mouse:Boolean = false;
		
		public function AvatarPlayWorld(conn:Connection) {
			//super
			super(2, 2, new PlayerIOGameConnection(conn));
		}
		
		/**
		 * Window focus
		 */
		override public function focusLost():void {
			Input.clear();
			lostWindowFocus = true;
		}
		
		override protected function createGameWorld():GameWorld {
			return new AvatarGameWorld();
		}
		
		override protected function updateInputs():void {
			if (lostWindowFocus) {
				//clicked out of window, reset!
				
				//left
				if (a) {
					a = false;
					addMyCommand(CommandList.A);
				}
				
				//right
				if (d) {
					d = false;
					addMyCommand(CommandList.D);
				}
				
				//up
				if (w) {
					w = false;
					addMyCommand(CommandList.W);
				}
				
				//down
				if (s) {
					s = false;
					addMyCommand(CommandList.S);
				}
				
				//mouse
				if (mouse) {
					mouse = false;
					addMyCommand(CommandList.MOUSE);
				}
				
				//c - temp debugging
				if (c) {
					c = false;
				}
				
				//space - temp debugging
				if (space) {
					space = false;
				}
				
				//reset
				lostWindowFocus = false;
			}else {
				//send player inputs!
				
				//left
				if(Input.check(Key.A) != a) {
					a = !a;
					addMyCommand(CommandList.A);
				}
				
				//right
				if(Input.check(Key.D) != d) {
					d = !d;
					addMyCommand(CommandList.D);
				}
				
				//up
				if(Input.check(Key.W) != w) {
					w = !w;
					addMyCommand(CommandList.W);
				}
				
				//down
				if(Input.check(Key.S) != s) {
					s = !s;
					addMyCommand(CommandList.S);
				}
				
				//mouse
				if (Input.mouseDown != mouse) {
					mouse = !mouse;
					addMyCommand(CommandList.MOUSE);
				}
				
				//c - temp debugging
				if (Input.check(Key.C) != c) {
					c = !c;
					if(c)
					Utils.log(displayCommands());
				}
				
				//space - temp debugging
				if (Input.check(Key.SPACE) != space) {
					space = !space;
					if(space)
						Utils.log(trueWorld.toString());
				}
			}
		}
	}
}