//remember, ctrl+a, ctrl+t
Player player = new Player();

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
  player.movement();
  drawHealthBar(99);
}
