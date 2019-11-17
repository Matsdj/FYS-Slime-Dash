//Chris

//House sprites: 10*8
//wall sprite: 9*10
//clouds sprite: 12*9
// sun/sky sprite: 12*12
final int MAX_HOUSES = 6;
final int BG_HOUSES_AMOUNT = 6;
final int BG_WALL_AMOUNT = 6;
final int BG_CLOUDS_AMOUNT = 3;
final int MAX_CLOUDS = 6;
final int SKY_AMOUNT = 2;

BgHouses[] bgHouses;
BgWall[] bgWalls;
BgCloud[] bgClouds;

void bgSetup() {
  //bg houses setup
  bgHouses = new BgHouses[MAX_HOUSES];
  for (int iSprite = 0; iSprite < MAX_HOUSES; iSprite++) {
    bgHouses[iSprite] = new BgHouses();

    //places the first set of houses on the background
    if (iSprite - 1 >= 0) {
      bgHouses[iSprite].reset(bgHouses[iSprite - 1].x + bgHouses[iSprite - 1].spriteWidth, int(random(0, BG_HOUSES_AMOUNT)));
    } else 
    bgHouses[iSprite].reset(0, int(random(0, BG_HOUSES_AMOUNT)));
  }

  //bg walls setup
  bgWalls = new BgWall[BG_WALL_AMOUNT];
  for (int iSprite = 0; iSprite < BG_WALL_AMOUNT; iSprite++) {
    bgWalls[iSprite] = new BgWall();

    //places the first set of walls on the background
    if (iSprite - 1 >= 0) {
      bgWalls[iSprite].reset(bgWalls[iSprite - 1].x + bgWalls[iSprite - 1].spriteWidth);
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
    if (bgHouses[iSprite].x + bgHouses[iSprite].spriteWidth < 0) {
      if (iSprite - 1 >= 0) {
        //when a house goes offscreen, the house will be set next to the most far away house. This way houses will remain on screen, and houses will keep being randomized
        bgHouses[iSprite].reset(bgHouses[iSprite - 1].x + bgHouses[iSprite - 1].spriteWidth, int(random(0, BG_HOUSES_AMOUNT)));
        break;
      } else {
        bgHouses[iSprite].reset(bgHouses[iSprite + MAX_HOUSES - 1].x + bgHouses[iSprite + MAX_HOUSES - 1].spriteWidth, int(random(0, BG_HOUSES_AMOUNT)));
        break;
      }
    }
  }

  //resets bg walls when they go offscreen
  for (int iSprite = 0; iSprite < BG_WALL_AMOUNT; iSprite++) {
    if (bgWalls[iSprite].x + bgWalls[iSprite].spriteWidth < 0) {
      if (iSprite - 1 >= 0) {
        //does the same as the house reset, but without having to give a new housetype
        bgWalls[iSprite].reset(bgWalls[iSprite - 1].x + bgWalls[iSprite - 1].spriteWidth);
        break;
      } else {
        bgWalls[iSprite].reset(bgWalls[iSprite + BG_WALL_AMOUNT - 1].x + bgWalls[iSprite + BG_WALL_AMOUNT - 1].spriteWidth);
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

  for (int iSprite = 0; iSprite < BG_WALL_AMOUNT; iSprite++) {
    bgWalls[iSprite].update();
  }

  for (int iSprite = 0; iSprite < MAX_CLOUDS; iSprite++) {
    bgClouds[iSprite].update();
  }

  sunUpdate();
}

void bgDraw() { 
  //draws a blue sky in bg

  float skySize = 12*globalScale;
  for (int iSky = 0; iSky < SKY_AMOUNT; iSky++) {
    image(bgSky, 0 + skySize * iSky, 0, skySize, skySize);
  }

  sunDraw();

  for (int iSprite = 0; iSprite < MAX_CLOUDS; iSprite++) {
    bgClouds[iSprite].draw();
  }

  for (int iSprite = 0; iSprite < BG_WALL_AMOUNT; iSprite++) {
    bgWalls[iSprite].draw();
  }

  for (int iSprite = 0; iSprite < MAX_HOUSES; iSprite++) {
    bgHouses[iSprite].draw();
  }

  skyChange();
}

//houses///////////////
class BgHouses {
  final int BG_HOUSES_SCROLLSPEED = 2; //the speed at witch the houses move is the globalScroll speed divided by this number
  float x, y, spriteWidth, spriteHeight, vx;
  int houseType;
  BgHouses() {
    y = globalScale * 4;
    spriteWidth = 10 * globalScale;
    spriteHeight = 8 * globalScale;
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
    image(bgHouse[houseType], x, y, spriteWidth, spriteHeight);
  }
}

//walls/////////////////
class BgWall {
  final int BG_WALL_SCROLLSPEED = 3;
  float x, y, spriteWidth, spriteHeight, vx;
  BgWall() {
    y = globalScale;
    spriteWidth = 9 * globalScale;
    spriteHeight = 10 * globalScale;
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
    image(bgWall, x, y, spriteWidth, spriteHeight);
  }
}

//clouds////////////
class BgCloud {
  final float BG_CLOUDS_SCROLLSPEED = 2.5;
  final float Y_MAX = globalScale;
  final float Y_MIN = -globalScale * 1.5;
  final float X_MAX = width + globalScale * 15;
  final float X_MIN = width;
  int cloudType;
  float x, y, spriteWidth, spriteHeight, vx;
  BgCloud() {
    y = random(Y_MIN, Y_MAX);
    x = random(0, X_MAX);
    cloudType = int(random(0, BG_CLOUDS_AMOUNT-1));
    spriteWidth = (12 * globalScale)/2;
    spriteHeight = (9 * globalScale)/2;
  }

  void reset() {
    x = random(X_MIN, X_MAX);
    y = random(Y_MIN, Y_MAX);
    cloudType = int(random(0, BG_CLOUDS_AMOUNT-1));
  }

  void update() {
    vx = -globalScrollSpeed / BG_CLOUDS_SCROLLSPEED;
    x += vx;
    if (x + spriteWidth < 0) {
      reset();
    }
  }

  void draw() {
    image(bgCloud[cloudType], x, y, spriteWidth, spriteHeight);
  }
}

//sun//////////////////
float sunX, sunY, sunWidth, sunHeight;

void sunSetup() {
  sunWidth = (12 * globalScale)/2;
  sunHeight = (12 * globalScale)/2;
  sunX = width - sunWidth;
  sunY = -globalScale;
}

void sunUpdate() {
  final float SUN_DOWN_MAX_RED = globalScale * 3;
  final float SUN_DOWN_MAX_BLUE = globalScale * 6;
  if (time>=slow && sunY < SUN_DOWN_MAX_RED) {
    sunY++;
  } else if (time>=mid && sunY < SUN_DOWN_MAX_BLUE) {
    sunY++;
  }
}
void sunDraw() {
  image(bgSun, sunX, sunY, sunWidth, sunHeight);
}


//Sky color shift////////////////////
int redSkyTransition = 0;
int blueSkyTransition = 0;
void skyChange() {
  final int RED_MAX = 40;
  final int BLUE_MAX = 100;
  final color RED_SKY = color(255, 0, 0);
  final color BLUE_SKY = color(0, 0, 60);

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
