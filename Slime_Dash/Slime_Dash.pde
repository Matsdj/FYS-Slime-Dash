//remember, ctrl+t
Player player;
float frameSpeed, globalScale;
// Arrays of booleans for Keyboard handling. One boolean for each keyCode
final int KEY_LIMIT = 1024;
boolean[] keysPressed = new boolean[KEY_LIMIT];

void setup() {
  size(1280, 720);
  frameRate(60);
  globalScale = height/9;
  player = new Player();
}

void updateGame() {
  //Doe alle snelheden x frameSpeed zodat wanneer de frames omlaag gaan het spel niet trager wordt
  frameSpeed = 60/frameRate;
  //globalScale is hoe groot een block wordt in de hoogte en de breedte gebruik deze variable om de grootte van alles te scalen
  globalScale = height/9;
  player.update();
  interfaces.update();
}
void drawGame() {
  background(255);
  player.draw();
  interfaces.draw();
}

void draw() {
  updateGame();
  drawGame();

}
