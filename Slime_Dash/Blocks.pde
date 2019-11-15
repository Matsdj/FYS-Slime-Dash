//Mats
final color ICECOLOR = color(0, 255, 255);
final color BLOCKCOLOR = color(150);
PImage brickSprite;
class Block {
  float x, y, size, speed = globalScale/30, vx = 0, id = -1;
  color c = BLOCKCOLOR;
  boolean moving = false;
  void blockSetup(float ix, float iy, color ic, boolean iMoving) {
    x = ix;
    y = iy;
    size = globalScale;
    c = ic;
    moving = iMoving;
    vx = speed;
  }
  //X and Y
  Block(float ix, float iy) {
    blockSetup(ix, iy, c, moving);
  }
  //X, Y and color
  Block(float ix, float iy, color ic) {
    blockSetup(ix, iy, ic, moving);
  }
  //X, Y and moving
  Block(float ix, float iy, boolean iMoving) {
    blockSetup(ix, iy, c, iMoving);
  }
  //X, Y, color and moving
  Block(float ix, float iy, color ic, boolean iMoving) {
    blockSetup(ix, iy, ic, iMoving);
  }
  void update() {
    x -= globalScrollSpeed;
  }
  void moving() {
    if (moving == true) {
      if (blockCollision(x+vx, y, size, id) != null) {
        vx *= -1;
      }
      x += vx;
    }
  }
  void draw() {
    if (c == BLOCKCOLOR) {
      image(brickSprite,x,y,size,size);
    } else {
    fill(c);
    stroke(0);
    rect(x, y, size, size);
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
//Block Reset
void blockSetup() {
  blocks.clear();
  brickSprite = loadImage("sprites/blocks/brick.png");
}
//block Update
void blockUpdate() {
  //loopt door de lijst en beweegt elke block
  for (int n = 0; n<blocks.size(); n++) {
    Block block = blocks.get(n);
    block.id = n;
    block.update();
    //Removes the block when it is 4 blocks outside the screen
    if (block.x < -globalScale*4-block.size) {
      blocks.remove(n);
      n--;
    }
  }
  //loopt door de lijst en beweegt elke moving block
  for (int n = 0; n<blocks.size(); n++) {
    blocks.get(n).moving();
  }
}
//block draw
void blockDraw() {
  //loopt door de lijst en tekent elke block
  for (int n = 0; n<blocks.size(); n++) {
    Block block = blocks.get(n);
    block.draw();
  }
}
