//Hier maak ik de tijdelijke objecten aan
//Deze objecten hebben dus alleen een uiterlijk ze doen nog niks
class TempBlock {
  float x, y, hSize, vSize;
  color c = color(255);
  TempBlock(float ix, float iy, color ic) {
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
class TempSpike {
  float x, y, size;
  color c = color(255);
  TempSpike(float ix, float iy, color ic) {
    x = ix;
    y = iy;
    c = ic;
    size = globalScale;
  }
}
//hier maak ik de lijsten aan
ArrayList<TempBlock> tempBlocks = new ArrayList();
ArrayList<TempSpike> tempSpikes = new ArrayList();

int afgelegdeAfstand = 0;
//Temporary block draw
void tempBlockDraw() {
  for (int n = 0; n<tempBlocks.size(); n++) {
    TempBlock block = tempBlocks.get(n);
    block.draw();
    println(block);
    rect(block.x, block.y, globalScale, globalScale);
  }
}
//Makes a line of blocks at the bottom of the screen
void mapSetup() {
  for (int i = 0; i < width/globalScale; i++) {
    float x = globalScale*i, 
      y = height-globalScale;
    color c = color(255, 255, 255);
    tempBlocks.add(new TempBlock(x, y, c));
  }
}

void mapUpdate() {
  afgelegdeAfstand = floor(player.x/globalScale);
}
