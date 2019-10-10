//Mats
class Block {
  float x, y, size;
  color c = color(255);
  Block(float ix, float iy) {
    x = ix;
    y = iy;
    size = globalScale;
  }
  void draw() {
    fill(c);
    rect(x, y, size, size);
  }
}
//Lijst met blocks
ArrayList<Block> blocks = new ArrayList();
boolean blockCollision(float x, float y, float size) {
  boolean Collision = false;
  for (int blockNumber = 0; blockNumber < blocks.size(); blockNumber++) {
    if (blocks.get(blockNumber).x < x+size && blocks.get(blockNumber).x+size > x && blocks.get(blockNumber).y < y+size && blocks.get(blockNumber).y+size > y) {
      Collision = true;
    }
  }
  return Collision;
}
//block draw
void blockUpdate() {
  //loopt door de lijst en tekent elke block
  for (int n = 0; n<blocks.size(); n++) {
    Block block = blocks.get(n);
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
