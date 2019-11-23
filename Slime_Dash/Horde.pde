final int HORDE_STAGES = 4;
final int HORDE_STAGE_SPRITE_AMOUNT = 2;
final int HORDE_FRAMERATE = 40;

int hordeFrameCounter, hordeFramerate;
float hordeX, hordeY, hordeVX;

void hordeSetup() {
  hordeX = -hordeSpriteWidth;
  hordeY = globalScale * 6;
  hordeVX = globalScale/32;
  hordeFrameCounter = 0;
  hordeFramerate = HORDE_FRAMERATE;
}
void hordeUpdate() {
  hordeFramerate = HORDE_FRAMERATE / int(globalScrollSpeed+1);
  if(!interfaces.death && hordeX < 0){
    hordeX += hordeVX;
  }
  if(interfaces.death && hordeX > -hordeSpriteWidth){
    hordeX -= hordeVX;
  }
  
  if (frameCount % hordeFramerate == 0) {
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
