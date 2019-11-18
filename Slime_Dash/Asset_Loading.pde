PImage[] enemySprite;
PImage[] playerSprite;
PImage[] bgHouse;
PImage[] bgCloud;
PImage bgWall;
PImage bgSky;
PImage bgSun;

int houseSpriteWidth, houseSpriteHeight, wallSpriteWidth, wallSpriteHeight, cloudSpriteWidth, cloudSpriteHeight, sunSpriteSize, meleeSpriteWidth, meleeSpriteHeight;

public void assetSetup() {
  houseSpriteWidth = int(10 * globalScale);
  houseSpriteHeight = int(8 * globalScale);

  wallSpriteWidth = int(9 * globalScale);
  wallSpriteHeight = int(10 * globalScale);
  
  cloudSpriteWidth = int((12 * globalScale)/2);
  cloudSpriteHeight = int((9 * globalScale)/2);
  
  sunSpriteSize = int((12 * globalScale)/2);
  
  meleeSpriteWidth = int(globalScale);
  meleeSpriteHeight = int(globalScale + globalScale/32*2);
  
  enemySprite = new PImage[ENEMY_SPRITE_AMOUNT];
  for (int iSprite = 0; iSprite < ENEMY_SPRITE_AMOUNT; iSprite++) {
    enemySprite[iSprite] = loadImage("sprites/enemy/enemy"+ iSprite + ".png");
    enemySprite[iSprite].resize(meleeSpriteWidth, meleeSpriteHeight);
  }

  playerSprite = new PImage[PLAYER_FRAME_AMOUNT];
  for (int iSprite = 0; iSprite < PLAYER_FRAME_AMOUNT; iSprite++) {
    playerSprite[iSprite] = loadImage("sprites/player/player"+ iSprite +".png");
  }

  bgHouse = new PImage[BG_HOUSES_AMOUNT];
  for (int iSprite = 0; iSprite < BG_HOUSES_AMOUNT; iSprite++) {
    bgHouse[iSprite] = loadImage("sprites/backGround/house"+ iSprite +".png");
    bgHouse[iSprite].resize(houseSpriteWidth, houseSpriteHeight);
  }

  bgCloud = new PImage[BG_CLOUDS_AMOUNT];
  for (int iSprite = 0; iSprite < BG_CLOUDS_AMOUNT; iSprite++) {
    bgCloud[iSprite] = loadImage("sprites/backGround/cloud"+ iSprite +".png");
    bgCloud[iSprite].resize(cloudSpriteWidth, cloudSpriteHeight);
  }

  bgWall = loadImage("sprites/backGround/wall.png");
  bgWall.resize(wallSpriteWidth, wallSpriteHeight);
  
  bgSky = loadImage("sprites/backGround/sky.png");
  bgSun = loadImage("sprites/backGround/sun.png");
  bgSun.resize(sunSpriteSize, sunSpriteSize);
}
