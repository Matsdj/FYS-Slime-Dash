//remember, ctrl+a, ctrl+t
Player player = new Player();

void setup() {
  size(1920, 1080);
  background(255);
  
  //tab settings
  HUDsettings();
}

void draw() {
  background(255);
  drawHealthBar();
  player.movement();
}
