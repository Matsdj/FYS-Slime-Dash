
final int ARROW_AMOUNT = 20;

void arrowSetup() {
  ArrowList = new Arrow[ARROW_AMOUNT];

  for (int iArrow = 0; iArrow < ARROW_AMOUNT; iArrow++) {
    ArrowList[iArrow] = new Arrow();
  }
}

void arrowUpdate() {
  for (int iArrow = 0; iArrow < ARROW_AMOUNT; iArrow++) {
    if (ArrowList[iArrow].isActive) {
      ArrowList[iArrow].update();
    }
  }
}

void arrowDraw() {
  for (int iArrow = 0; iArrow < ARROW_AMOUNT; iArrow++) {
    if (ArrowList[iArrow].isActive) {
      ArrowList[iArrow].draw();
    }
  }
}

Arrow[] ArrowList;

class Arrow {
  final float ARROW_VELOCITY = globalScale/7;

  float x, y, vx, aWidth, aHeight;
  boolean isActive = false, goLeft, isHit = false, isLeft;

  Arrow() {
    aWidth = globalScale/32*28;
    aHeight = globalScale/32*7;
    reset();
  }

  void reset() {
    isActive = false;
    x = -globalScale *10;
    y = -globalScale *10;
  }

  void activate(float activatex, float activatey, boolean isLefti) {
    isActive = true;
    y = activatey;

    isLeft = isLefti;
    if (isLefti) {
      vx = -ARROW_VELOCITY;
      x = activatex - aWidth;
    } else {
      vx = ARROW_VELOCITY;
      x = activatex;
    }
  }

  void update() {
    x += vx;
    x -= globalScrollSpeed;
    y += globalVerticalSpeed;

    if (player.hitboxCollision(x, y, aWidth, aHeight) && vx != 0 &&player.dashActive==true) {
      reset();
    } else if (player.hitboxCollision(x, y, aWidth, aHeight) && vx != 0 && player.dashActive!=true) {
      interfaces.arrowDamage=true;
      player.enemyDamage = true;
      reset();
    } 
    if (vx != 0 && blockCollision(x, y, aHeight) != null) {
      vx = 0;
    }
    if (x + aWidth < 0 || x > width) {
      reset();
    }
  }

  void draw() {
    if (isLeft) {
      pushMatrix();
      scale(-1.0, 1.0);
      image(arrowSprite, -x-arrowSprite.width, y);
      popMatrix();
    } else image(arrowSprite, x, y);
  }
}
