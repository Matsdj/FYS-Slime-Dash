//Chris

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
    vyReset, 
    gravity, 
    gravityReset, 
    dashSpeed, 
    pColor;

  int dashCooldown, 
    dashTime, 
    dmgCooldown;
  //terugzet waardes van de dashCooldown en dashTime
  final int DASH_COOLDOWN = 40;
  final int DASH_TIME = 15;
  final int DMG_COOLDOWN = 30;

  boolean onGround, reset, dashActive, enemyDamage;

  Player() {
    ground = height - globalScale;
    size = globalScale;
    x = width/4;
    y = height/4;
    vx = globalScale/5;
    vy = globalScale/2;
    vyReset = -globalScale;
    gravity = globalScale/15;
    gravityReset = globalScale/15;
    dashSpeed = width/ 50;
    dashCooldown = DASH_COOLDOWN;
    dashTime = DASH_TIME;
    dmgCooldown = 50;
    enemyDamage = false;
    pColor = 255;
  }
  void update() {
    //vy += gravity;
    y += vy;
    dashCooldown --;
    dmgCooldown--;
    //controls left + right
    if (inputs.hasValue(LEFT) == true && (blockCollision(x-vx, y, size) == null)) {
      x -= vx*frameSpeed;
    } else if (inputs.hasValue(RIGHT) == true) {
      if (blockCollision(x+vx, y, size) == null) {
        x += vx*frameSpeed;
      } else {
        while (blockCollision(x+=vx, y, size) != null) {
          x += blockCollision(x+=vx, y, size).x - x+size;
        }
      }
    } 

    //jumping
    if (inputs.hasValue(UP) == true && onGround) {
      vy = vyReset;
    }
    if (!onGround) {
      vy += gravity* frameSpeed;
    }

    //checks if player is on ground
    if (y + size >= ground) {
      onGround = true;
    } else onGround = false;

    //stops falling once player hits ground
    if (y + size > ground && reset == false) {
      vy *= 0;
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
  boolean Collision(float cX, float cY, float cSize) {
    if (x + size >= cX && x <= cX + cSize && y + size >= cY && y <= cY + cSize) {
      return true;
    } else return false;
  }
  void draw() {
    stroke(0);
    strokeWeight(2);
    fill(0, pColor, 0);
    rect(x, y, size, size);
  }
}
