//Mats
final color ICECOLOR = color(0, 255, 255);
final color BLOCKCOLOR = color(150);
PImage brickSprite;
int activeBlocks = 0;
class Block {
  float x, y, size, speed = globalScale/30, vx = 0, id = -1;
  color c = BLOCKCOLOR;
  boolean active = false, moving = false;
  void blockSetup(float ix, float iy, color ic, boolean iMoving) {
    x = ix;
    y = iy;
    size = globalScale;
    c = ic;
    moving = iMoving;
    vx = speed;
    active = true;
  }
  Block() {
    blockSetup(0, 0, BLOCKCOLOR, false);
    active = false;
  }
  void update() {
    x -= globalScrollSpeed;
  }
  void moving() {
    if (moving == true && x < width) {
      if (blockCollision(x+vx, y, size, id) != null) {
        vx *= -1;
      }
      x += vx;
    }
  }
  void draw() {
    if (x < width) {
      if (c == BLOCKCOLOR) {
        image(brickSprite, x, y, size, size);
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
  for (int blockNumber = 0; blockNumber < blocks.length; blockNumber++) {
    if (blocks[blockNumber].x < x+size && blocks[blockNumber].x+size > x && blocks[blockNumber].y < y+size && blocks[blockNumber].y+size > y) {
      if (blocks[blockNumber].id != blockId) Collision = blocks[blockNumber];
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
  brickSprite = loadImage("sprites/blocks/brick.png");
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
    if (blocks[i].active == true) {
      activeBlocks++;
    }
    blocks[i].id = i;
    blocks[i].update();
    //Removes the block when it is 4 blocks outside the screen
    if (blocks[i].x < -globalScale*4-blocks[i].size) {
      blocks[i].active = false;
    }
  }
  //loopt door de lijst en beweegt elke moving block
  for (int i = 0; i<blocks.length; i++) {
    blocks[i].moving();
  }
}
//block draw
void blockDraw() {
  //loopt door de lijst en tekent elke block
  for (int i = 0; i<blocks.length; i++) {
    blocks[i].draw();
  }
}
