void playerSetup() {
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
    dashCooldown, 
    dashTime;

  //terugzet waardes van de dashCooldown en dashTime
  final float DASH_COOLDOWN = 20;
  final float DASH_TIME = 10;

  boolean onGround, reset, dashActive;

  Player() {
    ground = height - globalScale;
    size = height/9;
    x = width/4;
    y = height/4;
    vx = 1;
    vy = 20;
    gravity = 1.5;
    dashSpeed = width/ 50;
    dashCooldown = DASH_COOLDOWN;
    dashTime = DASH_TIME;
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
    } else if (inputs.hasValue(RIGHT) == true) {
      x += vx;
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

    /*dash ability, starts when you press Z, and keeps going until dash timer 
     has gone under 0. Once that is true, playerX will stop increasing with the dashSpeed
     */
    if (inputs.hasValue(90) == true && dashCooldown < 0 || dashActive && dashTime > 0) {
      if (inputs.hasValue(LEFT) == true) {
        x -= dashSpeed;
        dashCooldown = DASH_COOLDOWN;
      }
      if (inputs.hasValue(RIGHT) == true) {
        x += dashSpeed;
        dashCooldown = DASH_COOLDOWN;
      }
      dashActive = true;
      dashTime--;
    } else {
      dashActive = false;
      dashTime = DASH_TIME;
    }
    
  }
  
  //method die checkt of collision met player waar is
  boolean playerCollision(float cX, float cY, float cSize) {
    if (x + size > cX && x < cX + cSize && y + size > cY && y < cY + cSize) {
      return true;
    } else return false;
  }
  void draw() {
    stroke(0);
    strokeWeight(2);
    fill(0, 255, 0);
    rect(x, y, size, size);
  }
}
