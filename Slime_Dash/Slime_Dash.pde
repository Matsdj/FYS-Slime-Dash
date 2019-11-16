/*ig101-5
 Chris - 500828243,
 Collin - ,
 Ivano - 500831163,
 Mats - ,
 Laurens - 500821318
 */

//remember, ctrl+t

float frameSpeed, globalScale, globalScrollSpeed, time;
// Arrays of booleans for Keyboard handling. One boolean for each keyCode
final int KEY_LIMIT = 1024;
boolean[] keysPressed = new boolean[KEY_LIMIT];
String room;
boolean debug = false;

void setup() {
  size(1280, 720, P3D);
  frameRate(60);
  globalScale = height/12;
  room = "mainM";
  time = 0;
  assetSetup();
  bgSetup();
  playerSetup();
  interfacesSetup();
  mainMSetup();
  hostileSetup();
  blockSetup();
  spikeSetup();
  flameSetup();
  pauseSetup();
  pickupsSetup();
  mapSetup();
  soundSetup(); 
  settingSetup();
}
//GAME
void updateGame() {
  //Doe alle snelheden x frameSpeed zodat wanneer de frames omlaag gaan het spel niet trager wordt
  frameSpeed = 60/frameRate;
  //globalScale is hoe groot een block wordt in de hoogte en de breedte gebruik deze variable om de grootte van alles te scalen
  globalScale = height/12;
  time += 1 ;
  //println(time);
  globalScrollSpeed = globalScale/60+ time/100000*globalScale;
  if (player.x > 0) {
    globalScrollSpeed += player.DASHSPEED*(pow(player.x, 5)/pow(width*1.3, 5));
  }
  //tutorial mode
  //globalScrollSpeed = player.DASHSPEED*(pow(player.x-width/2, 1)/pow(width/2, 1));
  //Adds Terrain
  mapUpdate();
  //Terrain Update
  bgUpdate();
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
  player.draw();
  spikeDraw();
  blockDraw();
  hostileDraw();
  pickupDraw();
  flameDraw();
  interfaces.draw();
}

void draw() {
  soundUpdate();
  if (room == "pause") {
    pause.draw();
    pause.update();
  } else if (room =="game") {
    pause.update();
    updateGame();
    drawGame();
  } else if (room == "mainM") {
    main.update();
    main.draw();
  } else if (room == "settings") {
    setting.draw();
    setting.update();
    
  }
  debug();
  inputsPressedUpdate();
}
