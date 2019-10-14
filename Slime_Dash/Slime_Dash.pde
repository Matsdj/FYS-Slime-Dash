/*ig101-5
 Chris, Collin, Ivano, Mats, Laurens
 */

//remember, ctrl+t

float frameSpeed, globalScale, globalScrollSpeed;
// Arrays of booleans for Keyboard handling. One boolean for each keyCode
final int KEY_LIMIT = 1024;
boolean[] keysPressed = new boolean[KEY_LIMIT];
String room;

void setup() {
  size(1280, 720);
  frameRate(60);
  globalScale = height/12;
  globalScrollSpeed = globalScale/30;
  room = "mainM";

  playerSetup();
  interfacesSetup();
  mainMSetup();
  hostileSetup();
  blockSetup();
  spikeSetup();
  pauseSetup();
  pickupsSetup();
  mapSetup();
}
//GAME
void updateGame() {
  //Doe alle snelheden x frameSpeed zodat wanneer de frames omlaag gaan het spel niet trager wordt
  frameSpeed = 60/frameRate;
  //globalScale is hoe groot een block wordt in de hoogte en de breedte gebruik deze variable om de grootte van alles te scalen
  globalScale = height/12;
  player.update();
  interfaces.update();
  blockUpdate();
  mapUpdate();
  hostileUpdate();
  pickupUpdate();
  spike.update();
}

void drawGame() {
  background(255);
  player.draw();
  blockDraw();
  hostileDraw();
  pickupDraw();
  interfaces.draw();
  //spike.draw();
}

void draw() {
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
  }
  if (inputs.hasValue(128) == true) {
    fill(255, 0, 0);
    textSize(40);
    text(frameRate, width/2, 50);
  }
}
