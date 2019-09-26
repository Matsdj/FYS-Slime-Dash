class Player {
  float playerL = 50;
  float playerH = 50;
  float playerX = 1920/4;
  float playerY = 1080 - 100;
  int playerVx = 0;
  int playerVy = 0;
  int playerGravity = 0;
  boolean onGround;
  boolean reset;
  void movement() {
    playerVy += playerGravity;
    playerX += playerVx;
    playerY += playerVy;
    if (inputs.hasValue(LEFT) == true) {
      playerVx = -8;
    } else if (inputs.hasValue(RIGHT) == true) {
      playerVx = 8;
    } else playerVx = 0;

    if (inputs.hasValue(UP) == true && onGround) {
      playerVy = -20;
      playerGravity = 1;
    }

    if (playerY >= 1080-100) {
      onGround = true;
    } else onGround = false;

    if (playerY > 1080-100 && reset == false) {
      playerVy *= 0;
      playerGravity *= 0;
      playerY = 1080-100;
      reset = true;
      println(reset);
    } else reset = false;
    fill(255, 255, 255);
    rect(playerX, playerY, playerL, playerH);
  }
}
