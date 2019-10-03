//remember, ctrl+t
Player player = new Player();
float frameSpeed, globalScale;
// Arrays of booleans for Keyboard handling. One boolean for each keyCode
final int KEY_LIMIT = 1024;
boolean[] keysPressed = new boolean[KEY_LIMIT];

void setup() {
  size(1920, 1080);
  frameRate(60);
  globalScale = height/9;
}

void updateGame() {
  //Doe alle snelheden x frameSpeed zodat wanneer de frames omlaag gaan het spel niet trager wordt
  frameSpeed = 60/frameRate;
  //globalScale is hoe groot een block wordt in de hoogte en de breedte gebruik deze variable om de grootte van alles te scalen
  globalScale = height/9;
  player.update();
}
void drawGame() {
  background(255);
  player.draw();
}

void draw() {
  updateGame();
  drawGame();

  //moet in ^^^ verwerkt worden

  drawHealthBar(99);
}
