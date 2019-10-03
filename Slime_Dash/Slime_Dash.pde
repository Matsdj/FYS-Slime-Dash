//remember, ctrl+a, ctrl+t
Player player = new Player();
float frameSpeed;
// Arrays of booleans for Keyboard handling. One boolean for each keyCode
final int KEY_LIMIT = 1024;
boolean[] keysPressed = new boolean[KEY_LIMIT];

void setup() {
  size(1920, 1080);
  frameRate(60);
}

void updateGame() {
  frameSpeed = 60/frameRate;
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
