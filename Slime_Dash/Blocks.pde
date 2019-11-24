//Mats
int activeBlocks = 0;
int backgroundBlocks = 0;
class Block {
  float x, y, baseY, size, speed = globalScale/30, vx = 0, scrollSpeed = -1;
  int id = -1;
  color c = BRICK;
  PImage sprite;
  boolean active = false, moving = false, scrollPercentage = false;
  void blockSetup(float ix, float iy, color ic, boolean iMoving, boolean iScrollPercentage, float iScrollSpeed) {
    x = ix;
    baseY = iy;
    y = baseY;
    size = globalScale;
    c = ic;
    moving = iMoving;
    vx = speed;
    active = true;
    scrollPercentage = iScrollPercentage;
    scrollSpeed = iScrollSpeed;
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
    blockSetup(0, 0, BRICK, false, scrollPercentage, scrollSpeed);
    active = false;
  }
  void update() {
    y = baseY + globalVerticalDistance;
    if (scrollSpeed >= 0 && x < width) {
      if (scrollPercentage) {
        globalScrollSpeed = globalScrollSpeed*(scrollSpeed/100);
      } else {
        globalScrollSpeed = scrollSpeed;
      }
    }
    if (x > -globalScale) {
      x -= globalScrollSpeed;
    }
  }
  void moving() {
    if (blockCollision(x+vx, y, size, id) != null) {
      vx *= -1;
    }
    x += vx;
  }
  void draw() {
    if (x < width) {
      if (c == DIRT) {
        if (blockCollision(x+globalScrollSpeed, y-size, size-globalScrollSpeed*2, id) != null) {
          sprite = dirtSprite;
        } else {
          sprite = grassSprite;
        }
      }
      image(sprite, x, y);
    }
  }
  void drawBackgroundBlocks() {
    float hitbox = size-globalScrollSpeed*2,
      xScroll = x+globalScrollSpeed+1;
    for (int i = round(y/globalScale)+1; ((blockCollision(xScroll, i*globalScale, hitbox, id) == null || blockCollision(xScroll, i*globalScale, hitbox, id).moving) && i*globalScale < height); i++) {
      tint(100);
      if (sprite == grassSprite) {
        image(dirtSprite, x, i*globalScale);
      } else
        image(sprite, x, i*globalScale);
      tint(255);
      backgroundBlocks +=1;
    }
  }
}
//Lijst met blocks
Block[] blocks = new Block[500];
//Loops through all the blocks to see if there is one at the given position
Block blockCollision(float x, float y, float size, float blockId) {
  Block Collision = null;

  for (int i = 0; i < blocks.length; i++) {
    if ((blocks[i].x < x+size && blocks[i].x+size > x && blocks[i].y < y+size && blocks[i].y+size > y) && blocks[i].active && blocks[i].id != blockId) {
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
    if (blocks[i].active && blocks[i].scrollSpeed >= 0 && blocks[i].x < width) {
      blocks[i].scrollSpeed = -1;
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
    index = blocks.length;
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
