//House sprites: 10*7
//wall sprite: 9*10
final int MAX_HOUSES = 6;
final int BG_HOUSES_AMOUNT = 6;
final int BG_WALL_AMOUNT = 6;
BgHouses[] bgHouses;

void bgSetup() {
  bgHouses = new BgHouses[MAX_HOUSES];
  for (int iSprite = 0; iSprite < MAX_HOUSES; iSprite++) {
    bgHouses[iSprite] = new BgHouses();
    if (iSprite - 1 >= 0) {
      bgHouses[iSprite].reset(bgHouses[iSprite - 1].x + bgHouses[iSprite - 1].spriteWidth, int(random(0, BG_HOUSES_AMOUNT)));
    } else 
    bgHouses[iSprite].reset(0, int(random(0, BG_HOUSES_AMOUNT)));
  }
}

void addBgHouses() {
  for (int iSprite = 0; iSprite < MAX_HOUSES; iSprite++) {
    if (bgHouses[iSprite].x + bgHouses[iSprite].spriteWidth < 0) {
      if (iSprite - 1 >= 0) {
        bgHouses[iSprite].reset(bgHouses[iSprite - 1].x + bgHouses[iSprite - 1].spriteWidth, int(random(0, BG_HOUSES_AMOUNT)));
        break;
      } else {
        bgHouses[iSprite].reset(bgHouses[iSprite + MAX_HOUSES - 1].x + bgHouses[iSprite + MAX_HOUSES - 1].spriteWidth, int(random(0, BG_HOUSES_AMOUNT)));
      }
    }
  }
}

void bgUpdate() {
  addBgHouses();
  for (int iSprite = 0; iSprite < MAX_HOUSES; iSprite++) {
    bgHouses[iSprite].update();
  }
}

void bgDraw() {
  for (int iSprite = 0; iSprite < MAX_HOUSES; iSprite++) {
    bgHouses[iSprite].draw();
  }
}

class BgHouses {
  final int BG_HOUSES_SCROLLSPEED = 2;
  float x, y, spriteWidth, spriteHeight, vx;
  int houseType;
  BgHouses() {
    y = globalScale * 4;
    spriteWidth = 10 * globalScale;
    spriteHeight = 7 * globalScale;
  }

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
