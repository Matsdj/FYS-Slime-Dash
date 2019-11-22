
final int ARROW_AMOUNT = 50;

void arrowSetup() {
  ArrowList = new Arrow[ARROW_AMOUNT];
  
  for (int iArrow = 0; iArrow < ARROW_AMOUNT; iArrow++) {
    ArrowList[iArrow] = new Arrow();
  }
}

void arrowUpdate() {
  for(int iArrow = 0; iArrow < ARROW_AMOUNT; iArrow++) {
    if(!ArrowList[iArrow].isActive) {
      ArrowList[iArrow].update();
    }
  }
}

Arrow[] ArrowList;

class Arrow {
  float x, y, aWidth, aHeight;
  boolean isActive, isHit = false;
  
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
    if(player.Collision(x, y, aWidth)) {
      isHit = true;
    }
    for(int iHostile = 0; iHostile < 10; iHostile++) {
      if(hostileRanged[iHostile].x < player.x) {
        x += globalScale * 2;
      } else if(hostileRanged[iHostile].x > player.x) {
        x -= globalScale * 2;
      }
    }
  }
  
  void draw() {
    rect(x, y, aWidth, aHeight);
  }
}
