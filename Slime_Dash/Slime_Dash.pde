/*ig101-5
 Chris, Collin, Ivano, Mats, Laurens
 */

//remember, ctrl+t

float frameSpeed, globalScale;
// Arrays of booleans for Keyboard handling. One boolean for each keyCode
final int KEY_LIMIT = 1024;
boolean[] keysPressed = new boolean[KEY_LIMIT];
String room;

void setup() {
  fullScreen();
  frameRate(60);
  globalScale = height/12;
  room = "mainM";

  playerSetup();
  interfacesSetup();
  mainMSetup();
  hostileSetup();
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
  text(frameRate, width/2, 50);
}
