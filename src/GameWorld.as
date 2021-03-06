package {
	import flash.events.Event;
	import net.flashpunk.World;
		
	public class GameWorld extends World {
		
		public var gameMode:String;
		
		public static var players:Array = [
			{colour: 0xFFFFFF},
			{colour: 0xCC5555},
			{colour: 0x55CC55},
			{colour: 0x5555CC},
			{colour: 0x555555}
		];
		
		public function GameWorld(_gameMode:String) {
			gameMode = _gameMode;
			
			addList((new Controls).list());
			add(new BoardEntity(gameMode));
		}
	}
}