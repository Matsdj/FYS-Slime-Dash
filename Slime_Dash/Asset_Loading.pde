PImage[] enemySprite;
PImage[] archerSprite;
PImage arrowSprite;
PImage enemyDeathSprite;
PImage[] playerSprite;
PImage[] playerBlinkSprite;
PImage playerDashBlink;
PImage playerWalkBlink;
PImage crownSprite;
PImage[] flamethrowerSprite;
PImage[][] magicSprite;
PImage[] switchSprite;
PImage magicStaticSprite;
PImage spikeSprite;
PImage[] bgHouse;
PImage[] bgCloud;
PImage[] bgDragon;
PImage[][] hordeSprite;
PImage bgWall;
PImage bgSky;
PImage bgSun;
PImage heart;
PImage coin;
PImage slimeDash;
PImage healthbar;
PImage dashbar;
PImage fire;

final color DASH_AFTER_IMAGE_COLOR = color(255, 210, 210);
final color STANDARD_AFTER_COLOR = color(255, 10, 10);
final color KING_AFTER_COLOR = color(200, 200, 0);

color afterColor;

boolean hasCrown = false; //change this too true for the king slime appearance

int houseSpriteWidth, houseSpriteHeight, wallSpriteWidth, wallSpriteHeight, cloudSpriteWidth, cloudSpriteHeight, sunSpriteSize, 
  meleeSpriteWidth, meleeSpriteHeight, playerSpriteWidth, playerSpriteHeight, skySpriteSize, hordeSpriteWidth, hordeSpriteHeight, flamethrowerSpriteWidth, flamethrowerSpriteHeight, 
  arrowSpriteWidth, arrowSpriteHeight, magicSpriteWidth, magicSpriteHeight, crownOffset, fireWidth, fireHeight;
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
  if (hasCrown) {
    afterColor = KING_AFTER_COLOR;
  } else
    afterColor = STANDARD_AFTER_COLOR;

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

  //melee + ranged EnemyResize
  meleeSpriteWidth = int(globalScale);
  meleeSpriteHeight = int(globalScale + globalScale/32*2);

  //arrow resize
  arrowSpriteWidth = int(globalScale/32*28);
  arrowSpriteHeight = int(globalScale/32*7);

  //flamethrower resize
  flamethrowerSpriteWidth = int(globalScale);
  flamethrowerSpriteHeight = int(globalScale * 2);

  magicSpriteWidth = int(globalScale);
  magicSpriteHeight = int(globalScale * 2);

  //hordeResize
  hordeSpriteWidth = int(globalScale * 2);
  hordeSpriteHeight = int(globalScale * 10);

  //playerResize + variables that pushes center of player sprite into the hitbox of the player 
  playerSpriteWidth = int(globalScale/32 * 52);
  playerSpriteHeight = int(globalScale/32 * 38);
  crownOffset = int(globalScale/32 * 5);
  pushPlayerSpriteR = globalScale/32 * 12;
  pushPlayerSpriteL = globalScale/32 * 8;
  pushPlayerSpriteUp = globalScale/32 * 2;

  enemySprite = new PImage[ENEMY_SPRITE_AMOUNT];
  archerSprite = new PImage[ENEMY_SPRITE_AMOUNT];
  for (int iSprite = 0; iSprite < ENEMY_SPRITE_AMOUNT; iSprite++) {
    enemySprite[iSprite] = loadImage("sprites/enemy/enemy"+ iSprite + ".png");
    enemySprite[iSprite].resize(meleeSpriteWidth, meleeSpriteHeight);
    archerSprite[iSprite] = loadImage("sprites/enemy/archer"+ iSprite + ".png");
    archerSprite[iSprite].resize(int(globalScale), int(globalScale));
  }
  enemyDeathSprite = loadImage("sprites/enemy/enemyDeath.png");
  enemyDeathSprite.resize(meleeSpriteWidth, meleeSpriteHeight);
  arrowSprite = loadImage("sprites/enemy/arrow.png");
  arrowSprite.resize(arrowSpriteWidth, arrowSpriteHeight);

  playerSprite = new PImage[PLAYER_FRAME_AMOUNT];
  playerBlinkSprite = new PImage[PLAYER_FRAME_AMOUNT];
  for (int iSprite = 0; iSprite < PLAYER_FRAME_AMOUNT; iSprite++) {
    playerSprite[iSprite] = loadImage("sprites/player/player"+ iSprite +".png");
    playerSprite[iSprite].resize(playerSpriteWidth, playerSpriteHeight);

    playerBlinkSprite[iSprite] = loadImage("sprites/player/player"+ iSprite +".png");
    playerBlinkSprite[iSprite].resize(playerSpriteWidth, playerSpriteHeight);

    for (int iPixel = 0; iPixel < playerBlinkSprite[iSprite].pixels.length; iPixel++) {
      if (alpha(playerBlinkSprite[iSprite].pixels[iPixel]) > 0) {
        playerBlinkSprite[iSprite].pixels[iPixel] = afterColor;
      }
    }
  }

  playerDashBlink = loadImage("sprites/player/playerDashBlink.png");
  playerDashBlink.resize(playerSpriteWidth, playerSpriteHeight);
  playerWalkBlink = loadImage("sprites/player/player0.png");
  playerWalkBlink.resize(playerSpriteWidth, playerSpriteHeight);
  playerWalkBlink.loadPixels();

  crownSprite = loadImage("sprites/player/crown.png");
  crownSprite.resize(playerSpriteWidth, playerSpriteHeight + crownOffset);

  for (int iPixel = 0; iPixel < playerDashBlink.pixels.length; iPixel++) {
    if (alpha(playerDashBlink.pixels[iPixel]) > 0) {
      playerDashBlink.pixels[iPixel] = DASH_AFTER_IMAGE_COLOR;
    }
  }

  flamethrowerSprite = new PImage[FLAME_SPRITE_AMOUNT];
  for (int iSprite = 0; iSprite < FLAME_SPRITE_AMOUNT; iSprite++) {
    flamethrowerSprite[iSprite] = loadImage("sprites/obstacles/flame"+ iSprite +".png");
    flamethrowerSprite[iSprite].resize(flamethrowerSpriteWidth, flamethrowerSpriteHeight);
  }

  magicSprite = new PImage[MAGIC_TYPE_AMOUNT][MAGIC_FRAME_AMOUNT];
  for (int iSprite = 0; iSprite < MAGIC_TYPE_AMOUNT; iSprite++) {
    for (int jSprite = 0; jSprite < MAGIC_FRAME_AMOUNT; jSprite++) {
      magicSprite[iSprite][jSprite] = loadImage("sprites/obstacles/magic"+ iSprite +"-"+ jSprite +".png");
      magicSprite[iSprite][jSprite].resize(magicSpriteWidth, magicSpriteHeight);
    }
  }

  switchSprite = new PImage[SWITCH_FRAME_AMOUNT];
  for (int iSprite = 0; iSprite < SWITCH_FRAME_AMOUNT; iSprite++) {
    switchSprite[iSprite] = loadImage("sprites/obstacles/switch"+ iSprite +".png");
    switchSprite[iSprite].resize(int(globalScale), int(globalScale));
  }

  magicStaticSprite = loadImage("sprites/obstacles/magicStatic.png");
  magicStaticSprite.resize(magicSpriteWidth, magicSpriteHeight);

  spikeSprite = loadImage("sprites/obstacles/spikes.png");
  spikeSprite.resize(int(globalScale), int(globalScale));

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

  bgDragon = new PImage[MAX_DRAGON_FRAMES];
  for (int iSprite = 0; iSprite < MAX_DRAGON_FRAMES; iSprite++) {
    bgDragon[iSprite] = loadImage("sprites/backGround/dragon"+ iSprite +".png");
    bgDragon[iSprite].resize(cloudSpriteWidth/2, cloudSpriteHeight/2);
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

  //HUD
  healthbar = loadImage("./sprites/HUD/healthbar.png");
  dashbar = loadImage("./sprites/HUD/dashbar.png");
  fire = loadImage("./sprites/HUD/fire.png");
  fireWidth = int(globalScale*3);
  fireHeight = fireWidth;
  textFont(font);
}
