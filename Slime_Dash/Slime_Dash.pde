//remember, ctrl+a, ctrl+t
Player player = new Player();

void setup() {
  size(1920, 1080);
}

void draw() {

  background(255);
  player.update();
  drawHealthBar(99);
}
