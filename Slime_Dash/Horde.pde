final int HORDE_STAGES = 4;
final int HORDE_STAGE_SPRITE_AMOUNT = 2;
final int HORDE_FRAMERATE = 10;

int hordeFrameCounter = 0;
float hordeX, hordeY;

void hordeSetup() {
  hordeX = 0;
  hordeY = globalScale * 6;
}
void hordeUpdate() {
  if (frameCount % HORDE_FRAMERATE == 0) {
    hordeFrameCounter ++;
    if (hordeFrameCounter >= HORDE_STAGE_SPRITE_AMOUNT) {
      hordeFrameCounter = 0;
    }
  }
}

void hordeDraw() {
  for (int iSprite = HORDE_STAGES-1; iSprite >= 0; iSprite--) {
    image(horde[iSprite][hordeFrameCounter], hordeX, hordeY);
  }
}
