void playerSetup(){
    player = new Player();
}

Player player;
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
    ground = height;
    size = height/9;
    x = width/4;
    y = height/2;
    vx = 2;
    vy = 20;
    gravity = 1.5;
    dashSpeed = width/ 8;
    dashCooldown = 20;
  }
  void update() {
    vy *= frameSpeed;
    vx *= frameSpeed;
    gravity *= frameSpeed;
    vy += gravity;
    y += vy;
    dashCooldown --;

    //controls left + right
    if (inputs.hasValue(LEFT) == true) {
      x -= vx;
      if (inputs.hasValue(90) == true && dashCooldown < 0) {
        x -= dashSpeed;
        dashCooldown = 20;
      }
    } else if (inputs.hasValue(RIGHT) == true) {
      x += vx;
      if (inputs.hasValue(90) == true && dashCooldown < 0) {
        x += dashSpeed;
        dashCooldown = 20;
      }
    } 

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
    //reset makes if statement run once when landing on ground
  }
  void draw() {
    stroke(0);
    strokeWeight(2);
    fill(0, 255, 0);
    rect(x, y, size, size);
  }
}
