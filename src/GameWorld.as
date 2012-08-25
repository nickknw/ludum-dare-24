package {
	import net.flashpunk.World;
		
	public class GameWorld extends World {

		public static var players:Array = [
			{colour: 0xFFFFFF},
			{colour: 0xCC5555},
			{colour: 0x55CC55 },
			{colour: 0x5555CC }
		];
		
		public function GameWorld() {
			add(new BoardEntity)
		}
		
	}

}