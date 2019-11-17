PImage[] enemySprite;
PImage[] playerSprite;
PImage[] bgHouse;
PImage[] bgCloud;
PImage bgWall;
PImage bgSky;
PImage bgSun;

public void assetSetup() {
  enemySprite = new PImage[ENEMY_SPRITE_AMOUNT];
  for (int iSprite = 0; iSprite < ENEMY_SPRITE_AMOUNT; iSprite++) {
    enemySprite[iSprite] = loadImage("sprites/enemy/enemy"+ iSprite + ".png");
  }

  playerSprite = new PImage[PLAYER_FRAME_AMOUNT];
  for (int iSprite = 0; iSprite < PLAYER_FRAME_AMOUNT; iSprite++) {
    playerSprite[iSprite] = loadImage("sprites/player/player"+ iSprite +".png");
  }

  bgHouse = new PImage[BG_HOUSES_AMOUNT];
  for (int iSprite = 0; iSprite < BG_HOUSES_AMOUNT; iSprite++) {
    bgHouse[iSprite] = loadImage("sprites/backGround/house"+ iSprite +".png");
  }
  
  bgCloud = new PImage[BG_CLOUDS_AMOUNT];
  for (int iSprite = 0; iSprite < BG_CLOUDS_AMOUNT; iSprite++) {
    bgCloud[iSprite] = loadImage("sprites/backGround/cloud"+ iSprite +".png");
  }
  
  bgWall = loadImage("sprites/backGround/wall.png");
  bgSky = loadImage("sprites/backGround/sky.png");
  bgSun = loadImage("sprites/backGround/sun.png");
}
