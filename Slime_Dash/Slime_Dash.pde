/*ig101-5
 Chris - 500828243,
 Collin - 500833247,
 Ivano - 500831163,
 Mats - 500827411,
 Laurens - 500821318
 */

//remember, ctrl+t

float frameSpeed, globalScale, globalScrollSpeed, time, globalVerticalSpeed, VerticalDistance;
// Arrays of booleans for Keyboard handling. One boolean for each keyCode
final int KEY_LIMIT = 1024;
boolean[] keysPressed = new boolean[KEY_LIMIT];
String room;
boolean debug = false;
int switchC = 1;


void setup() {
  size(1280, 720, P2D);
  //  fullScreen(P2D);
  smooth(0);
  frameRate(60);
  globalScale = height/12;
  room = "mainM";
  time = 0;
  assetSetup();
  soundSetup(); 
  bgSetup();
  hordeSetup();
  playerSetup();
  interfacesSetup();
  mainMSetup();
  hostileSetup();
  blockSetup();
  spikeSetup();
  flameSetup();
  pauseSetup();
  pickupSetup();
  mapSetup();
  upgradeSetup();
  difSetup();
  //database
  CreateDatabaseConnection();
  GetUsers();
}
//GAME
void updateGame() {
  //Doe alle snelheden x frameSpeed zodat wanneer de frames omlaag gaan het spel niet trager wordt
  frameSpeed = 60/frameRate;
  //globalScale is hoe groot een block wordt in de hoogte en de breedte gebruik deze variable om de grootte van alles te scalen
  globalScale = height/12;
  time += 1 ;
  //ScrollSpeed
  globalScrollSpeed = globalScale/60+ time/100000*globalScale;
  if (player.x > 0) {
    globalScrollSpeed += player.DASHSPEED*(pow(player.x, 5)/pow(width*1.3, 5));
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
  //Vertical Distance
  if (time > 60){
  globalVerticalSpeed = globalScale*(pow(height/2-player.y, 3)/pow(height/2, 3));
  if (VerticalDistance + globalVerticalSpeed <= 0){
  globalVerticalSpeed = -VerticalDistance;
  }
  VerticalDistance += globalVerticalSpeed;
  }
  //Adds Terrain
  mapUpdate();
  //Terrain Update
  bgUpdate();
  hordeUpdate();
  blockUpdate();
  spikeUpdate();
  pickupUpdate();
  flameUpdate();
  //Moving Enemy
  hostileUpdate();
  //Player
  player.update();
  //Overlay
  interfaces.update();
}

void drawGame() {
  background(102, 204, 255);
  bgDraw();
  drawBackgroundBlocks();
  player.draw();
  spikeDraw();
  blockDraw();
  hostileDraw();
  pickupDraw();
  flameDraw();
  hordeDraw();
  skyChange();
  interfaces.draw();
}

void draw() {
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
  }
  debug();
  inputsPressedUpdate();
}
