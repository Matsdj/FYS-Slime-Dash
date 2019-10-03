//remember, ctrl+a, ctrl+t
Player player = new Player();

// Arrays of booleans for Keyboard handling. One boolean for each keyCode
final int KEY_LIMIT = 1024;
boolean[] keysPressed = new boolean[KEY_LIMIT];

void setup() {
  size(1920, 1080);
}

void updateGame() {
}
void drawGame() {
}

void draw() {
  updateGame();
  drawGame();

  //moet in ^^^ verwerkt worden
  background(255);
  player.update();
  drawHealthBar(99);
}
