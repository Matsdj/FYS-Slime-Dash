
final int ARROW_AMOUNT = 20;
final float ARROW_VELOCITY = 5;

void arrowSetup() {
  ArrowList = new Arrow[ARROW_AMOUNT];
  
  for (int iArrow = 0; iArrow < ARROW_AMOUNT; iArrow++) {
    ArrowList[iArrow] = new Arrow();
  }
}

void arrowUpdate() {
  for(int iArrow = 0; iArrow < ARROW_AMOUNT; iArrow++) {
    if(ArrowList[iArrow].isActive) {
      ArrowList[iArrow].update();
    }
  }
}

void arrowDraw() {
  for(int iArrow = 0; iArrow < ARROW_AMOUNT; iArrow++) {
    if(ArrowList[iArrow].isActive) {
      ArrowList[iArrow].draw();
    }
  }
}

Arrow[] ArrowList;

class Arrow {
  float x, y, vx, aWidth, aHeight;
  boolean isActive = false, goLeft, isHit = false;
  
  Arrow() {
    aWidth = 48;
    aHeight = 12;
    reset();
  }
  
  void reset() {
    isActive = false;
    x = -globalScale *10;
    y = -globalScale *10;
    vx = 0;
  }

  void activate(float activatex, float activatey, boolean isLefti) {
    isActive = true;
    x = activatex;
    y = activatey;
    if (isLefti) {
      vx = -ARROW_VELOCITY;
    } else {
      vx = ARROW_VELOCITY;
    }
  }
  
  void update() {
    x += vx;
    x -= globalScrollSpeed;
    if(player.hitboxCollision(x, y, aWidth, aHeight)) {
      player.enemyDamage = true;
      reset();
    }
    
    if(x + aWidth < 0 || x > width) {
      reset();
    }
  }
  
  void draw() {
  //  fill(200, 170, 0);
 //   rect(x, y, aWidth, aHeight);
 fill(255);
    textSize(20);
    text("yeet",x,y);
  }
}
