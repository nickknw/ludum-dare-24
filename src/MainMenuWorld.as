package {
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class MainMenuWorld extends World {
		
		[Embed(source = 'fonts/fsex2p00_public.ttf', embedAsCFF="false", fontFamily = 'Fixedsys Excelsior')]
		private const MAIN_FONT:Class;
		
		public function MainMenuWorld() {
			var background:BitmapData = new BitmapData(Main.SCREEN_WIDTH, Main.SCREEN_HEIGHT, false, 0xFFFFFF);
			addGraphic(new Stamp(background));
			
			var titleText:Text = new Text("CONWAY'S REVENGE");
			titleText.color = 0x000000;
			titleText.font = "Fixedsys Excelsior";
			titleText.size = 92;
			titleText.width = Main.SCREEN_WIDTH;
			titleText.align = "center";
			addGraphic(titleText, 0, 0, 10);
			
			var campaignButton:Button = new Button(40, 150, 440, 60);
			var campaignText:Text = new Text("Campaign");
			campaignText.color = 0x9F9F9F;
			campaignText.font = "Fixedsys Excelsior";
			campaignText.size = 64;
			campaignButton.graphic = campaignText;
			add(campaignButton);
			
			
			var battleRoyaleButton:Button = new Button(40, 250, 440, 60);
			var battleRoyaleText:Text = new Text("Battle Royale");
			battleRoyaleText.color = 0x000000;
			battleRoyaleText.font = "Fixedsys Excelsior";
			battleRoyaleText.size = 64;
			battleRoyaleButton.graphic = battleRoyaleText;
			battleRoyaleButton.click = function ():void {
				FP.world = new InstructionWorld(GameModes.BATTLE_ROYALE);
			};
			add(battleRoyaleButton);
			
			var sandboxButton:Button = new Button(40, 350, 440, 60);
			var sandboxText:Text = new Text("Sandbox");
			sandboxText.color = 0x000000;
			sandboxText.font = "Fixedsys Excelsior";
			sandboxText.size = 64;
			sandboxButton.graphic = sandboxText;
			sandboxButton.click = function ():void {
				FP.world = new InstructionWorld(GameModes.SANDBOX);
			};
			add(sandboxButton);
		}
	}
}