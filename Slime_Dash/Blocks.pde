//Mats
int activeBlocks = 0;
int backgroundBlocks = 0;
class Block {
  final float BREAK_TIME_MAX = 10;
  float x, y, size, speed = globalScale/30, vx = 0, scrollSpeedChange = -1, breakTime = BREAK_TIME_MAX;
  int id = -1;
  color c = BRICK;
  PImage sprite;
  boolean active = false, moving = false, scrollPercentage = false, cracked = false, enableVerticalMovement = false;
  void blockSetup(float ix, float iy, color ic, boolean iMoving, boolean iScrollPercentage, float iScrollSpeedChange, boolean iCracked, boolean iAllowVertical) {
    x = ix;
    y = iy;
    size = globalScale;
    c = ic;
    moving = iMoving;
    vx = speed;
    active = true;
    scrollPercentage = iScrollPercentage;
    scrollSpeedChange = iScrollSpeedChange;
    cracked = iCracked;
    breakTime = BREAK_TIME_MAX;
    enableVerticalMovement = iAllowVertical;
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
    blockSetup(0, 0, BRICK, moving, scrollPercentage, scrollSpeedChange, cracked, allowVerticalMovement);
    active = false;
  }
  void update() {
    y += globalVerticalSpeed;
    if (scrollSpeedChange >= 0 && x < width) {
      if (scrollPercentage) {
        globalScrollSpeed = globalScrollSpeed*(scrollSpeedChange/100);
      } else {
        globalScrollSpeed = scrollSpeedChange;
      }
    }
    if (x > -globalScale) {
      x -= globalScrollSpeed;
    }
    if (x < width) {
      //Cracked break under player
      if (cracked && (x < player.x+globalScale && x+globalScale > player.x && y-1 < player.y+globalScale && y > player.y)) {
        breakTime--;
        if (breakTime < 0) {
          active = false;
          createParticle(x, y, 10, color(100), color(200), 0.2, 5, 100);
        }
      }
      //Cracked break because of dash
      if (cracked && player.dashActive && player.Collision(x, y+1, size-1)) {
        active = false;
        breakTime = 0;
        createParticle(x, y, 10, color(100), color(200), 0.2, 5, 100);
      }
      //Allow Vertical Movement
      if (enableVerticalMovement) {
        allowVerticalMovement = enableVerticalMovement;
      }
    }
    //Push away player
    //pushAwayPlayer();
  }
  void moving() {
    if (blockCollision(x+vx, y, size, id) != null) {
      vx *= -1;
    }
    x += vx;
  }
  void draw() {
    if (x < width && c != ALLOW_VERTICAL_MOVEMENT) {
      if (c == DIRT) {
        if (blockCollision(x+size/2, y-size/2, 1, id) == null) {
          sprite = grassSprite;
        } else {
          sprite = dirtSprite;
        }
      }
      image(sprite, x, y);
      if (cracked) {
        tint(255, ((BREAK_TIME_MAX-breakTime)/BREAK_TIME_MAX)*155+100);
        image(crackedSprite, x, y);
        tint(255);
      }
    }
  }
  void drawBackgroundBlocks() {
    float hitbox = 1, 
      xScroll = x+size/2;
    for (float i = y+globalScale; ((blockCollision(xScroll, i, hitbox, id) == null || blockCollision(xScroll, i, hitbox, id).moving || blockCollision(xScroll, i, hitbox, id).cracked) && i < height); i+= globalScale) {
      tint(100);
      if (sprite == grassSprite) {
        image(dirtSprite, x, i);
      } else
        image(sprite, x, i);
      tint(255);
      backgroundBlocks +=1;
    }
  }
  void pushAwayPlayer() {
    if (dist(x+size/2, y+size/2, player.x+player.size/2, player.y+player.size/2) < size*2) {
      float Cx = player.x-x;
      float Cy = player.y-y;
      float a = atan2(Cx, Cy);
      while (player.Collision(x+4, y, size-8)) {
        player.x += sin(a)/2;
        player.y += cos(a)/2;
      }
    }
  }
}
//Lijst met blocks
Block[] blocks = new Block[1000];
//Loops through all the blocks to see if there is one at the given position
Block blockCollision(float x, float y, float size, float blockId) {
  Block Collision = null;

  for (int i = 0; i < blocks.length; i++) {
    if ((blocks[i].x < x+size && blocks[i].x+blocks[i].size > x && blocks[i].y < y+size && blocks[i].y+blocks[i].size > y) && blocks[i].active && blocks[i].id != blockId) {
      Collision = blocks[i];
    }
  }
  return Collision;
}
//als je geen blockId invult default het naar -1
Block blockCollision(float x, float y, float size) {
  return blockCollision(x, y, size, -1);
}
//Disables scrollBlocks
void disableActiveScrollBlocks() {
  for (int i = 0; i<blocks.length; i++) {
    if (blocks[i].active && blocks[i].scrollSpeedChange >= 0 && blocks[i].x < width) {
      blocks[i].scrollSpeedChange = -1;
    }
  }
}
//Block Setup
void blockSetup() {
  for (int i = 0; i < blocks.length; i++) {
    blocks[i] = new Block();
  }
}
//Free Block Index
int freeBlockIndex() {
  int index = -1;
  for (int i = blocks.length-1; i > 0; i--) {
    if (blocks[i].active == false) {
      index = i;
    }
  }
  if (index == -1) {
    println("ERROR MAX("+blocks.length+")ACTIVE BLOCKS REACHED");
    index = blocks.length-1;
  }
  return index;
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
    //Removes the block when it is 1 block outside the screen
    if (blocks[i].active && blocks[i].x <= -globalScale) {
      blocks[i].active = false;
    }
  }
  //loopt door de lijst en beweegt elke moving block
  for (int i = 0; i<blocks.length; i++) {
    if (blocks[i].moving && blocks[i].x < width) {
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
    if (blocks[i].active &! blocks[i].moving) {
      blocks[i].drawBackgroundBlocks();
    }
  }
}
