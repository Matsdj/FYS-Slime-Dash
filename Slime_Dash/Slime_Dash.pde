/*ig101-5 
 Chris, Collin, Ivano, Julius, Mats, Laurens
 */


//remember, ctrl+t

float frameSpeed, globalScale;
// Arrays of booleans for Keyboard handling. One boolean for each keyCode
final int KEY_LIMIT = 1024;
boolean[] keysPressed = new boolean[KEY_LIMIT];
boolean mainMenu;
String room;

void setup() {
  size(1280, 720);
  frameRate(60);
  globalScale = height/12;
  room = "game";

  playerSetup();
  interfacesSetup();
  mapSetup();
  hostileSetup();
  spikeSetup();
  menuSetup();
  pickupsSetup();

}
//MAIN MENU
void updateMenu() {
  menu.update();
}
void drawMenu() {
  menu.draw();
}
/*
void updatePause() {
  pause.update();
}
void drawPause() {
  pause.draw();
}
*/
//GAME
void updateGame() {
  //Doe alle snelheden x frameSpeed zodat wanneer de frames omlaag gaan het spel niet trager wordt
  frameSpeed = 60/frameRate;
  //globalScale is hoe groot een block wordt in de hoogte en de breedte gebruik deze variable om de grootte van alles te scalen
  globalScale = height/12;
  player.update();
  interfaces.update();
  mapUpdate();
  hostile.update();
  pickupUpdate();
}

void drawGame() {
  background(255);
  player.draw();
  interfaces.draw();
  blockDraw();
  hostile.draw();
  pickupDraw();
}

void draw() {
  if (room == "mainMenu") {
    updateMenu();
    drawMenu();
  } /*else if  (room =="pause") {
   drawGame();
   drawPause();
   updatePause();

} */ else if(room =="game") {
    updateMenu();
    updateGame();
    drawGame();

  } 
}
