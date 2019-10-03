class Player {
  float ground, 
    size, 
    x, 
    y, 
    vx, 
    vy, 
    gravity, 
    dashSpeed, 
    dashCooldown;

  boolean onGround, reset;

  Player() {
    ground = 980;
    size = 100;
    x = 1920/4;
    y = 500;
    vx = 0;
    vy = 20;
    gravity = 1.5;
    dashSpeed = 30;
    dashCooldown = 20;
  }
  void update() {
    vy += gravity;
    x += vx;
    y += vy;

    //controls left + right
    if (inputs.hasValue(LEFT) == true) {
      vx = -8;
    } else if (inputs.hasValue(RIGHT) == true) {
      vx = 8;
    } else vx = 0;

    //jumping
    if (inputs.hasValue(UP) == true && onGround) {
      vy = -40;
      gravity = 1.5;
    }

    //checks if player is on ground
    if (y + size >= ground) {
      onGround = true;
    } else onGround = false;

    //stops falling once player hits ground
    if (y + size > ground && reset == false) {
      vy *= 0;
      gravity *= 0;
      y = ground - size;
      reset = true;
    } else reset = false;

    //dash ability
    if (inputs.hasValue(90) == true && vx < 0) {
      x -= dashSpeed;
    } else if (inputs.hasValue(90) == true && vx > 0) {
      x += dashSpeed;
    } 

    fill(0, 255, 0);
    rect(x, y, size, size);
  }
}
