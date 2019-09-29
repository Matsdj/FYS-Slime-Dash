class Player {
  float playerL = 50;
  float playerH = 50;
  float playerX = 1920/4;
  float playerY = 1080 - 100;
  float playerVx = 0;
  float playerVy = 0;
  float playerGravity = 0;
  float playerDashSpeed = 30;
  float ground = 980;

  boolean onGround;
  boolean reset;
  void movement() {
    playerVy += playerGravity;
    playerX += playerVx;
    playerY += playerVy;

    //controls left + right
    if (inputs.hasValue(LEFT) == true) {
      playerVx = -8;
    } else if (inputs.hasValue(RIGHT) == true) {
      playerVx = 8;
    } else playerVx = 0;

    //jumping
    if (inputs.hasValue(UP) == true && onGround) {
      playerVy = -40;
      playerGravity = 1.5;
    }

    //checks if player is on ground
    if (playerY >= ground) {
      onGround = true;
    } else onGround = false;

    //stops falling once player hits ground
    if (playerY > ground && reset == false) {
      playerVy *= 0;
      playerGravity *= 0;
      playerY = ground;
      reset = true;
    } else reset = false;

    //dash ability
    if (inputs.hasValue(90) == true && playerVx < 0) {
      playerX -= playerDashSpeed;
    } else if (inputs.hasValue(90) == true && playerVx > 0) {
      playerX += playerDashSpeed;
    } 

    fill(255, 255, 255);
    rect(playerX, playerY, playerL, playerH);
  }
}
