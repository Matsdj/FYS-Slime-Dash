final int HORDE_STAGES = 4;
final int HORDE_STAGE_SPRITE_AMOUNT = 2;
final int HORDE_FRAMERATE = 60;

Horde[] horde;

int hordeFrameCounter, hordeFramerate;
float hordeX, hordeY, hordeVX;

void hordeSetup() {
  hordeX = -hordeSpriteWidth;
  hordeY = -hordeSpriteHeight - globalScale + height;
  hordeVX = globalScale/32;
  hordeFrameCounter = 0;
  hordeFramerate = HORDE_FRAMERATE;

  horde = new Horde[HORDE_STAGES];
  for (int iSprite = 0; iSprite < HORDE_STAGES; iSprite++) {
    horde[iSprite] = new Horde(iSprite);
  }
}

void hordeUpdate() {
  hordeFramerate = HORDE_FRAMERATE / int(globalScrollSpeed+1);
  if (hordeFramerate < 1) {
    hordeFramerate = 1;
  }

  if (frameCount % hordeFramerate == 0) {
    hordeFrameCounter ++;
    if (hordeFrameCounter >= HORDE_STAGE_SPRITE_AMOUNT) {
      hordeFrameCounter = 0;
    }
  }

  for (int iSprite = 0; iSprite < HORDE_STAGES; iSprite++) {
    horde[iSprite].update();
  }
}

void hordeDraw() {
  if (room != "game2") {
    for (int iSprite = HORDE_STAGES-1; iSprite >= 0; iSprite--) {
      horde[iSprite].draw();
    }
  }
}

class Horde {
  int hordeIndex;
  float x, hordeActivate;

  Horde(int HordeIndex) {
    hordeIndex = HordeIndex;
    x = hordeX;

    //checks the time that the horde has to become bigger
    switch (hordeIndex) {
    case 0:
      hordeActivate = 0;
      break;
    case 1:
      hordeActivate = slow/2;
      break;
    case 2:
      hordeActivate = slow;
      break;
    case 3:
      hordeActivate = mid;
      break;
    }
  }

  void update() {
    hordeY += globalVerticalSpeed;

    if (!interfaces.death && x < 0 && time > hordeActivate) {
      x += hordeVX;
    }
    if (interfaces.death && x > -hordeSpriteWidth) {
      x -= hordeVX;
    }
  }

  void draw() {
    image(hordeSprite[hordeIndex][hordeFrameCounter], x+shake, hordeY);
  }
}
