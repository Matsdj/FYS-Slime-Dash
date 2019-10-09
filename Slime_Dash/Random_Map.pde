//Mats
//hier maak ik de lijsten aan
int afgelegdeAfstand = 0;
//Temporary block draw
void tempBlockDraw() {
  for (int n = 0; n<blocks.size(); n++) {
    Block block = blocks.get(n);
    block.draw();
    rect(block.x, block.y, globalScale, globalScale);
  }
}
//Makes a line of blocks at the bottom of the screen
void mapSetup() {
  for (int i = 0; i < width/globalScale; i++) {
    float x = globalScale*i, 
      y = height-globalScale;
    color c = color(255, 255, 255);
    blocks.add(new Block(x, y, c));
  }
}

void mapUpdate() {
  afgelegdeAfstand = floor(player.x/globalScale);
}
