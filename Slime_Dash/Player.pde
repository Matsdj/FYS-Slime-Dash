//Chris (met een beetje hulp van mats)

void playerSetup() {
  player = new Player();
}

Player player;
class Player {
  float ground, size, x, y, hitX, hitY, hitSize, hitboxRatio, moveSpeed, vx, vy, gravity, fade, 
    gravityReset, 
    dashSpeed, 
    pColor;

  int dashCooldown, dashTime, dmgCooldown, keyDirection, keyUp;

  boolean onGround, reset, dashActive, enemyDamage;

  //terugzet waardes van de dashCooldown en dashTime
  final int DASH_COOLDOWN = 40;
  final int DASH_TIME = 8;
  final int DMG_COOLDOWN = 30;

  final float JUMPSPEED = globalScale/2.2;
  final float DASHSPEED = globalScale/1.6;
  final float MOVESPEED = globalScale/16;
  final float SPEEDMULT = globalScale/56;
  final float SPEEDSLOWDOWN = globalScale/68;
  final float MAXMOVESPEED = globalScale/8;

  Player() {
    size = globalScale-1;
    x = globalScale * 4;
    y = globalScale * 2;
    hitboxRatio = 4;
    hitSize = size - size/hitboxRatio;
    moveSpeed = MOVESPEED;
    vx = 0;
    vy = 0;
    gravity = globalScale/32;
    dashCooldown = DASH_COOLDOWN;
    dashTime = DASH_TIME;
    dmgCooldown = 50;
    enemyDamage = false;
    pColor = 255;
    fade = constrain(255, 0, 255);
  }  

  void update() {
    x -= globalScrollSpeed;

    //checkt input of player links of rechts gaat.
    if (inputs.hasValue(LEFT) == true) {
      keyDirection = -1;
      moveSpeed *= SPEEDMULT;
      vx -= moveSpeed;
    } else if (inputs.hasValue(RIGHT) == true) {
      keyDirection = 1;
      moveSpeed *= SPEEDMULT;
      vx += moveSpeed;
    } else { 
      keyDirection = 0;
      vx *= SPEEDSLOWDOWN;
      moveSpeed = MOVESPEED;
    }

    //Stops player from movement speed increasing to fast
    if (vx > MAXMOVESPEED) {
      vx = MAXMOVESPEED;
    } else if (vx < -MAXMOVESPEED) {
      vx = -MAXMOVESPEED;
    }

    //checkt het zelfe voor de jump
    if (inputs.hasValue(UP) == true) {
      keyUp = 1;
    } else keyUp = 0;

    //vx = keyDirection * moveSpeed;

    println(vx);

    if (!dashActive) {
      vy += gravity;
    } else vy = 0;

    //checkt of player onground is door 1 pixel onder hem te kijken
    if (blockCollision(x, y + 1, size) != null) {
      vy = keyUp * -JUMPSPEED;
    }

    //Dash abilty, stopt vy (via de if(!dashActive)) en gravity voor horizontale dash
    dashCooldown --;
    dmgCooldown--;
    if (inputs.hasValue(90) == true && (inputs.hasValue(LEFT) == true || inputs.hasValue(RIGHT) == true) && dashCooldown < 0 || dashActive && dashTime > 0 && keyDirection != 0) {
      if (inputs.hasValue(LEFT) == true) {
        vx = -DASHSPEED;
      }
      if (inputs.hasValue(RIGHT) == true) {
        vx = DASHSPEED;
      }
      dashCooldown = DASH_COOLDOWN;
      dashActive = true;
      dashTime--;
    } else {
      moveSpeed = MOVESPEED;
      dashActive = false;
      dashTime = DASH_TIME;
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

    if (!dashActive) {
      y += vy;
    }

    //zorgt er voor dat je dood gaat als je uit de map valt
    if (y>height) {
      interfaces.healthMain -=10;
      interfaces.death =true;
    }

    //gaat dood als player achter linker wand gaat
    if (x + size < 0) {
      interfaces.death = true;
    }

    //hitbox gaat met player mee
    hitX = x + size/(hitboxRatio*2);
    hitY = y + size/(hitboxRatio*2);
  } 

  //method die checkt of collision met player waar is
  boolean Collision(float cX, float cY, float cSize) {
    if (x + size >= cX && x <= cX + cSize && y + size >= cY && y <= cY + cSize) {
      return true;
    } else return false;
  }

  //zelfde method, alleen voor enemies
  boolean hitboxCollision(float cX, float cY, float cSize) {
    if (hitX + hitSize >= cX && hitX <= cX + cSize && hitY + hitSize >= cY && hitY <= cY + cSize) {
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

//kijkt of speed - of + is
int sign(float v) {
  int vel = 0; 
  if (v < 0) vel = -1;
  else if (v > 0) vel = 1;
  else vel = 0;

  return vel;
}
