// IVANO
PCoin[] CoinList;
PHealth[] HealthList;

final int PICKUP_AMOUNT = 100;
final int GAIN_HEALTH = 20;
int coinValue = 1;

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
    y += globalVerticalSpeed;

    if (player.Collision(x - (0.5 * globalScale), y - (0.5 * globalScale), size)) {
      reset();
      coins += coinValue;
      createParticle(player.x, player.y, 0, PARTICLE_TEXT_SIZE, color(YELLOW), color(YELLOW), -0.5, 0, false, PARTICLE_LIFE_SHORT, "+"+coinValue, 1);
    }

    if (x < 0 - globalScale * 2) {
      reset();
    }
  }

  void draw() {
    imageMode(CORNER);

    image(coin, x-size/2+shake, y-size/2, size, size);
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
    y += globalVerticalSpeed;

    if (player.Collision(x - (collisionCorrector * globalScale), y - (collisionCorrector * globalScale), size)) {
      reset();
      interfaces.health += GAIN_HEALTH;
      createParticle(player.x, player.y, 0, PARTICLE_TEXT_SIZE, color(0,255,0), color(0,255,0), -0.5, 0, false, PARTICLE_LIFE_SHORT, "+"+GAIN_HEALTH, 1);
      heartCount++; //for databases
    }

    if (x < 0 - globalScale * 2) {
      reset();
    }
  }
  void draw() {
    imageMode(CORNER);

    image(heart, x-size/2+shake, y-size/2, size, size);
  }
}
