//Mats
class Block {
  float x, y, hSize, vSize;
  color c = color(255);
  Block(float ix, float iy, color ic) {
    x = ix;
    y = iy;
    c = ic;
    hSize = globalScale;
    vSize = globalScale;
  }
  void draw() {
    fill(c);
    rect(x, y, hSize, vSize);
  }
}
//Lijst met blocks
ArrayList<Block> blocks = new ArrayList();
