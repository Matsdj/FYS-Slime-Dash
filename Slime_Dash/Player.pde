//Chris (met een beetje hulp van mats)

final int PLAYER_FRAME_AMOUNT = 11;
void playerSetup() {
  player = new Player();
}

Player player;
class Player {
  float size, x, y, hitX, hitY, hitSize, hitboxRatio, moveSpeed, vx, vy, 
    dashSpeed, dashTime, slowDown, movingBlockSpeed, ySprite, xSpriteL, xSpriteR, parSize, 
    parGrav, parSpeed, jumpedHeight, spriteWidth, spriteHeight;

  int dashCooldown, dashCooldownMax, maxJumpAmount, dmgCooldown, keyUp, frameCounter, deathFramerate, jumpedAmount;
  boolean moving, dashActive, enemyDamage, moveLeft, dmgBlink, smashedGround, onGround;

  //terugzet waardes van de dashCooldown en dashTime
  final int DASH_COOLDOWN_CHARGE = 100;
  final int DASH_COOLDOWN_START = DASH_COOLDOWN_CHARGE * 3;
  final int DASH_TIME = 8;
  final int DMG_COOLDOWN = 30;
  final int ANIMATION_FRAMERATE = 10;
  final int PLAYER_WALK_FRAME_AMOUNT = 4;
  final int PLAYER_DEATH_FRAME_MAX = 10;
  final int DMG_BLINK_FRAMERATE = 6;

  final float JUMPSPEED = globalScale/3.5; //jump force
  final float MAX_JUMP_HEIGHT = globalScale * 3;
  final float DASHSPEED = globalScale/1.6; //dash speed
  final float MOVESPEED = globalScale/16; //starting speed
  final float SPEEDMULT = 1.9;
  final float SPEEDSLOWDOWN = 0.85; //slowdown rate on normal ground
  final float ICESLOWDOWN = 0.98; //this is the slowdown of the player if he walks on ice
  final float MAXMOVESPEED = globalScale/8; //max player walking speed
  final float GRAVITY = globalScale/42; //speed at witch player falls
  final float MAX_VY = globalScale/2;

  Player() {
    jumpedHeight = -MAX_JUMP_HEIGHT;
    deathFramerate = 0;
    size = globalScale-1;
    x = globalScale * 4; //spawn cords
    y = globalScale * 2;
    hitboxRatio = 4;  //size of the hitbox is defined by this
    hitSize = size - size/hitboxRatio;
    moveSpeed = MOVESPEED;
    slowDown = SPEEDSLOWDOWN;
    vx = 0;
    vy = 0;
    dashCooldownMax = DASH_COOLDOWN_START; //change this to upgrade dash cooldown
    dashCooldown = 0;
    dashTime = DASH_TIME;
    dmgCooldown = 0;
    enemyDamage = false;
    moveLeft = false;
    frameCounter = 0;
    deathFramerate = 0;
    maxJumpAmount = 0; // +1 this to activate dubble jump;
    jumpedAmount = 0;
    smashedGround = false;
    parSize = globalScale / 7;
    parGrav = globalScale/256;
    parSpeed = globalScale/18;
  }

  //player animation is done in this function. It looks if the player is looking left or right, and looks what action the player is doing. Push matrix and pop matrix statements are there for mirroring player sprites
  void playerAnimation() {
    ySprite = y - pushPlayerSpriteUp;
    xSpriteL = x - pushPlayerSpriteL;
    xSpriteR = x - pushPlayerSpriteR;

    //switches between dmg sprites, causing a blink effect
    if (burn || dmgCooldown > 0) {
      if (dmgCooldown % (DMG_BLINK_FRAMERATE*2) == 0) {
        dmgBlink = true;
      } else if (dmgCooldown % DMG_BLINK_FRAMERATE == 0) {
        dmgBlink = false;
      }
    } else dmgBlink = true;

    //dash animation
    if (dashActive) {
      frameCounter = 5;
    }

    //death animatie
    else if (interfaces.death) {
      deathFramerate++;
      if (deathFramerate % ANIMATION_FRAMERATE==0 && frameCounter != PLAYER_DEATH_FRAME_MAX-1) {
        frameCounter++;
      }
      if (frameCounter < 7 || frameCounter > 9) {
        frameCounter = 6;
      }
    }

    //damaged animatie
    else if (burn || dmgCooldown >=0) {
      //makes player blink white when damaged
      if (!dmgBlink) {
        frameCounter = 6;
      } else if (dmgBlink) {
        frameCounter = 10;
      }
    }

    //jump animation
    else if (vy != 0) {
      frameCounter = 4;
    }

    //walking animatie
    else if (moving && inputs.hasValue(LEFT) == true || inputs.hasValue(RIGHT) == true) {
      if (frameCount % ANIMATION_FRAMERATE == 0) {
        frameCounter++;
      }
      if (frameCounter >= PLAYER_WALK_FRAME_AMOUNT) {
        frameCounter = 0;
      }
    }

    //stand still animatie
    else if (!moving) {
      frameCounter = 0;
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

  void playerTween() {
    final float MAX_TWEEN = globalScale / 5;
    float xTween, yTween;

    yTween = pow(vy, 2)/20;

    if (yTween > MAX_TWEEN) {
      yTween = MAX_TWEEN;
    }

    xTween = -yTween;
    spriteWidth = playerSpriteWidth + xTween;
    spriteHeight = playerSpriteHeight + yTween;

    xSpriteR += xTween;
    xSpriteL += xTween;
    ySprite -= yTween;
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

    dashCooldown ++;
    if (dashCooldown > dashCooldownMax) {
      dashCooldown = dashCooldownMax;
    }
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

      //jump mechanics
      if (jumpedHeight > -MAX_JUMP_HEIGHT && keyUp == 1) {
        vy = keyUp * -JUMPSPEED;
        jumpedHeight += vy;
      } else if (inputsPressed.hasValue(UP) == true && jumpedAmount < maxJumpAmount) {
        jumpedHeight = 0;
        jumpedAmount ++;
      } else {
        jumpedHeight = -MAX_JUMP_HEIGHT;
      }

      //Dash abilty
      if (inputsPressed.hasValue(90) == true && dashCooldown > DASH_COOLDOWN_CHARGE || dashActive && dashTime > 0) {
        if (DashSlime.isPlaying() ==false) {
          DashSlime.rate(random(0.8, 1.2));
          DashSlime.play();
        }

        //looks if you are moving right or left
        if (moveLeft) {
          vx = -DASHSPEED;
        }
        if (!moveLeft) {
          vx = DASHSPEED;
        }

        if (!dashActive)
          dashCooldown -= DASH_COOLDOWN_CHARGE;

        dashActive = true;
        dashTime -= speedModifier;

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

    if (vy > MAX_VY) {
      vy = MAX_VY;
    }

    ///////Collisions/////////////////////

    //Horizontal collision
    //when theres collision going to happen next frame, the player will be placed next to the block because of the while statement
    if (blockCollision(x+vx, y, size) != null) {
      while (blockCollision(x+sign(vx), y, size) == null) {
        x += sign(vx);
      }
      vx = 0;
    } else if (room == "game2" && x+vx <= 0) {
      while (x + sign(vx) > 0) {
        x += sign(vx);
      }
      vx = 0;
    }

    if (!interfaces.death) {
      x+= vx*speedModifier;
    }
    //Vertical collision
    //works like horizontal collision, only now with vy
    if (blockCollision(x, y+vy, size) != null) {
      while (blockCollision(x, y+sign(vy), size) == null) {
        y += sign(vy);
      }
      if (vy > 0) {
        onGround = true;
        jumpedHeight = 0;
        jumpedAmount = 0;
      }
      //ground smash effect
      if (onGround && smashedGround) {
        smashedGround = false;
        createParticle(x + size/2, y + size/2, parSize, color(#FF9455), color(#FF5555), parGrav, parSpeed, true, "", vy/3);
      }
      vy = 0;
      slowDown = SPEEDSLOWDOWN;
    } else {
      onGround = false;
      smashedGround = true;
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

    playerTween();
  }

  //method that checks if there is player collision (used for pickups)
  boolean Collision(float cX, float cY, float cSize) {
    if (x + size >= cX && x <= cX + cSize && y + size >= cY && y <= cY + cSize) {
      return true;
    } else return false;
  }

  //same method, only here the smaller hitbox is used for enemies and obstacles
  boolean hitboxCollision(float cX, float cY, float cWidth, float cHeight) {
    //hitbox follows the player. The size of the hitbox depends on the hitboxRatio
    hitX = x + size/(hitboxRatio*2);
    hitY = y + size/(hitboxRatio*2);

    if (hitX + hitSize >= cX && hitX <= cX + cWidth && hitY + hitSize >= cY && hitY <= cY + cHeight) {
      return true;
    } else return false;
  }

  void draw() {
    playerAnimation();
    if (moveLeft) {
      pushMatrix();
      scale(-1.0, 1.0);
      image(playerSprite[frameCounter], -xSpriteL-playerSprite[0].width, ySprite, spriteWidth, spriteHeight);
      if (hasCrown)
        image(crownSprite, -xSpriteL-playerSprite[0].width, ySprite - crownOffset, spriteWidth, spriteHeight);
      popMatrix();
    } else if (!moveLeft) {
      image(playerSprite[frameCounter], xSpriteR, ySprite, spriteWidth, spriteHeight);
      if (hasCrown)
        image(crownSprite, xSpriteR, ySprite - crownOffset, spriteWidth, spriteHeight);
    }
  }
}

//Dash Blink////////////////////////////////////////

final int MAX_BLINK_AMOUNT = 15;
final int BLINK_FRAMERATE = 2;
final int WALK_BLINK_FRAMERATE = 3;

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
    if (((player.dashActive && player.dashTime % BLINK_FRAMERATE == 0) || (player.dashCooldown > player.DASH_COOLDOWN_CHARGE && frameCount % WALK_BLINK_FRAMERATE == 0)) && !dashBlink[iBlink].isActive && !interfaces.death) {
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
  final int DASH_BLINK_FADE_V = 15;
  final int WALK_BLINK_FADE_V = 30;

  int dashBlinkCooldown, walkFrame;
  boolean isActive, pointLeft, isDashing;
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
    walkFrame = player.frameCounter;
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

    if (player.dashActive) {
      isDashing = true;
    } else
      isDashing = false;
  }

  void update() {
    if (isDashing) {
      dashBlinkCooldown -= DASH_BLINK_FADE_V;
    } else
      dashBlinkCooldown -= WALK_BLINK_FADE_V;

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
      if (isDashing) {
        image(playerDashBlink, -x-playerDashBlink.width, y);
      } else
        image(playerBlinkSprite[walkFrame], -x-playerWalkBlink.width, y);
      popMatrix();
    } else {
      if (isDashing) {
        image(playerDashBlink, x, y);
      } else
        image(playerBlinkSprite[walkFrame], x, y);
    }
    tint(255);
  }
}

//if a number is below 0, it returns -1, and if its above, it returns 1. This is used to detect in witch direction the player goes
int sign(float v) {
  int vel = 0;
  if (v < 0) vel = -1;
  else if (v > 0) vel = 1;

  return vel;
}
