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

  int dashCooldown, dashCooldownReset, dubbleJumpCounter, dashTime, dmgCooldown, keyUp, walkFrameCounter, deathFrameCounter, deathFramerate, jumpedAmount;
  color pColor;
  boolean moving, dashActive, enemyDamage, moveLeft, dmgBlink;

  //terugzet waardes van de dashCooldown en dashTime
  final int DASH_COOLDOWN_START = 100;
  final int DASH_TIME = 8;
  final int DMG_COOLDOWN = 30;
  final int ANIMATION_FRAMERATE = 10;
  final int PLAYER_FRAME_AMOUNT = 4;
  final int DMG_BLINK_FRAMERATE = 10;

  final float JUMPSPEED = globalScale/2.3; //jump force
  final float DASHSPEED = globalScale/1.6; //dash speed
  final float MOVESPEED = globalScale/16; //starting speed
  final float SPEEDMULT = 1.9;
  final float SPEEDSLOWDOWN = 0.85; //slowdown rate on normal ground
  final float ICESLOWDOWN = 0.98; //this is the slowdown of the player if he walks on ice
  final float MAXMOVESPEED = globalScale/8; //max player walking speed
  final float GRAVITY = globalScale/42; //speed at witch player falls

  Player() {
    size = globalScale-1;
    x = globalScale * 4; //spawn cords
    y = globalScale * 2;
    hitboxRatio = 4;  //size of the hitbox is defined by this
    hitSize = size - size/hitboxRatio;
    moveSpeed = MOVESPEED;
    slowDown = SPEEDSLOWDOWN;
    vx = 0;
    vy = 0;
    dashCooldownReset = DASH_COOLDOWN_START; //change this to upgrade dash cooldown
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
    dubbleJumpCounter = 0; // +1 this to activate dubble jump;
    jumpedAmount = 0;
  } 

  //player animation is done in this function. It looks if the player is looking left or right, and looks what action the player is doing. Push matrix and pop matrix statements are there for mirroring player sprites
  void playerAnimation() {
    ySprite = y - pushPlayerSpriteUp;
    xSpriteL = x - pushPlayerSpriteL;
    xSpriteR = x - pushPlayerSpriteR;

    //switches between dmg sprites, causing a blink effect
    if (dmgCooldown >= 0) {
      if (dmgCooldown % (DMG_BLINK_FRAMERATE*2) == 0) {
        dmgBlink = true;
      } else if (dmgCooldown % DMG_BLINK_FRAMERATE == 0) {
        dmgBlink = false;
      }
    } else dmgBlink = true;

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
      //makes player blink white when damaged
      pushMatrix();
      scale(-1.0, 1.0);
      if (!dmgBlink) {
        image(playerSprite[6], -xSpriteL-playerSprite[0].width, ySprite);
      } else if (dmgBlink) {
        image(playerDmgBlink, -xSpriteL-playerSprite[0].width, ySprite);
      }
      popMatrix();
    } else if (dmgCooldown >=0 && !moveLeft) {
      if (!dmgBlink) {
        image(playerSprite[6], xSpriteR, ySprite);
      } else if (dmgBlink) {
        image(playerDmgBlink, xSpriteR, ySprite);
      }
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
    
    //ice blocks, if on top of one the speed decreases less fast
    if (blockCollision(x, y + 1, size) != null && blockCollision(x, y + 1, size).c == ICE) {
      slowDown = ICESLOWDOWN;
    }

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
    
    //Pushes player out of block if needed
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

  //Boolean that checks if the player is inside of a block
  boolean insideBlock() {
    if (blockCollision(x, y, size) != null && (y+size) > blockCollision(x, y, size).y) {
      return true;
    } else return false;
  }
  void update() {
    x -= globalScrollSpeed;
    y += globalVerticalSpeed;

    dashCooldown --;
    dmgCooldown--;

    blockTypeDetection();

////////Movement//////////////////////////
    if (!interfaces.death) {
      
      //checks input if the player goes left or right
      //the speed multiplier makes the player go increasingly faster, until max movement speed is reached
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

      //checks the same for jumping
      if (inputs.hasValue(UP) == true) {
        keyUp = 1;
        if (SlimeJump.isPlaying() ==false) {
          SlimeJump.rate(random(0.5, 1.5));
          SlimeJump.play();
        }
      } else keyUp = 0;     

      //sets the max movement speed for the player
      if (vx > MAXMOVESPEED) {
        vx = MAXMOVESPEED;
      } else if (vx < -MAXMOVESPEED) {
        vx = -MAXMOVESPEED;
      }

      //checks if player is onground by looking 1 pixel below him. If true, he can jumo
      if (blockCollision(x, y + 1, size) != null) {
        vy = keyUp * -JUMPSPEED;
        jumpedAmount = 0;
      } else if (inputsPressed.hasValue(UP) == true && jumpedAmount < dubbleJumpCounter) {
        vy = keyUp * -JUMPSPEED;
        jumpedAmount ++;
      }

      //Dash abilty
      if (inputs.hasValue(90) == true && (inputs.hasValue(LEFT) == true || inputs.hasValue(RIGHT) == true) && dashCooldown < 0 || dashActive && dashTime > 0 && moving) {
        if (DashSlime.isPlaying() ==false) {
          DashSlime.rate(random(0.8, 1.2)); 
          DashSlime.play();
        }

        //looks if you are moving right or left
        if (inputs.hasValue(LEFT) == true) {
          vx = -DASHSPEED;
        }
        if (inputs.hasValue(RIGHT) == true) {
          vx = DASHSPEED;
        }
        dashCooldown = dashCooldownReset;
        dashActive = true;
        dashTime--;
        
        //sets back normal speed, if not dashing
      } else {
        moveSpeed = MOVESPEED;
        dashActive = false;
        dashTime = DASH_TIME;
      }
    }

    //if you dash, you wont fall
    if (!dashActive) {
      vy += GRAVITY;
    } else vy = 0;

///////Collisions/////////////////////

    //Horizontal collision
    //when theres collision going to happen next frame, the player will be placed next to the block because of the while statement
    if (blockCollision(x+vx, y, size) != null) {
      while (blockCollision(x+sign(vx), y, size) == null) {
        x += sign(vx);
      }
      vx = 0;
    }

    if (!interfaces.death) {
      x+= vx;
    }
    //Vertical collision
    //works like horizontal collision, only now with vy
    if (blockCollision(x, y+vy, size) != null) {
      while (blockCollision(x, y+sign(vy), size) == null) {
        y += sign(vy);
      }
      vy = 0;
      slowDown = SPEEDSLOWDOWN;
    }

    //stops player from going above the screen
    while (y <= -size+1) {
      y++;
    }

    if (!dashActive) {
      y += vy;
    }

    //if you fall out of the map, you die
    if (y>height) {
      interfaces.health -=10;
      interfaces.death =true;
    }

    //dies if player goes off left side of the screen
    if (x + size < 0) {
      interfaces.death = true;
    }

    //player animation updates
    if (frameCount % ANIMATION_FRAMERATE == 0) {
      walkFrameCounter++;
    }
    if (walkFrameCounter == PLAYER_FRAME_AMOUNT) {
      walkFrameCounter = 0;
    }

    //activates death animation for the player
    if (interfaces.death) {
      deathFramerate++;
      if (deathFramerate % ANIMATION_FRAMERATE==0 && deathFrameCounter != PLAYER_FRAME_AMOUNT-1) {
        deathFrameCounter++;
      }
    }

    //hitbox follows the player. The size of the hitbox depends on the hitboxRatio
    hitX = x + size/(hitboxRatio*2);
    hitY = y + size/(hitboxRatio*2);
  } 

  //method that checks if there is player collision (used for pickups)
  boolean Collision(float cX, float cY, float cSize) {
    if (x + size >= cX && x <= cX + cSize && y + size >= cY && y <= cY + cSize) {
      return true;
    } else return false;
  }

  //same method, only here the smaller hitbox is used for enemies and obstacles
  boolean hitboxCollision(float cX, float cY, float cWidth, float cHeight) {
    if (hitX + hitSize >= cX && hitX <= cX + cWidth && hitY + hitSize >= cY && hitY <= cY + cHeight) {
      return true;
    } else return false;
  }

  void draw() {
    stroke(0, 0, 0, fade);
    strokeWeight(2);
    //fill(pColor, fade);
    //rect(x, y, size, size);
    playerAnimation();
  }
}

//if a number is below 0, it returns -1, and if its above, it returns 1. This is used to detect in witch direction the player goes
int sign(float v) {
  int vel = 0; 
  if (v < 0) vel = -1;
  else if (v > 0) vel = 1;

  return vel;
}

//Dash Blink////////////////////////////////////////

final int MAX_BLINK_AMOUNT = 10;
final int BLINK_FRAMERATE = 2; 

dashBlinks[] dashBlink;

void blinkSetup() {
  dashBlink = new dashBlinks[MAX_BLINK_AMOUNT];
  for (int iBlink = 0; iBlink < MAX_BLINK_AMOUNT; iBlink ++) {
    dashBlink[iBlink] = new dashBlinks();
  }
}

void blinkUpdate() {
  //adds new dash blink every given frame amount while the dash is active
  for (int iBlink = 0; iBlink < MAX_BLINK_AMOUNT; iBlink ++) {
    if (player.dashActive && !dashBlink[iBlink].isActive && player.dashTime % BLINK_FRAMERATE == 0) {
      dashBlink[iBlink].activate();
      break;
    }
  }

  for (int iBlink = 0; iBlink < MAX_BLINK_AMOUNT; iBlink ++) {
    if (dashBlink[iBlink].isActive) {
      dashBlink[iBlink].update();
    }
  }
}

void blinkDraw() {
  for (int iBlink = 0; iBlink < MAX_BLINK_AMOUNT; iBlink ++) {
    if (dashBlink[iBlink].isActive) {
      dashBlink[iBlink].draw();
    }
  }
}

class dashBlinks {
  final int DASH_BLINK_FADE_V = 20;

  int dashBlinkCooldown;
  boolean isActive, pointLeft;
  float x, y;

  dashBlinks() {
    reset();
  }

  void reset() {
    x = -globalScale * 10;
    y = -globalScale * 10;
    isActive = false;
  }

  void activate() {
    isActive = true;
    y = player.ySprite;
    dashBlinkCooldown = 255; //reset to full opacity

    //looks if the player was looking left or right so that the after image faces the right way
    if (player.moveLeft) {
      pointLeft = true;
      x = player.xSpriteL;
    } else {
      pointLeft = false;
      x = player.xSpriteR;
    }
  }

  void update() {
    dashBlinkCooldown -= DASH_BLINK_FADE_V;
    x -= globalScrollSpeed;
    y += globalVerticalSpeed;

    //deactivates the afterimage once its invisible
    if (dashBlinkCooldown < 0) {
      reset();
    }
  }

  void draw() {
    tint(255, dashBlinkCooldown); //makes the after image transparent

    //makes dash blink point in right direction
    if (pointLeft) {
      pushMatrix();
      scale(-1.0, 1.0);
      image(playerDashBlink, -x-playerDashBlink.width, y);
      popMatrix();
    } else {
      image(playerDashBlink, x, y);
    }
    tint(255);
  }
}
