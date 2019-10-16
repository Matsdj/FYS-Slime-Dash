//Mats
class Block {
  float x, y, size;
  color c = color(150,150,150);
  Block(float ix, float iy) {
    x = ix;
    y = iy;
    size = globalScale;
  }
  void draw() {
    fill(c);
    stroke(0);
    rect(x, y, size, size);
  }
}
//Lijst met blocks
ArrayList<Block> blocks = new ArrayList();
//Loops through all the blocks to see if there is on at the given position
Block blockCollision(float x, float y, float size) {
  Block Collision = null;
  for (int blockNumber = 0; blockNumber < blocks.size(); blockNumber++) {
    if (blocks.get(blockNumber).x < x+size && blocks.get(blockNumber).x+size > x && blocks.get(blockNumber).y < y+size && blocks.get(blockNumber).y+size > y) {
      Collision = blocks.get(blockNumber);
    }
  }
  return Collision;
}
//Block Reset
void blockSetup(){
  blocks.clear();
}
//block Update
void blockUpdate() {
  //loopt door de lijst en beweegt elke block
  for (int n = 0; n<blocks.size(); n++) {
    Block block = blocks.get(n);
    block.x -= globalScrollSpeed;
    if (block.x < -globalScale*4-block.size){
      blocks.remove(n);
      n--;
    }
  }
}
//block draw
void blockDraw() {
  //loopt door de lijst en tekent elke block
  for (int n = 0; n<blocks.size(); n++) {
    Block block = blocks.get(n);
    block.draw();
    rect(block.x, block.y, globalScale, globalScale);
  }
}
