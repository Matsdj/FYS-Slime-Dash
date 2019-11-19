
final int ARROW_AMOUNT = 50;

void arrowSetup() {
  ArrowList = new Arrow[ARROW_AMOUNT];
  
  for (int iArrow = 0; iArrow < ARROW_AMOUNT; iArrow++) {
    ArrowList[iArrow] = new Arrow();
  }
}

Arrow[] ArrowList;

class Arrow {
  float x, y, aWidth, aHeight;
  boolean isActive;
  
  Arrow() {
    aWidth = 3;
    aHeight = 2;
    reset();
  }
  
  void reset() {
    isActive = false;
    x = -globalScale *10;
    y = -globalScale *10;
  }

  void activate(float activatex, float activatey) {
    isActive = true;
    x = activatex;
    y = activatey;
  }
  
  void update() {
    x -= globalScale;
  }
  
  void draw() {
    rect(x, y, aWidth, aHeight);
  }
}
