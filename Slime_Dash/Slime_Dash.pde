/*ig101-5
 Chris - 500828243,
 Collin - 500833247,
 Ivano - 500831163,
 Mats - 500827411,
 Laurens - 500821318
 */

//remember, ctrl+t

float globalScale, speedModifier = 1, globalScrollSpeed, time, globalVerticalSpeed, playerCatchUp, VerticalDistance, coins = 0;
final float MAX_SCROLL_SPEED = 9;
// Arrays of booleans for Keyboard handling. One boolean for each keyCode
final int KEY_LIMIT = 1024;
boolean[] keysPressed = new boolean[KEY_LIMIT];
String room;
boolean allowVerticalMovement = false;
final int COOLDOWN_MAX=15, COOLDOWN_MIN=0;
final int COOLDOWN_UPGRADE=30;
int cooldown;


void setup() {
  size(1280, 720, P2D);
  //fullScreen(P2D);
  smooth(0);
  frameRate(60);
  globalScale = height/12;
  room = "mainM";
  time = 0;
  cooldown=COOLDOWN_MAX;
  assetSetup();
  soundSetup();
  bgSetup();
  hordeSetup();
  playerSetup();
  blinkSetup();
  interfacesSetup();
  mainMSetup();
  hostileSetup();
  magicBlockSetup();
  arrowSetup();
  blockSetup();
  spikeSetup();
  flameSetup();
  pauseSetup();
  pickupSetup();
  mapSetup();
  upgradeSetup();
  difSetup();
  particleSetup();
  //database
  //  CreateDatabaseConnection();
  //  GetUsers();
  //particle system
  //  ps = new ParticleSystem(new PVector(width/2, 50));
}
//GAME
void updateGame() {
  if (speedModifier < 1) {
    speedModifier += 0.01;
  } else {
    speedModifier = 1;
  }
  time += 1*speedModifier;
  //ScrollSpeed
  globalScrollSpeed = 1+time/100000*globalScale;
  globalScrollSpeed = constrain(globalScrollSpeed, 0, MAX_SCROLL_SPEED);
  playerCatchUp = player.DASHSPEED*(pow(player.x, 5)/pow(width*1.2, 5));
  if (player.x > 0) {
    globalScrollSpeed += playerCatchUp;
  }
  if (player.x > width-globalScale) {
    globalScrollSpeed += player.vx;
  }
  //tutorial mode
  if (room == "game2") {
    float scrollSpeed = player.DASHSPEED*(pow(player.x-width/2, 1)/pow(width/2, 1));
    if (scrollSpeed > 0) {
      globalScrollSpeed = scrollSpeed;
    } else {
      globalScrollSpeed = 0;
    }
  }
  globalScrollSpeed *= speedModifier;
  //Vertical Distance
  if (time > 60) {
    globalVerticalSpeed = floor(globalScale*(pow(height/2-(player.y+globalScale*2), 3)/pow(height/2, 3)));
    if (globalVerticalSpeed >= 0 && !allowVerticalMovement) {
      globalVerticalSpeed = 0;
    }
    if (VerticalDistance + globalVerticalSpeed <= 0) {
      globalVerticalSpeed = -VerticalDistance;
    }
    VerticalDistance += globalVerticalSpeed;
    allowVerticalMovement = false;
  }
  globalVerticalSpeed *= speedModifier;
  //input cooldown

  //Adds Terrain
  mapUpdate();
  //Terrain Update
  bgUpdate();
  hordeUpdate();
  blockUpdate();
  //Obstacles
  spikeUpdate();
  pickupUpdate();
  flameUpdate();
  magicBlockUpdate();
  //Moving Enemy
  arrowUpdate();
  hostileUpdate();
  //Overlay
  interfaces.update();
  particleUpdate();
  //Player
  player.update();
  blinkUpdate();
}

void drawGame() {
  background(102, 204, 255);
  bgDraw();
  drawBackgroundBlocks();
  hostileDraw();
  blinkDraw();
  player.draw();
  spikeDraw();
  blockDraw();
  arrowDraw();
  pickupDraw();
  flameDraw();
  magicBlockDraw();
  hordeDraw();
  skyChange();
  particleDraw();
  interfaces.draw();
  shakeUpdate();
}

void draw() {
  //ESC
  if (inputsPressed.hasValue(ESC)) {
    if (room == "mainM") {
      exit();
    } else {
      room = "mainM";
      setup();
    }
  }
  if (cooldown>-1) {
    cooldown--;
  }
  if (room=="game"||room=="game2") {
    cooldown=COOLDOWN_MAX;
  }
  soundUpdate();

  if (room == "pause") {
    pause.draw();
    pause.update();
  } else if (room == "pause2") {
    pause.draw();
    pause.update();
  } else if (room =="game") {
    pause.update();
    updateGame();
    drawGame();
  } else if (room =="game2") {
    globalScrollSpeed = player.DASHSPEED*(pow(player.x-width/2, 1)/pow(width/2, 1));
    pause.update();
    updateGame();
    drawGame();
  } else if (room == "mainM") {
    bgUpdate();
    bgDraw();
    main.update();
    main.draw();
    interfaces.death = false;
  } else if (room == "difficulty") {
    bgUpdate();
    bgDraw();
    dif.draw();
    dif.update();
  } else if (room == "upgrades") {
    bgUpdate();
    bgDraw();
    upgrade.draw();
    upgrade.update();
  } else if (room == "achievements") {
  }
  debug();
  inputsPressedUpdate();
  //particle
}
