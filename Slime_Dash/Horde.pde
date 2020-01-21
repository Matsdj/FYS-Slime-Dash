//Chris

final int HORDE_STAGES = 4, 
  HORDE_STAGE_SPRITE_AMOUNT = 2, 
  HORDE_FRAMERATE = 60, 
  H_STAGE_FARMER = 0, 
  H_STAGE_SMALL = 1, 
  H_STAGE_MEDIUM = 2, 
  H_STAGE_LARGE = 3;

Horde[] horde;

int hordeFrameCounter, hordeFramerate;
float hordeX, hordeY;

void hordeSetup() {
  hordeX = -hordeSpriteWidth;
  hordeY = -hordeSpriteHeight - globalScale + height;
  hordeFrameCounter = 0;
  hordeFramerate = HORDE_FRAMERATE;

  horde = new Horde[HORDE_STAGES];
  for (int iSprite = 0; iSprite < HORDE_STAGES; iSprite++) {
    horde[iSprite] = new Horde(iSprite);
  }
}

void hordeUpdate() {

  //makes horde walk faster when the scrollspeed goes higher
  hordeFramerate = HORDE_FRAMERATE / int(globalScrollSpeed+1);
  if (hordeFramerate < 1) {
    hordeFramerate = 1;
  }

  //swicthes frames of horde every amount of frames given with hordeFramerate
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

  //loop goes from highest to lowest. This makes it so that the beginning parts of de horde draw on top of the others 
  if (room != "game2") {
    for (int iSprite = HORDE_STAGES-1; iSprite >= 0; iSprite--) {
      horde[iSprite].draw();
    }
  }
}

/*This class makes a single part of the horde that follows you. For every time stamp, a new part walks forward*/
class Horde {
  final float HORDE_VX =  globalScale/32;
  int hordeIndex;
  float x, hordeActivate;

  Horde(int HordeIndex) {
    hordeIndex = HordeIndex;
    x = hordeX;

    //checks the time that the horde has to become bigger depending on the given index from the setup for loop
    switch (hordeIndex) {
    case H_STAGE_FARMER:
      hordeActivate = 0;
      break;
    case H_STAGE_SMALL:
      hordeActivate = TIME_SLOW/2;
      break;
    case H_STAGE_MEDIUM:
      hordeActivate = TIME_SLOW;
      break;
    case H_STAGE_LARGE:
      hordeActivate = TIME_MID;
      break;
    }
  }

  void update() {
    hordeY += globalVerticalSpeed;

    if (!interfaces.death && x < 0 && time > hordeActivate) {
      x += HORDE_VX;
    }
    if (interfaces.death && x > -hordeSpriteWidth) {
      x -= HORDE_VX;
    }
  }

  void draw() {
    if (time > hordeActivate) {
      image(hordeSprite[hordeIndex][hordeFrameCounter], x+shake, hordeY);
    }
  }
}
