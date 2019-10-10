// IVANO

void pickupsSetup() {
  int PCoinsSize = 100, PHealthSize = 100;
  pickupCoinList = new PCoins[PCoinsSize];
  pickupHealthList = new PHealth[PHealthSize];
}
void pickupUpdate() {
  for (int cU = 0; cU < pickupCoinList.length; cU++) {
    if (pickupCoinList[cU] != null) {
      pickupCoinList[cU].update();
    }
  }
  for (int hU = 0; hU < pickupHealthList.length; hU++) {
    if (pickupHealthList[hU] != null) {
      pickupHealthList[hU].update();
    }
  }
}
void pickupDraw() {
  for (int cD = 0; cD < pickupCoinList.length; cD++) {
    if (pickupCoinList[cD] != null) {
      pickupCoinList[cD].draw();
    }
  }
  for (int hD = 0; hD < pickupHealthList.length; hD++) {
    if (pickupHealthList[hD] != null) {
      pickupHealthList[hD].draw();
    }
  }
}

PCoins[] pickupCoinList;
PHealth[] pickupHealthList;

class PCoins {
  float x, y, pickupSize;
  boolean pickedUp;
  color c = color(255, 255, 0);
  PCoins(float cx, float cy, color cc) {
    x = cx;
    y = cy;
    c = cc;
    pickupSize = globalScale;
    pickedUp = false;
  }
  // collision check of de player de coin aanraakt 
  void update() {
    if (player.Collision(x - (0.5 * globalScale), y - (0.5 * globalScale), pickupSize)) {
      pickedUp = true;
    }
    // score update bij pickup van coin & reset terug naar false zodat er opnieuw een coin opgepakt kan worden    
    if (pickedUp == true) {
      interfaces.score += 100;
      x = random(0 + (0.5 * globalScale), width - (0.5 * globalScale));
      pickedUp = false;
    }
  }

  void draw() {
    fill(c);
    ellipse(x, y, pickupSize, pickupSize);
  }
}

class PHealth {
  float x, y, pickupSize;
  boolean pickedUp;
  color c = color(255, 0, 0);
  PHealth(float hx, float hy, color hc) {
    x = hx;
    y = hy;
    c = hc;
    pickupSize = globalScale;
    pickedUp = false;
  }
  void update() {
    if (player.Collision(x - (0.5 * globalScale), y - (0.5 * globalScale), pickupSize)) {
      pickedUp = true;
    }
    if (pickedUp == true) {
      interfaces.healthMain += 20;
      x = random(0 + (0.5 * globalScale), width - (0.5 * globalScale));
      pickedUp = false;
    }
  }
  void draw() {
    fill(c);
    ellipse(x, y, pickupSize, pickupSize);
  }
}
