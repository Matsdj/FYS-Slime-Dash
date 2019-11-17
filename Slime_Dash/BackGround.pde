//Chris

//House sprites: 10*8
//wall sprite: 9*10

final int MAX_HOUSES = 6;
final int BG_HOUSES_AMOUNT = 6;
final int BG_WALL_AMOUNT = 6;
BgHouses[] bgHouses;
BgWall[] bgWalls;

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
}

void bgDraw() { 
  for (int iSprite = 0; iSprite < BG_WALL_AMOUNT; iSprite++) {
    bgWalls[iSprite].draw();
  }
  
  for (int iSprite = 0; iSprite < MAX_HOUSES; iSprite++) {
    bgHouses[iSprite].draw();
  }
}

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
