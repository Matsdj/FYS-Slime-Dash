PImage[] enemySprite;
PImage[] playerSprite;
PImage[][] bgHouse;

public void assetSetup() {
  enemySprite = new PImage[ENEMY_SPRITE_AMOUNT];
  for (int iSprite = 0; iSprite < ENEMY_SPRITE_AMOUNT; iSprite++) {
    enemySprite[iSprite] = loadImage("sprites/enemy/enemy"+ iSprite + ".png");
  }

  playerSprite = new PImage[PLAYER_FRAME_AMOUNT];
  for (int iSprite = 0; iSprite < PLAYER_FRAME_AMOUNT; iSprite++) {
    playerSprite[iSprite] = loadImage("sprites/player/player"+ iSprite +".png");
  }

  bgHouse = new PImage[BG_HOUSES_AMOUNT][BG_HOUSES_SPAWNABLE_AMOUNT];
  for (int iSprite = 0; iSprite < BG_HOUSES_AMOUNT; iSprite++) {
    for (int jSprite = 0; jSprite < BG_HOUSES_SPAWNABLE_AMOUNT; jSprite++) {
      bgHouse[iSprite][jSprite] = loadImage("sprites/backGround/house"+ iSprite +".png");
    }
  }
}
