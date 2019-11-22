//Mats
int activeBlocks = 0;
class Block {
  float x, y, size, speed = globalScale/30, vx = 0, scrollSpeed = -1;
  int id = -1;
  color c = BRICK;
  boolean active = false, moving = false, scrollPercentage = false;
  void blockSetup(float ix, float iy, color ic, boolean iMoving, boolean iScrollPercentage, float iScrollSpeed) {
    x = ix;
    y = iy;
    size = globalScale;
    c = ic;
    moving = iMoving;
    vx = speed;
    active = true;
    scrollPercentage = iScrollPercentage;
    scrollSpeed = iScrollSpeed;
  }
  Block() {
    blockSetup(0, 0, BRICK, false, scrollPercentage, scrollSpeed);
    active = false;
  }
  void update() {
    if (scrollSpeed >= 0 && x < width){
      if (scrollPercentage){
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
      if (c == BRICK) {
        image(brickSprite, x, y);
      } else if (c == STONE) {
        image(stoneSprite, x, y);
      } else if (c == DIRT) {
        if (blockCollision(x+1, y-globalScale+1, 5, id) != null) {
          image(dirtSprite, x, y);
        } else {
          image(grassSprite, x, y);
        }
      } else if (c == ICE) {
        image(iceSprite, x, y);
      } else {
        fill(c);
        stroke(0);
        rect(x, y, size, size);
      }
    }
  }
}
//Lijst met blocks
Block[] blocks = new Block[500];
//Loops through all the blocks to see if there is one at the given position
Block blockCollision(float x, float y, float size, float blockId) {
  Block Collision = null;

  for (int i = 0; i < blocks.length; i++) {
    if (blocks[i].x < x+size && blocks[i].x+size > x && blocks[i].y < y+size && blocks[i].y+size > y && blocks[i].active) {
      if (blocks[i].id != blockId) Collision = blocks[i];
    }
  }
  return Collision;
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
  int index = -1;
  for (int i = blocks.length-1; i > 0; i--) {
    if (blocks[i].active == false) {
      index = i;
    }
  }
  if (index == -1) {
    println("ERROR MAX ACTIVE BLOCKS REACHED");
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
