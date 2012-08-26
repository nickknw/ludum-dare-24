package {
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class MainMenuWorld extends World {
		[Embed(source = 'images/title.png')] private const TITLE_IMAGE:Class;
		[Embed(source = 'images/campaign.png')] private const CAMPAIGN_IMAGE:Class;
		[Embed(source = 'images/battleRoyale.png')] private const BATTLE_ROYALE_IMAGE:Class;
		[Embed(source = 'images/sandbox.png')] private const SANDBOX_IMAGE:Class;
		
		public function MainMenuWorld() {
			var background:BitmapData = new BitmapData(Main.SCREEN_WIDTH, Main.SCREEN_HEIGHT, false, 0xFFFFFF);
			addGraphic(new Stamp(background));
			addGraphic(new Stamp(TITLE_IMAGE), 0, 40, 10);
			addGraphic(new Stamp(CAMPAIGN_IMAGE), 0, 40, 150);
			
			var battleRoyaleButton:Button = new Button(40, 250, 440, 60);
			battleRoyaleButton.setImage(BATTLE_ROYALE_IMAGE);
			battleRoyaleButton.click = function ():void {
				FP.world = new InstructionWorld(GameModes.BATTLE_ROYALE);
			};
			add(battleRoyaleButton);
			
			addGraphic(new Stamp(SANDBOX_IMAGE), 0, 40, 350);
		}
	}
}