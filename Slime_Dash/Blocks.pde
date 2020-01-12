//Mats
int activeBlocks = 0;
int backgroundBlocks = 0;
final color CRACKED_BLOCK_PARTICLE_COLOR_LIGHT = color(100);
final color CRACKED_BLOCK_PARTICLE_COLOR_DARK = color(200);
class Block {
  final int BREAK_TIME_MAX = 10, 
    BREAK_PARTICLE_COUNT = 100;

  float x, y, size, speed = globalScale/30, vx = speed, breakTime = BREAK_TIME_MAX, centerX, centerY;
  int id = -1;
  float deletedAt = -globalScale*10;
  color c = BRICK;
  PImage sprite;
  boolean active = false, moving = false, cracked = false, enableVerticalMovement = false;
  void blockSetup(float enteredValueX, float enteredValueY, color enteredValueC, boolean enteredValueMoving, boolean enteredValueCracked, boolean enteredValueAllowVertical) {
    x = enteredValueX;
    y = enteredValueY;
    size = globalScale;
    c = enteredValueC;
    moving = enteredValueMoving;
    active = true;
    cracked = enteredValueCracked;
    breakTime = BREAK_TIME_MAX;
    enableVerticalMovement = enteredValueAllowVertical;
    if (c == BRICK) {
      sprite = brickSprite;
    } else if (c == STONE) {
      sprite = stoneSprite;
    } else if (c == ICE) {
      sprite = iceSprite;
    } else if (c == PLANKS) {
      sprite = plankSprite;
    } else {
      sprite = stoneSprite;
    }
  }
  Block() {
    blockSetup(0, 0, BRICK, moving, cracked, allowVerticalMovement);
    active = false;
  }
  void update() {
    centerX = x+size/2;
    centerY = y+size/2;
    if (x < width) {
      if (cracked) {
        //Cracked break under player
        if (player.Collision(x+1, y-1, size-2)) {
          breakTime--;
          if (breakTime < 0) {
            active = false;
            Thud.play();
          }
        }
        //Cracked break because of dash
        if (player.dashActive && player.Collision(x-1, y+1, size+2)) {
          active = false;
        }
        //break because of jump
        if (player.vy < -10 && player.Collision(x+1, y-player.vy, size-2)) {
          active = false;
          player.jumpedHeight = -player.MAX_JUMP_HEIGHT;
          player.vy = 0;
          Thud.play();
        }
        if (active == false) {
          createParticle(centerX, centerY, size, PARTICLE_SIZE, CRACKED_BLOCK_PARTICLE_COLOR_LIGHT, CRACKED_BLOCK_PARTICLE_COLOR_DARK, PARTICLE_GRAVITY, PARTICLE_SPEED, true, PARTICLE_LIFE, NO_TEXT, BREAK_PARTICLE_COUNT);
          blockBreakCount++;
        }
      }
      //Allow Vertical Movement
      if (enableVerticalMovement) {
        allowVerticalMovement = true;
      }
    }
    pushAwayPlayer();
    //Move block
    y += globalVerticalSpeed;
    x -= globalScrollSpeed;
  }

  void moving() {
    if (blockCollision(x+vx, y, size, id) != null) {
      vx *= -1;
    }
    x += vx*speedModifier;
  }
  void draw() {
    if (x < width && c != ALLOW_VERTICAL_MOVEMENT) {
      if (c == DIRT) {
        if (blockCollision(centerX, centerY-size, 1, id) == null) {
          sprite = grassSprite;
        } else {
          sprite = dirtSprite;
        }
      }
      image(sprite, x+shake, y);
      if (cracked) {
        tint(255, ((BREAK_TIME_MAX-breakTime)/BREAK_TIME_MAX)*155+100);
        image(crackedSprite, x+shake, y);
        tint(255);
      }
    }
  }
  void drawBackgroundBlocks() {
    float hitbox = 1;
    for (float backgroundY = y+size; ((blockCollision(centerX, backgroundY, hitbox, id) == null || blockCollision(centerX, backgroundY, hitbox, id).moving) && backgroundY < height); backgroundY+= globalScale) {
      tint(100);
      if (sprite == grassSprite) {
        image(dirtSprite, x+shake, backgroundY);
      } else
        image(sprite, x+shake, backgroundY);
      tint(255);
      backgroundBlocks +=1;
    }
  }
  void pushAwayPlayer() {
    float centerX = x+size/2, 
      centerY = y+size/2, 
      playerCenterX = player.x+player.size/2, 
      playerCenterY = player.y+player.size/2;
    if (dist(centerX, centerY, playerCenterX, playerCenterY) < globalScale*PI/2) {
      float Cx = player.x-x;
      float Cy = player.y-y;
      float a = atan2(Cx, Cy);
      while (player.Collision(x, y, size)) {
        player.x += sin(a);
        player.y += cos(a);
      }
    }
  }
}
//Lijst met blocks
Block[] blocks = new Block[1000];
//Loops through all the blocks to see if there is one at the given position
Block blockCollision(float x, float y, float size, float blockId) {
  for (int i = 0; i < blocks.length; i++) {
    if ((blocks[i].x < x+size && blocks[i].x+blocks[i].size > x && blocks[i].y < y+size && blocks[i].y+blocks[i].size > y) && blocks[i].active && blocks[i].id != blockId) {
      return blocks[i];
    }
  }
  return null;
}
//als je geen blockId invult default het naar -1
Block blockCollision(float x, float y, float size) {
  return blockCollision(x, y, size, -1);
}
//Block Setup
void blockSetup() {
  for (int i = 0; i < blocks.length; i++) {
    blocks[i] = new Block();
  }
}
//Free Block Index
int freeBlockIndex() {
  for (int i = 0; i < blocks.length; i++) {
    if (blocks[i].active == false) {
      return i;
    }
  }
  println("ERROR MAX("+blocks.length+")ACTIVE BLOCKS REACHED");
  return blocks.length-1;
}
//block Update
void blockUpdate() {
  activeBlocks = 0;
  //loopt door de lijst en beweegt elke block
  for (int i = 0; i<blocks.length; i++) {
    if (blocks[i].active) {
      activeBlocks++;
      blocks[i].update();
    }
    if (blocks[i].id != i) {
      blocks[i].id = i;
    }
    //Removes the block when it is 10 blocks outside the screen
    if (blocks[i].active && blocks[i].x <= blocks[i].deletedAt) {
      blocks[i].active = false;
    }
  }
  //loopt door de lijst en beweegt elke moving block
  for (int i = 0; i<blocks.length; i++) {
    if (blocks[i].moving) {
      blocks[i].moving();
    }
  }
}
//block draw
void blockDraw() {
  //loopt door de lijst en tekent elke block
  for (int i = 0; i<blocks.length; i++) {
    if (blocks[i].active) {
      blocks[i].draw();
    }
  }
}
void drawBackgroundBlocks() {
  backgroundBlocks = 0;
  //loopt door de lijst en tekent elk achtergrond block
  for (int i = 0; i<blocks.length; i++) {
    if (blocks[i].active &! (blocks[i].moving)) {
      blocks[i].drawBackgroundBlocks();
    }
  }
}
