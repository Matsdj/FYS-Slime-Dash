PImage[] enemySprite;
PImage[] playerSprite;
PImage[] bgHouse;
PImage[] bgCloud;
PImage[][] hordeSprite;
PImage bgWall;
PImage bgSky;
PImage bgSun;
PImage heart;
PImage coin;
PImage slimeDash;
int houseSpriteWidth, houseSpriteHeight, wallSpriteWidth, wallSpriteHeight, cloudSpriteWidth, cloudSpriteHeight, sunSpriteSize, meleeSpriteWidth, meleeSpriteHeight, playerSpriteWidth, playerSpriteHeight, skySpriteSize, hordeSpriteWidth, hordeSpriteHeight;
float pushPlayerSpriteR, pushPlayerSpriteL, pushPlayerSpriteUp;

//Blocks
PImage brickSprite;
PImage stoneSprite;
PImage dirtSprite;
PImage grassSprite;
PImage plankSprite;
PImage iceSprite;
PImage crackedSprite;

//font
PFont font;

public void assetSetup() {
  //houseResize
  houseSpriteWidth = int(10 * globalScale);
  houseSpriteHeight = int(8 * globalScale);

  //wallResize
  wallSpriteWidth = int(10 * globalScale);
  wallSpriteHeight = int(10 * globalScale);

  //cloudResize
  cloudSpriteWidth = int((12 * globalScale)/2);
  cloudSpriteHeight = int((9 * globalScale)/2);

  //sunResize
  sunSpriteSize = int((12 * globalScale)/2);

  //skyResize
  skySpriteSize = int(globalScale * 12);

  //meleeEnemyResize
  meleeSpriteWidth = int(globalScale);
  meleeSpriteHeight = int(globalScale + globalScale/32*2);
  
  //hordeResize
  hordeSpriteWidth = int(globalScale * 2);
  hordeSpriteHeight = int(globalScale * 10);

  //playerResize + variables that pushes center of player sprite into the hitbox of the player 
  playerSpriteWidth = int(globalScale/32 * 52);
  playerSpriteHeight = int(globalScale/32 * 38);
  pushPlayerSpriteR = globalScale/32 * 12;
  pushPlayerSpriteL = globalScale/32 * 8;
  pushPlayerSpriteUp = globalScale/32 * 2;

  enemySprite = new PImage[ENEMY_SPRITE_AMOUNT];
  for (int iSprite = 0; iSprite < ENEMY_SPRITE_AMOUNT; iSprite++) {
    enemySprite[iSprite] = loadImage("sprites/enemy/enemy"+ iSprite + ".png");
    enemySprite[iSprite].resize(meleeSpriteWidth, meleeSpriteHeight);
  }

  playerSprite = new PImage[PLAYER_FRAME_AMOUNT];
  for (int iSprite = 0; iSprite < PLAYER_FRAME_AMOUNT; iSprite++) {
    playerSprite[iSprite] = loadImage("sprites/player/player"+ iSprite +".png");
    playerSprite[iSprite].resize(playerSpriteWidth, playerSpriteHeight);
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

  hordeSprite = new PImage[HORDE_STAGES][HORDE_STAGE_SPRITE_AMOUNT];
  for (int iSprite = 0; iSprite < HORDE_STAGES; iSprite++) {
    for (int jSprite = 0; jSprite < HORDE_STAGE_SPRITE_AMOUNT; jSprite++) {
      hordeSprite[iSprite][jSprite] = loadImage("sprites/horde/horde"+ iSprite +"-" + jSprite +".png");
      hordeSprite[iSprite][jSprite].resize(hordeSpriteWidth, hordeSpriteHeight);
    }
  }
  
  bgWall = loadImage("sprites/backGround/wall.png");
  bgWall.resize(wallSpriteWidth, wallSpriteHeight);

  bgSky = loadImage("sprites/backGround/sky.png");
  bgSky.resize(skySpriteSize, skySpriteSize);

  bgSun = loadImage("sprites/backGround/sun.png");
  bgSun.resize(sunSpriteSize, sunSpriteSize);

  heart = loadImage("sprites/pickUps/heart.png");
  coin = loadImage("sprites/pickUps/coin.png");

  //Blocks
  brickSprite = loadImage("sprites/blocks/brick.png");
  brickSprite.resize(int(globalScale), int(globalScale));
  stoneSprite = loadImage("sprites/blocks/stone.png");
  stoneSprite.resize(int(globalScale), int(globalScale));
  dirtSprite = loadImage("sprites/blocks/dirt.png");
  dirtSprite.resize(int(globalScale), int(globalScale));
  grassSprite = loadImage("sprites/blocks/grass.png");
  grassSprite.resize(int(globalScale), int(globalScale));
  plankSprite = loadImage("sprites/blocks/planks.png");
  plankSprite.resize(int(globalScale), int(globalScale));
  iceSprite = loadImage("sprites/blocks/ice.png");
  iceSprite.resize(int(globalScale), int(globalScale));
  crackedSprite = loadImage("sprites/blocks/cracked.png");
  crackedSprite.resize(int(globalScale), int(globalScale));

  //Main Menu
  slimeDash = loadImage("./sprites/menus/SlimeDash.png");
  font = createFont("fonts/8bit16.ttf", 32);
}
