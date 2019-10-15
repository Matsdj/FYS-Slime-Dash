// IVANO

void pickupsSetup() {
  int PCoinsSize = 100, PHealthSize = 100;
  CoinList = new PCoin[PCoinsSize];
  HealthList = new PHealth[PHealthSize];
}

void addCoin(float x, float y) {
  for (int iCoin = 0; iCoin < CoinList.length; iCoin++) {
    if (CoinList[iCoin] == null) {
      CoinList[iCoin] = new PCoin(x, y);
      break;
    }
  }
}

void addHeart(float x, float y) {
  for (int iHealth = 0; iHealth < HealthList.length; iHealth++) {
    if (HealthList[iHealth] == null) {
      HealthList[iHealth] = new PHealth(x, y);
      break;
    }
  }
}

void pickupUpdate() {
  for (int cU = 0; cU < CoinList.length; cU++) {
    if (CoinList[cU] != null) {
      CoinList[cU].update();
      if (CoinList[cU].x < 0 - CoinList[cU].size) {
        CoinList[cU] = null;
      }
    }
  }
  for (int hU = 0; hU < HealthList.length; hU++) {
    if (HealthList[hU] != null) {
      HealthList[hU].update();
      if (HealthList[hU].x < 0 - HealthList[hU].size) {
        HealthList[hU] = null;
      }
    }
  }
}
void pickupDraw() {
  for (int cD = 0; cD < CoinList.length; cD++) {
    if (CoinList[cD] != null) {
      CoinList[cD].draw();
    }
  }
  for (int hD = 0; hD < HealthList.length; hD++) {
    if (HealthList[hD] != null) {
      HealthList[hD].draw();
    }
  }
}

PCoin[] CoinList;
PHealth[] HealthList;

class PCoin {
  float x, y, size;
  boolean pickedUp;
  color c = color(255, 255, 0);
  PCoin(float cx, float cy) {
    size = globalScale;
    x = cx + size / 2;
    y = cy + size / 2;
    pickedUp = false;
  }
  // collision check of de player de coin aanraakt 
  void update() {
    x -= globalScrollSpeed;
    if (player.Collision(x - (0.5 * globalScale), y - (0.5 * globalScale), size)) {
      pickedUp = true;
    }
    // score update bij pickup van coin & reset terug naar false zodat er opnieuw een coin opgepakt kan worden    
    if (pickedUp == true) {
      interfaces.score += 100;
      x = -100;
      pickedUp = false;
    }
  }

  void draw() {
    fill(c);
    ellipse(x, y, size, size);
  }
}

class PHealth {
  float x, y, size;
  boolean pickedUp;
  color c = color(255, 0, 0);
  PHealth(float hx, float hy) {
    size = globalScale;
    x = hx + size / 2;
    y = hy + size / 2;
    pickedUp = false;
  }
  void update() {
    x -= globalScrollSpeed;
    if (player.Collision(x - (0.5 * globalScale), y - (0.5 * globalScale), size)) {
      pickedUp = true;
    }
    if (pickedUp == true) {
      interfaces.healthMain += 20;
      x = -100;
      pickedUp = false;
    }
  }
  void draw() {
    fill(c);
    ellipse(x, y, size, size);
  }
}
