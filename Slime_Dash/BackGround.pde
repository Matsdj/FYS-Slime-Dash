//Chris

//House sprites: 10*8
//wall sprite: 9*10
//clouds sprite: 12*9
// sun/sky sprite: 12*12
final int MAX_HOUSES = 4; //spawnable amount
final int BG_HOUSES_AMOUNT = 6; //amount of sprite variations
final int MAX_WALLS = 4;
final int BG_CLOUDS_AMOUNT = 3;
final int MAX_CLOUDS = 6;
final int MAX_DRAGON_FRAMES = 4;
final int SKY_AMOUNT = 2;

BgHouses[] bgHouses;
BgWall[] bgWalls;
BgCloud[] bgClouds;

void bgSetup() {
  redSkyTransition = 0;
  blueSkyTransition = 0;

  //bg houses setup
  bgHouses = new BgHouses[MAX_HOUSES];
  for (int iSprite = 0; iSprite < MAX_HOUSES; iSprite++) {
    bgHouses[iSprite] = new BgHouses();

    //places the first set of houses on the background, chooses a random house sprite
    if (iSprite - 1 >= 0) {
      bgHouses[iSprite].reset(bgHouses[iSprite - 1].x + houseSpriteWidth, int(random(0, BG_HOUSES_AMOUNT)));
    } else 
    bgHouses[iSprite].reset(0, int(random(0, BG_HOUSES_AMOUNT)));
  }

  //bg walls setup
  bgWalls = new BgWall[MAX_WALLS];
  for (int iSprite = 0; iSprite < MAX_WALLS; iSprite++) {
    bgWalls[iSprite] = new BgWall();

    //places the first set of walls on the background
    if (iSprite - 1 >= 0) {
      bgWalls[iSprite].reset(bgWalls[iSprite - 1].x + wallSpriteWidth);
    } else 
    bgWalls[iSprite].reset(0);
  }

  //bg clouds setup
  bgClouds = new BgCloud[MAX_CLOUDS];
  for (int iSprite = 0; iSprite < MAX_CLOUDS; iSprite++) {
    bgClouds[iSprite] = new BgCloud();
  }

  //sun setup
  sunSetup();
}

void resetBg() {
  //resets bg houses when they go offscreen
  for (int iSprite = 0; iSprite < MAX_HOUSES; iSprite++) {
    if (bgHouses[iSprite].x + houseSpriteWidth < 0) {
      if (iSprite - 1 >= 0) {
        //when a house goes offscreen, the house will be set next to the most far away house. This way houses will remain on screen, and houses will keep being randomized
        bgHouses[iSprite].reset(bgHouses[iSprite - 1].x + houseSpriteWidth, int(random(0, BG_HOUSES_AMOUNT)));
        break;
      } else {
        bgHouses[iSprite].reset(bgHouses[iSprite + MAX_HOUSES - 1].x + houseSpriteWidth, int(random(0, BG_HOUSES_AMOUNT)));
        break;
      }
    }
  }

  //resets bg walls when they go offscreen
  for (int iSprite = 0; iSprite < MAX_WALLS; iSprite++) {
    if (bgWalls[iSprite].x + wallSpriteWidth < 0) {
      if (iSprite - 1 >= 0) {
        //does the same as the house reset, but without having to give a new housetype
        bgWalls[iSprite].reset(bgWalls[iSprite - 1].x + wallSpriteWidth);
        break;
      } else {
        bgWalls[iSprite].reset(bgWalls[iSprite + MAX_WALLS - 1].x + wallSpriteWidth);
        break;
      }
    }
  }
}

void bgUpdate() {
  resetBg();

  for (int iSprite = 0; iSprite < MAX_HOUSES; iSprite++) {
    bgHouses[iSprite].update();
  }

  for (int iSprite = 0; iSprite < MAX_WALLS; iSprite++) {
    bgWalls[iSprite].update();
  }

  for (int iSprite = 0; iSprite < MAX_CLOUDS; iSprite++) {
    bgClouds[iSprite].update();
  }

  sunUpdate();
}

void bgDraw() { 
  //draws a blue sky in bg
  for (int iSky = 0; iSky < SKY_AMOUNT; iSky++) {
    image(bgSky, 0 + bgSky.width * iSky, 0);
  }

  sunDraw();

  for (int iSprite = 0; iSprite < MAX_CLOUDS; iSprite++) {
    bgClouds[iSprite].draw();
  }

  for (int iSprite = 0; iSprite < MAX_WALLS; iSprite++) {
    bgWalls[iSprite].draw();
  }

  for (int iSprite = 0; iSprite < MAX_HOUSES; iSprite++) {
    bgHouses[iSprite].draw();
  }
}

//houses///////////////
class BgHouses {
  final int BG_HOUSES_SCROLLSPEED = 2; //the speed at witch the houses move is the globalScroll speed divided by this number
  float x, y, vx;
  int houseType;
  BgHouses() {
    y = globalScale * 4;
  }

  // function that can reset position and type of house for a single instance of this class
  void reset(float placeX, int HouseType) {
    x = placeX;   
    houseType = HouseType;
  }
  void update() {
    vx = -globalScrollSpeed / BG_HOUSES_SCROLLSPEED;
    x += vx;
  }
  void draw() {
    image(bgHouse[houseType], x, y);
  }
}

//walls/////////////////
class BgWall {
  final int BG_WALL_SCROLLSPEED = 3;
  float x, y, vx;
  BgWall() {
    y = globalScale;
  }
  // function that can reset position of a wall for a single instance of this class
  void reset(float placeX) {
    x = placeX;
  }
  void update() {
    vx = -globalScrollSpeed / BG_WALL_SCROLLSPEED;
    x += vx;
  }
  void draw() {
    image(bgWall, x, y);
  }
}

//clouds////////////
class BgCloud {
  final int DRAGON_FRAME_RATE = 15;
  final int DRAGON_SPAWN_CHANCE = 10;
  final float BG_CLOUDS_SCROLLSPEED = 2.3;
  final float BG_CLOUDS_STANDARDSPEED_MIN = globalScale/72;
  final float BG_CLOUDS_STANDARDSPEED_MAX = globalScale/42;
  final float Y_MAX = globalScale;
  final float Y_MIN = -globalScale * 1.5;
  final float X_MAX = width + globalScale * 25;
  final float X_MIN = width;
  int cloudType, dragonFrame;
  float x, y, vx, standardVx;
  boolean dragonSpawn;
  BgCloud() {
    y = random(Y_MIN, Y_MAX);
    x = random(0, X_MAX);
    cloudType = int(random(0, BG_CLOUDS_AMOUNT));
    standardVx = random(BG_CLOUDS_STANDARDSPEED_MIN, BG_CLOUDS_STANDARDSPEED_MAX);
    dragonSpawn = false;
  }

  void reset() {
    //resets it far off screen, so that the clouds move constantly
    dragonSpawn = false;
    x = random(X_MIN, X_MAX);
    y = random(Y_MIN, Y_MAX);
    cloudType = int(random(0, BG_CLOUDS_AMOUNT));

    //chance of a dragon spawning in the background
    if (int(random(0, DRAGON_SPAWN_CHANCE)) == 0 && time > slow) {
      dragonSpawn = true;
    }

    standardVx = random(BG_CLOUDS_STANDARDSPEED_MIN, BG_CLOUDS_STANDARDSPEED_MAX);
  }

  void update() {
    vx = -(globalScrollSpeed / BG_CLOUDS_SCROLLSPEED + standardVx);
    x += vx;
    if (x + cloudSpriteWidth < 0) {
      reset();
    }

    //animation for the dragon
    if (dragonSpawn) {
      if (frameCount % DRAGON_FRAME_RATE == 0) {
        dragonFrame ++;
      }
      if (dragonFrame >= MAX_DRAGON_FRAMES) {
        dragonFrame = 0;
      }
    }
  }

  void draw() {
    if (!dragonSpawn)
      image(bgCloud[cloudType], x, y);
    else
      image(bgDragon[dragonFrame], x, y);
  }
}

//sun//////////////////
float sunX, sunY;

void sunSetup() {
  sunX = width - sunSpriteSize;
  sunY = -globalScale;
}

void sunUpdate() {
  final float SUN_DOWN_MAX_RED = globalScale * 3;
  final float SUN_DOWN_MAX_BLUE = globalScale * 6;

  //makes the sun set after certain time stamps
  if (time>=slow && sunY < SUN_DOWN_MAX_RED) {
    sunY++;
  } else if (time>=mid && sunY < SUN_DOWN_MAX_BLUE) {
    sunY++;
  }
}
void sunDraw() {
  image(bgSun, sunX, sunY);
}


//Sky color shift////////////////////
int redSkyTransition = 0;
int blueSkyTransition = 0;
final int RED_MAX = 40;
final int BLUE_MAX = 100;
final color RED_SKY = color(200, 0, 0);
final color BLUE_SKY = color(0, 0, 60);

void skyChange() {
  //if the player arrives at the part where the music shifts, the sky will turn red
  if (time>=slow && time<mid) {
    redSkyTransition++;
    if (redSkyTransition > RED_MAX) {
      redSkyTransition = RED_MAX;
    }
    fill(RED_SKY, redSkyTransition);
    rect(0, 0, width, height);
  } else if (time>=mid) { 
    redSkyTransition--;
    if (redSkyTransition < 0) {
      redSkyTransition = 0;
    }
    fill(RED_SKY, redSkyTransition);
    rect(0, 0, width, height);
  }

  //if the player arrives at the part where the music shifts agaim, the sky will turn dark blue (night time)
  if (time>=mid && redSkyTransition == 0) {
    blueSkyTransition++;
    if (blueSkyTransition > BLUE_MAX) {
      blueSkyTransition = BLUE_MAX;
    }
    fill(BLUE_SKY, blueSkyTransition);
    rect(0, 0, width, height);
  }
}
