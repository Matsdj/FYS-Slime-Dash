//Mats
//hier maak ik de variabelen aan
float GenerateDistance, 
  traveledDistance;
PImage[] templateListStart;
PImage[] templateListEnd;
PImage[] templateListTest;
PImage random = null;
PImage startTemplate;
PImage tutorialTemplate;
//All Final variables
final color BRICK = color(150, 150, 150);
final color STONE = color(200, 200, 200);
final color DIRT = color(150, 100, 50);
final color PLANKS = color(200, 150, 100);
final color MOVING_BRICK = color(170, 170, 170);
final color CRACKED = color(100, 100, 100);
final color ICE = color(0, 255, 255);
final color SPIKE = color(255, 0, 0);
final color FLAME = color(255, 150, 0);
final color COIN = color(255, 255, 0);
final color HEALTH = color(0, 255, 0);
final color HOSTILE_MELEE = color(255, 0, 100);
final color HOSTILE_RANGED = color(255, 0, 150);
final color MAGIC_SWITCH = color(255, 0, 255);
final color MAGIC1 = color(255, 1, 255);
final color MAGIC2 = color(255, 2, 255);
final color ALLOW_VERTICAL_MOVEMENT = color(0, 0, 255);
final color COLOR_SAME_RANDOM = color(255, 200, 200);

//Setup allows for reset
void mapSetup() {
  startTemplate = loadImage("templates/start.png");
  tutorialTemplate = loadImage("templates/tutorial.png");
  //Getting all the files
  String[] filesStart = (new java.io.File(dataPath("templates/start"))).list();
  String[] filesEnd = (new java.io.File(dataPath("templates/end"))).list();
  String[] filesAlways = (new java.io.File(dataPath("templates/always"))).list();
  String[] filesTest = (new java.io.File(dataPath("templates/test"))).list();
  //Getting amount of images and creating an array with the same size
  int imageCount = filesStart.length + (filesAlways.length);
  templateListStart = new PImage[imageCount];
  //Loading images
  for (int i = 0; i < imageCount; i++) {
    if (i < filesStart.length) {
      templateListStart[i] = loadImage("templates/start/"+filesStart[i]);
    } else {
      templateListStart[i] = loadImage("templates/always/"+filesAlways[i-filesStart.length]);
    }
  }
  //Getting amount of images and creating an array with the same size
  imageCount = filesEnd.length + (filesAlways.length);
  templateListEnd = new PImage[imageCount];
  //Loading images
  for (int i = 0; i < imageCount; i++) {
    if (i < filesEnd.length) {
      templateListEnd[i] = loadImage("templates/end/"+filesEnd[i]);
    } else {
      templateListEnd[i] = loadImage("templates/always/"+filesAlways[i-filesEnd.length]);
    }
  }
  //Getting amount of images and creating an array with the same size
  imageCount = filesTest.length;
  templateListTest = new PImage[imageCount];
  //Loading images
  for (int i = 0; i < filesTest.length; i++) {
    templateListTest[i] = loadImage("templates/test/"+filesTest[i]);
  }
  //Resets
  GenerateDistance = 0;
  traveledDistance = 0;
  VerticalDistance = 0;
}
//Looks if it has generated to the edge of the screen
void mapUpdate() {
  //Deze if statement zorgt ervoor dat het niet de tutorial template nog een keer genereerd.
  if (GenerateDistance == 0) {
    if (room == "game2") {
      makeMap(tutorialTemplate);
    }
    makeMap(startTemplate);
  }
  //This makes it so the tutorial transitions into normal mode
  if (GenerateDistance < width/globalScale) {
    if (room == "game2") {
      room = "game";
      interfaces.score = 0;
      time = 0;
    }
    makeMap(random);
  }
  GenerateDistance-=globalScrollSpeed/globalScale;
  traveledDistance += globalScrollSpeed/globalScale;
}
//Adds a new template behind the last generated one
void makeMap(PImage template) {
  PImage mapTemplate;
  if (template == null) {
    //Descides wich templates to use depending on the globalScrollSpeed
    if (testTemplates) {
      int randomTemplateIndex = floor(random(templateListTest.length));
      mapTemplate = templateListTest[randomTemplateIndex];
    } else if (time < TIME_MID) {
      int randomTemplateIndex = floor(random(templateListStart.length));
      mapTemplate = templateListStart[randomTemplateIndex];
    } else {
      int randomTemplateIndex = floor(random(templateListEnd.length));
      mapTemplate = templateListEnd[randomTemplateIndex];
    }
  } else {
    mapTemplate = template;
  }
  mapTemplate.loadPixels();
  color colSameChance = color(255, 0);
  boolean colAllow = false;
  //Loops through list and places blocks at the correct place
  for (int templateY = mapTemplate.height-1; templateY > -1; templateY--) {
    for (int templateX = 0; templateX < mapTemplate.width; templateX++) {
      //location of the pixel in the pixels list
      int loc = templateX + (templateY * mapTemplate.width);
      //Determines wat the X and Y of the blocks is going to be
      float x = (GenerateDistance+templateX)*globalScale, 
        y = (templateY-(mapTemplate.height-height/globalScale-1))*globalScale+VerticalDistance;
      //color of pixel in picture
      color col = mapTemplate.pixels[loc];
      //If the color is COLOR_SAME_RANDOM al the pixels with the exact same color as the pixel to the right of it have the same chance to be generated
      if (col == COLOR_SAME_RANDOM) {
        colSameChance = mapTemplate.pixels[loc+1];
        if (random(255) <= alpha(mapTemplate.pixels[loc+1])) {
          colAllow = true;
        }
      }
      if (col == colSameChance) {
        if (colAllow) {
          col = color(red(col), green(col), blue(col), 255);
        } else {
          col = color(255, 0);
        }
      }
      //Depending on pixel color places correct object
      if (random(255) <= alpha(col)) {
        col = color(red(col), green(col), blue(col), 255);
        //Places Blocks,Spikes etc.
        if (col == BRICK) {
          blocks[freeBlockIndex()].blockSetup(x, y, BRICK, false, false, false);
        }
        if (col == STONE) {
          blocks[freeBlockIndex()].blockSetup(x, y, STONE, false, false, false);
        }
        if (col == DIRT) {
          blocks[freeBlockIndex()].blockSetup(x, y, DIRT, false, false, false);
        }
        if (col == PLANKS) {
          blocks[freeBlockIndex()].blockSetup(x, y, PLANKS, false, false, false);
        }
        if (col == ICE) {
          blocks[freeBlockIndex()].blockSetup(x, y, ICE, false, false, false);
        }
        if (col == MOVING_BRICK) {
          blocks[freeBlockIndex()].blockSetup(x, y, BRICK, true, false, false);
        }
        if (col == CRACKED) {
          blocks[freeBlockIndex()].blockSetup(x, y, BRICK, false, true, false);
        }
        if (col == ALLOW_VERTICAL_MOVEMENT) {
          blocks[freeBlockIndex()].blockSetup(x, y, ALLOW_VERTICAL_MOVEMENT, false, false, true);
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
        if (col == HOSTILE_MELEE) {
          addHostileMelee(x, y);
        }
        if (col == HOSTILE_RANGED) {
          addHostileRanged(x, y);
        }
        if (col == MAGIC_SWITCH) {
          addMagicSwitch(x, y);
        }
        if (col == MAGIC1) {
          addMagic1(x, y);
        }
        if (col == MAGIC2) {
          addMagic2(x, y);
        }
      }
    }
  }
  //Adds the generated distance
  GenerateDistance += mapTemplate.width;
}
