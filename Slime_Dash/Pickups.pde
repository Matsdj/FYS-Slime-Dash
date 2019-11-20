// IVANO
PCoin[] CoinList;
PHealth[] HealthList;

final int PICKUP_AMOUNT = 20;
final int GAIN_SCORE = 100;
final int GAIN_HEALTH = 20;

void pickupSetup() {
  CoinList = new PCoin[PICKUP_AMOUNT];
  HealthList = new PHealth[PICKUP_AMOUNT];

  for (int iPickup = 0; iPickup< PICKUP_AMOUNT; iPickup++) {
    CoinList[iPickup] = new PCoin();
    HealthList[iPickup] = new PHealth();
  }
}

void addCoin(float x, float y) {
  for (int iCoin = 0; iCoin < PICKUP_AMOUNT; iCoin++) {
    if (!CoinList[iCoin].isActive) {
      CoinList[iCoin].activate(x, y);
      break;
    }
  }
}

void addHeart(float x, float y) {
  for (int iHealth = 0; iHealth < PICKUP_AMOUNT; iHealth++) {
    if (!HealthList[iHealth].isActive) {
      HealthList[iHealth].activate(x, y);
      break;
    }
  }
}

void pickupUpdate() {
  for (int cU = 0; cU < PICKUP_AMOUNT; cU++) {
    if (CoinList[cU].isActive) {
      CoinList[cU].update();
    }
  }
  for (int hU = 0; hU < PICKUP_AMOUNT; hU++) {
    if (HealthList[hU].isActive) {
      HealthList[hU].update();
    }
  }
}
void pickupDraw() {
  for (int cD = 0; cD < PICKUP_AMOUNT; cD++) {
    if (CoinList[cD].isActive) {
      CoinList[cD].draw();
    }
  }
  for (int hD = 0; hD < PICKUP_AMOUNT; hD++) {
    if (HealthList[hD].isActive) {
      HealthList[hD].draw();
    }
  }
}

class PCoin {
  float x, y, size;
  float collisionCorrector = 0.5;
  boolean pickedUp, isActive = false;
  color c = color(255, 255, 0);

  PCoin() {
    size = globalScale;
    reset();
  }

  void reset() {
    isActive = false;
    x = -globalScale *10;
    y = -globalScale *10;
  }

  void activate(float activatex, float activatey) {
    isActive = true;
    pickedUp = false;
    x = activatex + size / 2;
    y = activatey + size / 2;
  }
  // collision check of de player de coin aanraakt
  void update() {
    x -= globalScrollSpeed;
    if (player.Collision(x - (collisionCorrector * globalScale), y - (collisionCorrector * globalScale), size)) {
      pickedUp = true;
    }
    // score update bij pickup van coin & reset terug naar false zodat er opnieuw een coin opgepakt kan worden
    if (pickedUp) {
      reset();
      interfaces.score += GAIN_SCORE;
    }
  }

  void draw() {
    imageMode(CORNER);

    image(coin, x-size/2, y-size/2, size, size);
  }
}

class PHealth {
  float x, y, size, crossWidth = globalScale / 5, crossHeight = crossWidth * 4;
  float collisionCorrector = 0.5;
  boolean pickedUp, isActive = false;
  color c = color(255, 0, 0);

  PHealth() {
    size = globalScale;
    reset();
  }

  void reset() {
    isActive = false;
    x = -globalScale *10;
    y = -globalScale *10;
  }

  void activate(float activatex, float activatey) {
    isActive = true;
    pickedUp = false;
    x = activatex + size / 2;
    y = activatey + size / 2;
  }

  void update() {
    x -= globalScrollSpeed;
    if (player.Collision(x - (collisionCorrector * globalScale), y - (collisionCorrector * globalScale), size)) {
      pickedUp = true;
    }
    if (pickedUp) {
      reset();
      interfaces.healthMain += GAIN_HEALTH;
    }
  }
  void draw() {
    imageMode(CORNER);

    image(heart, x-size/2, y-size/2, size, size);
  }
}
