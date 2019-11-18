//Chris (met een beetje hulp van mats)

final int PLAYER_FRAME_AMOUNT = 10;
void playerSetup() {
  player = new Player();
}

Player player;
class Player {
  float ground, size, x, y, hitX, hitY, hitSize, hitboxRatio, moveSpeed, vx, vy, gravity, fade, 
    gravityReset, 
    dashSpeed, 
    slowDown, 
    movingBlockSpeed, 
    ySprite, 
    xSpriteL, 
    xSpriteR;

  int dashCooldown, dashTime, dmgCooldown, keyUp, walkFrameCounter, deathFrameCounter, deathFramerate, jumpedAmount;
  color pColor;
  boolean moving, dashActive, enemyDamage, moveLeft;

  //terugzet waardes van de dashCooldown en dashTime
  final int DASH_COOLDOWN = 40;
  final int DASH_TIME = 8;
  final int DMG_COOLDOWN = 30;
  final int ANIMATION_FRAMERATE = 10;
  final int PLAYER_FRAME_AMOUNT = 4;
  final int MAX_JUMP_AMOUNT = 1;

  final float JUMPSPEED = globalScale/2.2;
  final float DASHSPEED = globalScale/1.6;
  final float MOVESPEED = globalScale/16;
  final float SPEEDMULT = 1.9;
  final float SPEEDSLOWDOWN = 0.85;
  final float ICESLOWDOWN = 0.98;
  final float MAXMOVESPEED = globalScale/8;
  final float GRAVITY = globalScale/32;

  Player() {
    size = globalScale-1;
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
    jumpedAmount = 0;
  } 

  //player sprite animatie word hier bepaalt
  void playerAnimation() {
    ySprite = y - pushPlayerSpriteUp;
    xSpriteL = x - pushPlayerSpriteL;
    xSpriteR = x - pushPlayerSpriteR;
    
    //dash animation
    if (dashActive && moveLeft) {
      pushMatrix();
      scale(-1.0, 1.0);
      image(playerSprite[5], -xSpriteL-playerSprite[0].width, ySprite);
      popMatrix();
    } else if (dashActive && !moveLeft) {
      image(playerSprite[5], xSpriteR, ySprite);
    }

    //jump animation
    else if (vy != 0 && moveLeft) {
      pushMatrix();
      scale(-1.0, 1.0);
      image(playerSprite[4], -xSpriteL-playerSprite[0].width, ySprite);
      popMatrix();
    } else if (vy != 0 && !moveLeft) {
      image(playerSprite[4], xSpriteR, ySprite);
    }

    //death animatie
    else if (interfaces.death && moveLeft) {
      pushMatrix();
      scale(-1.0, 1.0);
      image(playerSprite[6+deathFrameCounter], -xSpriteL-playerSprite[0].width, ySprite);
      popMatrix();
    } else if (interfaces.death && !moveLeft) {
      image(playerSprite[6+deathFrameCounter], xSpriteR, ySprite);
    }

    //damaged animatie
    else if (dmgCooldown >=0 && moveLeft) {
      pushMatrix();
      scale(-1.0, 1.0);
      image(playerSprite[6], -xSpriteL-playerSprite[0].width, ySprite);
      popMatrix();
    } else if (dmgCooldown >=0 && !moveLeft) {
      image(playerSprite[6], xSpriteR, ySprite);
    }

    //walking animatie
    else if (moving && inputs.hasValue(LEFT) == true) {
      pushMatrix();
      scale(-1.0, 1.0);
      image(playerSprite[walkFrameCounter], -xSpriteL-playerSprite[0].width, ySprite);
      popMatrix();
    } else if (moving && inputs.hasValue(RIGHT) == true) {
      image(playerSprite[walkFrameCounter], xSpriteR, ySprite);
    } 

    //stand still animatie
    else if (moveLeft && !moving) {
      pushMatrix();
      scale(-1.0, 1.0);
      image(playerSprite[0], -xSpriteL-playerSprite[0].width, ySprite);
      popMatrix();
    } else if (!moveLeft && !moving) {
      image(playerSprite[0], xSpriteR, ySprite);
    }
  }

  void blockTypeDetection() {
    //ice blocks
    if (blockCollision(x, y + 1, size) != null && blockCollision(x, y + 1, size).c == ICE) {
      slowDown = ICESLOWDOWN;
    } else slowDown = SPEEDSLOWDOWN;

    //moving blocks
    if (blockCollision(x, y + 1, size) != null && blockCollision(x, y + 1, size).moving) {
      if (blockCollision(x+movingBlockSpeed, y, size) != null) {
        while (blockCollision(x+sign(movingBlockSpeed), y, size) == null) {
          x += sign(movingBlockSpeed);
        }
        movingBlockSpeed = 0;
      } else movingBlockSpeed = blockCollision(x, y + 1, size).vx;
      x += movingBlockSpeed;
    }
    //zorgt ervoor dat als de player in een blok is geduwt, hij er ook weer uit kan komen
    if (insideBlock()) {
      if (blockCollision(x, y, size).moving) {
        y--;
      } else if (blockCollision(x+globalScale/2, y, size) != null) {
        x -= 1;
      } else if (blockCollision(x-globalScale/2, y, size) != null) {
        x += 1;
      }
    }
  }

  //Boolean die detect of de player in een block geduwt is
  boolean insideBlock() {
    if (blockCollision(x, y, size) != null && (y+size) > blockCollision(x, y, size).y) {
      return true;
    } else return false;
  }
  void update() {
    x -= globalScrollSpeed;

    dashCooldown --;
    dmgCooldown--;

    blockTypeDetection();

    //all movement
    if (!interfaces.death) {
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

      //checkt het zelfe voor de jump
      if (inputs.hasValue(UP) == true) {
        keyUp = 1;
        if (SlimeJump.isPlaying() ==false) {
          SlimeJump.rate(random(0.5, 1.5));
          SlimeJump.play();
        }
      } else keyUp = 0;     

      //Stops player from movement speed increasing to fast
      if (vx > MAXMOVESPEED) {
        vx = MAXMOVESPEED;
      } else if (vx < -MAXMOVESPEED) {
        vx = -MAXMOVESPEED;
      }

      //checkt of player onground is door 1 pixel onder hem te kijken
      if (blockCollision(x, y + 1, size) != null) {
        vy = keyUp * -JUMPSPEED;
        jumpedAmount = 0;
      } else if (inputsPressed.hasValue(UP) == true && jumpedAmount < MAX_JUMP_AMOUNT) {
        vy = keyUp * -JUMPSPEED;
        jumpedAmount ++;
      }

      //Dash abilty, stopt vy (via de if(!dashActive)) en gravity voor horizontale dash
      if (inputs.hasValue(90) == true && (inputs.hasValue(LEFT) == true || inputs.hasValue(RIGHT) == true) && dashCooldown < 0 || dashActive && dashTime > 0 && moving) {
        if (DashSlime.isPlaying() ==false) {
          DashSlime.rate(random(0.8, 1.2)); 
          DashSlime.play();
        }
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
    }

    //vx = keyDirection * moveSpeed;
    if (!dashActive) {
      vy += GRAVITY;
    } else vy = 0;

    //Collisions
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
    //rect(x, y, size, size);
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
