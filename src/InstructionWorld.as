package {
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import flash.display.BitmapData;
	
	public class InstructionWorld extends World	{
		
		[Embed(source = 'images/spinner1.png')] private const SPINNER1_IMAGE:Class;
		[Embed(source = 'images/spinner2.png')] private const SPINNER2_IMAGE:Class;
		
		[Embed(source = 'fonts/DejaVuSans.ttf', embedAsCFF="false", fontFamily = 'DejaVuSans')]
		private const INSTRUCTION_FONT:Class;
		private var instructions:Object = new Object();
		
		public function InstructionWorld(gameMode:String) {
			instructions[GameModes.CAMPAIGN] = "Not implemented yet.";
			instructions[GameModes.BATTLE_ROYALE] = "Watch the bloody melee as 4 families of cellular "
				+ "automata fight it out to the death on a randomized battlefield!\n\nFeel free to pause "
				+ "the action and add some of your own cells by clicking anywhere on the grid. For now, " 
				+ "holding Control lets you spread green cells.";
			instructions[GameModes.SANDBOX] = "Devise your own masterful creations on this blank canvas! "
				+ "\n\nAdd cells by clicking anywhere on the grid. For now, holding Control lets you spread "
				+ "green cells.\n\nIf you're stuck for ideas, try finding out how many spinners you can make."
				+ "Here are a couple to get you started: ";

			// background
			var background:BitmapData = new BitmapData(Main.SCREEN_WIDTH, Main.SCREEN_HEIGHT, false, 0xFFFFFF);
			addGraphic(new Stamp(background));
			
			// text
			var text:Text = new Text("Instructions:\n\n");
			text.font = "DejaVuSans";
			text.text += instructions[gameMode];
			text.color = 0x000000;
			text.size = 24;
			text.wordWrap = true;
			text.width = 720;
			addGraphic(text, 0, 40, 10);
			
			// extras
			if (gameMode == GameModes.SANDBOX) {
				addGraphic(new Stamp(SPINNER1_IMAGE), 0, 225, 300);
				addGraphic(new Stamp(SPINNER2_IMAGE), 0, 475, 300);
			}
			
			// ok button
			var okButton:Button = new Button(350, 500, 104, 52);
			var okText:Text = new Text("OK!");
			okText.color = 0x000000;
			okText.font = "Fixedsys Excelsior";
			okText.size = 64;
			okButton.graphic = okText;
			okButton.click = function ():void {
				FP.world = new GameWorld(gameMode);
			};
			add(okButton);
		}
	}
}