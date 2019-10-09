/*ig101-5 
Chris, Collin, Ivano, Julius, Mats, Laurens
*/


//remember, ctrl+t

float frameSpeed, globalScale;
// Arrays of booleans for Keyboard handling. One boolean for each keyCode
final int KEY_LIMIT = 1024;
boolean[] keysPressed = new boolean[KEY_LIMIT];

void setup() {
  size(1280, 720);
  frameRate(60);
  globalScale = height/12;
  playerSetup();
  interfacesSetup();
  mapSetup();
  hostileSetup();
  spikeSetup();
  pickupsSetup();
}

void updateGame() {
  //Doe alle snelheden x frameSpeed zodat wanneer de frames omlaag gaan het spel niet trager wordt
  frameSpeed = 60/frameRate;
  //globalScale is hoe groot een block wordt in de hoogte en de breedte gebruik deze variable om de grootte van alles te scalen
  globalScale = height/12;
  player.update();
  interfaces.update();
  mapUpdate();
  hostile.update();
  pickups.update();
}
void drawGame() {
  background(255);
  player.draw();
  interfaces.draw();
  tempBlockDraw();
  hostile.draw();
  pickups.draw();
}

void draw() {
  updateGame();
  drawGame();
}
