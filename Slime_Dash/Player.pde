//Chris (met een beetje hulp van mats)
PImage[] playerSprite;
int playerFrameAmount = 10;
void playerSetup() {
  player = new Player();
  playerSprite = new PImage[playerFrameAmount];

  for (int iSprite = 0; iSprite < playerFrameAmount; iSprite++) {
    playerSprite[iSprite] = loadImage("sprites/player/player"+ iSprite +".png");
  }
}

Player player;
class Player {
  float ground, size, x, y, hitX, hitY, hitSize, hitboxRatio, moveSpeed, vx, vy, gravity, fade, 
    gravityReset, 
    dashSpeed, 
    slowDown, 
    spriteWidth, 
    spriteHeight;

  int dashCooldown, dashTime, dmgCooldown, keyUp, walkFrameCounter, deathFrameCounter, deathFramerate;
  color pColor;
  boolean moving, dashActive, enemyDamage, moveLeft;

  //terugzet waardes van de dashCooldown en dashTime
  final int DASH_COOLDOWN = 40;
  final int DASH_TIME = 8;
  final int DMG_COOLDOWN = 30;
  final int ANIMATION_FRAMERATE = 10;
  final int PLAYER_FRAME_AMOUNT = 4;

  final float JUMPSPEED = globalScale/2.2;
  final float DASHSPEED = globalScale/1.6;
  final float MOVESPEED = globalScale/16;
  final float SPEEDMULT = globalScale/56;
  final float SPEEDSLOWDOWN = globalScale/80;
  final float ICESLOWDOWN = globalScale/62;
  final float MAXMOVESPEED = globalScale/8;
  final float GRAVITY = globalScale/32;

  Player() {
    size = globalScale-1;
    spriteWidth = globalScale + globalScale/(32/14);
    spriteHeight = globalScale + globalScale/16;
    x = globalScale * 4;
    y = globalScale * 2;
    hitboxRatio = 4;
    hitSize = size - size/hitboxRatio;
    moveSpeed = MOVESPEED;
    slowDown = SPEEDSLOWDOWN;
    vx = 0;
    vy = 0;
    dashCooldown = 0;
    dashTime = DASH_TIME;
    dmgCooldown = 0;
    enemyDamage = false;
    pColor = color(0, 255, 0);
    fade = constrain(255, 0, 255);
    moveLeft = false;
    walkFrameCounter = 0;
    deathFrameCounter = 0;
    deathFramerate = 0;
  } 

  //player sprite animatie word hier bepaalt
  //origineel 46 breedt, 34 hoog, geplaats in 32*32 ratio
  void playerAnimation() {
    //dash sprite, heeft ratio 47*34
    if (dashActive && moveLeft) {
      pushMatrix();
      scale(-1.0, 1.0);
      image(playerSprite[5], -x-spriteWidth, y, globalScale/32*47, spriteHeight);
      popMatrix();
    } else if (dashActive && !moveLeft) {
      image(playerSprite[5], x-globalScale/32*15, y, globalScale/32*47, spriteHeight);
    }
    //jump sprite, heeft ratio 46*38
    else if (vy != 0 && moveLeft) {
      pushMatrix();
      scale(-1.0, 1.0);
      image(playerSprite[4], -x-spriteWidth, y, spriteWidth, globalScale/32*38);
      popMatrix();
    } else if (vy != 0 && !moveLeft) {
      image(playerSprite[4], x-(spriteWidth/46*12), y, spriteWidth, globalScale/32*38);
    }
    //death sprite
    else if (interfaces.death && moveLeft) {
      pushMatrix();
      scale(-1.0, 1.0);
      image(playerSprite[6+deathFrameCounter], -x-spriteWidth+(spriteWidth/46*3), y-(spriteHeight/34*2), spriteWidth, spriteHeight);
      popMatrix();
    } else if (interfaces.death && !moveLeft) {
      image(playerSprite[6+deathFrameCounter], x-(spriteWidth/46*12), y-(spriteHeight/34*2), spriteWidth, spriteHeight);
    }
    //walking animations
    else if (moving && inputs.hasValue(LEFT) == true) {
      pushMatrix();
      scale(-1.0, 1.0);
      image(playerSprite[walkFrameCounter], -x-spriteWidth+(spriteWidth/46*3), y-(spriteHeight/34*2), spriteWidth, spriteHeight);
      popMatrix();
    } else if (moving && inputs.hasValue(RIGHT) == true) {
      image(playerSprite[walkFrameCounter], x-(spriteWidth/46*12), y-(spriteHeight/34*2), spriteWidth, spriteHeight);
    } 

    //stand still animations
    else if (moveLeft && !moving) {
      pushMatrix();
      scale(-1.0, 1.0);
      image(playerSprite[0], -x-spriteWidth+(spriteWidth/46*3), y-(spriteHeight/34*2), spriteWidth, spriteHeight);
      popMatrix();
    } else if (!moveLeft && !moving) {
      image(playerSprite[0], x-(spriteWidth/46*12), y-(spriteHeight/34*2), spriteWidth, spriteHeight);
    }
  }

  void blockTypeDetection() {
    //ice blocks
    if (blockCollision(x, y + 1, size) != null && blockCollision(x, y + 1, size).c == ICECOLOR) {
      slowDown = ICESLOWDOWN;
    } else slowDown = SPEEDSLOWDOWN;

    //moving blocks
    if (blockCollision(x, y + 1, size) != null && blockCollision(x, y + 1, size).moving) {
      x += blockCollision(x, y + 1, size).vx;
    }
  }

  //Boolean die detect of de player in een block geduwt is
  boolean pushingBlockFix() {
    if (blockCollision(x, y, size) != null && (y+size) > blockCollision(x, y, size).y) {
      return true;
    } else return false;
  }
  void update() {
    x -= globalScrollSpeed;

    blockTypeDetection();

    //checkt input of player links of rechts gaat.
    if (inputs.hasValue(LEFT) == true) {
      moveLeft = true;
      moving = true;
      moveSpeed *= SPEEDMULT;
      vx -= moveSpeed;
    } else if (inputs.hasValue(RIGHT) == true) {
      moveLeft = false;
      moving = true;
      moveSpeed *= SPEEDMULT;
      vx += moveSpeed;
    } else { 
      moving = false;
      vx *= slowDown;
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
    if (!dashActive) {
      vy += GRAVITY;
    } else vy = 0;

    //checkt of player onground is door 1 pixel onder hem te kijken
    if (blockCollision(x, y + 1, size) != null) {
      vy = keyUp * -JUMPSPEED;
    }

    //Dash abilty, stopt vy (via de if(!dashActive)) en gravity voor horizontale dash
    dashCooldown --;
    dmgCooldown--;
    if (inputs.hasValue(90) == true && (inputs.hasValue(LEFT) == true || inputs.hasValue(RIGHT) == true) && dashCooldown < 0 || dashActive && dashTime > 0 && moving) {
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
    while (y <= -size+1) {
      y++;
    }

    if (!dashActive) {
      y += vy;
    }

    //Als moving block player in muur duwt, wordt de player terug geduwt omhoog
    if (pushingBlockFix()) {
      y -= GRAVITY;
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

    //player animatie updates
    if (frameCount % ANIMATION_FRAMERATE == 0) {
      walkFrameCounter++;
    }
    if (walkFrameCounter == PLAYER_FRAME_AMOUNT) {
      walkFrameCounter = 0;
    }
    if (interfaces.death) {
      deathFramerate++;
        if (deathFramerate % ANIMATION_FRAMERATE==0 && deathFrameCounter != PLAYER_FRAME_AMOUNT-1) {
        deathFrameCounter++;
      }
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
    fill(pColor, fade);
    rect(x, y, size, size);
    playerAnimation();
  }
}

//kijkt of speed - of + is
int sign(float v) {
  int vel = 0; 
  if (v < 0) vel = -1;
  else if (v > 0) vel = 1;

  return vel;
}
