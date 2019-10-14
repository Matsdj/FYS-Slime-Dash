//Chris

void playerSetup() {
  player = new Player();
}

Player player;
class Player {
  float ground, size, x, y, moveSpeed, vx, vy, gravity, fade, 
    gravityReset, 
    dashSpeed, 
    pColor;

  int dashCooldown, dashTime, dmgCooldown, keyDirection, keyUp;

  boolean onGround, reset, dashActive, enemyDamage;

  //terugzet waardes van de dashCooldown en dashTime
  final int DASH_COOLDOWN = 40;
  final int DASH_TIME = 15;
  final int DMG_COOLDOWN = 30;

  final float JUMPSPEED = globalScale/1.6;
  final float DASHSPEED = globalScale/2;
  final float MOVESPEED = globalScale/8;

  Player() {
    size = globalScale-1;
    x = width/5;
    y = height/4;
    moveSpeed = MOVESPEED;
    vx = 0;
    vy = 0;
    gravity = globalScale/21;
    dashCooldown = DASH_COOLDOWN;
    dashTime = DASH_TIME;
    dmgCooldown = 50;
    enemyDamage = false;
    pColor = 255;
    fade = constrain(255, 0, 255);
  }

  void update() {
    x -= globalScrollSpeed;
    //checkt input of player links of rechts gaat. -1 is links, 1 is rechts en 0 is stil
    if (inputs.hasValue(LEFT) == true) {
      keyDirection = -1;
    } else if (inputs.hasValue(RIGHT) == true) {
      keyDirection = 1;
    } else keyDirection = 0;

    if (inputs.hasValue(UP) == true) {
      keyUp = 1;
    } else keyUp = 0;

    vx = keyDirection * moveSpeed;
    vy += gravity;

    if (blockCollision(x, y + 1, size) != null) {
      vy = keyUp * -JUMPSPEED;
    }

    //Horizontal collision
    if (blockCollision(x+vx, y, size) != null) {
      while (blockCollision(x+sign(vx), y, size) == null) {
        x += sign(vx);
      }
      vx = 0;
    }
    x+= vx;

    //Vertical collision
    if (blockCollision(x, y+vy, size) != null) {
      while (blockCollision(x, y+sign(vy), size) == null) {
        y += sign(vy);
      }
      vy = 0;
    }
    y += vy;

    dashCooldown --;
    dmgCooldown--;
    if (inputs.hasValue(90) == true && dashCooldown < 0 || dashActive && dashTime > 0) {
      moveSpeed = DASHSPEED;
      dashCooldown = DASH_COOLDOWN;
      dashActive = true;
      dashTime--;
    } else {
      moveSpeed = MOVESPEED;
      dashActive = false;
      dashTime = DASH_TIME;
    }
    //zorgt er voor dat je dood gaat als je uit de map valt
    if (y>height) {
      interfaces.healthMain -=10;
      interfaces.death =true;
    }
  }

  //method die checkt of collision met player waar is
  boolean Collision(float cX, float cY, float cSize) {
    if (x + size >= cX && x <= cX + cSize && y + size >= cY && y <= cY + cSize) {
      return true;
    } else return false;
  }
  void draw() {
    stroke(0, 0, 0, fade);
    strokeWeight(2);
    fill(0, pColor, 0, fade);
    rect(x, y, size, size);
  }
}

int sign(float v) {
  int vel = 0; 
  if (v < 0) vel = -1;
  else if (v > 0) vel = 1;
  else vel = 0;

  return vel;
}
