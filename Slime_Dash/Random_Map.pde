//Mats
//hier maak ik de variabelen aan
float GenerateDistance;
PImage[] mapTemplateList;
PImage startTemplate;
//All Final variables
final color BRICK = color(150, 150, 150);
final color STONE = color(200, 200, 200);
final color DIRT = color(150,100,50);
final color PLANKS = color(200,150,100);
final color MOVINGBRICK = color(170, 170, 170);
final int SCROLLBLOCKRED = 6; //vul bij rood 1, bij groen 1 of 0 (percentage ja of nee), en bij blauw de hoeveelheid.
final color ICE = color(0, 255, 255);
final color SPIKE = color(255, 0, 0);
final color FLAME = color(255, 150, 0);
final color COIN = color(255, 255, 0);
final color HEALTH = color(0, 255, 0);
final color HOSTILEMELEE = color(255, 0, 100);
final color HOSTILERANGED = color(255, 0, 150);

//Setup allows for reset
void mapSetup() {
  startTemplate = loadImage("templates/startTemplate.png");
  // we'll have a look in the data folder
  java.io.File templates = new java.io.File(dataPath("templates"));
  // list the files in the data folder
  String[] fileNames = templates.list();
  mapTemplateList = new PImage[fileNames.length];
  for (int i = 0; i < mapTemplateList.length; i++) {
    mapTemplateList[i] = loadImage("templates/"+fileNames[i]);
  }
  GenerateDistance = 0;
  makeMap(false);
}
//Looks if it has generated to the edge of the screen
void mapUpdate() {
  if (GenerateDistance < width/globalScale) {
    makeMap(true);
  }
  GenerateDistance-=globalScrollSpeed/globalScale;
}
//Adds a new template behind the last generated one
void makeMap(boolean random) {
  PImage mapTemplate = mapTemplateList[0];
  if (random == false) {
    mapTemplate = startTemplate;
  }
  if (random) {
    //Grabs random Template
    mapTemplate = mapTemplateList[floor(random(mapTemplateList.length))];
  }
  mapTemplate.loadPixels();
  //Loops through list and places blocks at the correct place
  for (int templateY = mapTemplate.height-1; templateY > -1; templateY--) {
    for (int templateX = 0; templateX < mapTemplate.width; templateX++) {
      //location of the pixel in the pixels list
      int loc = templateX + (templateY * mapTemplate.width);
      //Determines wat the X and Y of the blocks is going to be
      float x = (GenerateDistance+templateX)*globalScale, 
        y = (templateY-(mapTemplate.height-height/globalScale-1))*globalScale;
      //color of pixel in picture
      color col = color(red(mapTemplate.pixels[loc]), green(mapTemplate.pixels[loc]), blue(mapTemplate.pixels[loc]));
      if (random(255) <= alpha(mapTemplate.pixels[loc])) {
        //Places Blocks,Spikes etc.
        if (col == BRICK) {
          blocks[freeBlockIndex()].blockSetup(x, y, BRICK, false, false, -1);
        }
        if (col == STONE) {
          blocks[freeBlockIndex()].blockSetup(x, y, STONE, false, false, -1);
        }
        if (col == DIRT) {
          blocks[freeBlockIndex()].blockSetup(x, y, DIRT, false, false, -1);
        }
        if (col == PLANKS) {
          blocks[freeBlockIndex()].blockSetup(x, y, PLANKS, false, false, -1);
        }
        if (red(col) == SCROLLBLOCKRED){
          boolean scrollPercentage;
          if (green(col) < 1){
          scrollPercentage = false;
          } else {
          scrollPercentage = true;
          }
          blocks[freeBlockIndex()].blockSetup(x, y, STONE, false, scrollPercentage, blue(col));
        }
        if (col == ICE) {
          blocks[freeBlockIndex()].blockSetup(x, y, ICE, false, false, -1);
        }
        if (col == MOVINGBRICK) {
          blocks[freeBlockIndex()].blockSetup(x, y, BRICK, true, false, -1);
        }
        if (col == SPIKE) {
          addSpike(x, y);
        }
        if (col == FLAME) {
          addFlame(x, y);
        }
        if (col == COIN) {
          addCoin(x, y);
        }
        if (col == HEALTH) {
          addHeart(x, y);
        }
        if (col == HOSTILEMELEE) {
          addHostileMelee(x, y);
        }
        if (col == HOSTILERANGED) {
          addHostileRanged(x, y);
        }
      }
    }
  }
  //Adds the generated distance
  GenerateDistance += mapTemplate.width;
}
