//Mats
//hier maak ik de variabelen aan
float GenerateDistance;
ArrayList<String[][]> mapTemplateList = new ArrayList<String[][]>();
ArrayList<PImage> mapTemplateList2 = new ArrayList<PImage>();
//Setup allows for reset
void mapSetup() {
  GenerateDistance = 0;
  makeMap(false);
  // we'll have a look in the data folder
  java.io.File templates = new java.io.File(dataPath("templates"));
  // list the files in the data folder
  String[] filenames = templates.list();
  //println(filenames.length + " files in specified directory");
}
//Looks if it has generated to the edge of the screen
void mapUpdate() {
  if (GenerateDistance < width/globalScale*1.5) {
    makeMap(true);
  }
  GenerateDistance-=globalScrollSpeed/globalScale;
}
//Adds a new template behind the last generated one
void makeMap(boolean random) {
  //Adds Template to list
  templateSetup();
  String[][] mapTemplate = mapTemplateList.get(0);
  if (random == true) {
    //Grabs random Template
    mapTemplate = mapTemplateList.get(floor(random(mapTemplateList.size())));
  }
  //Loops through list and places blocks at the correct place
  for (int templateY = 0; templateY < mapTemplate.length; templateY++) {
    for (int templateX = 0; templateX < mapTemplate[templateY].length; templateX++) {
      //Determines wat the X and Y of the blocks
      float x = (GenerateDistance+templateX)*globalScale, 
        y = templateY*globalScale;
      //Places Blocks,Spikes etc.
      if (mapTemplate[templateY][templateX] == "BD") {
        blocks[freeBlockIndex()].blockSetup(x,y, BLOCKCOLOR, false);
      }
      if (mapTemplate[templateY][templateX] == "BI") {
        blocks[freeBlockIndex()].blockSetup(x,y, ICECOLOR, false);
      }
      if (mapTemplate[templateY][templateX] == "BM") {
        blocks[freeBlockIndex()].blockSetup(x,y, BLOCKCOLOR, true);
      }
      if (mapTemplate[templateY][templateX] == "SD") {
        addSpike(x, y);
      }
      if (mapTemplate[templateY][templateX] == "FD") {
        addFlame(x, y);
      }
      if (mapTemplate[templateY][templateX] == "PC") {
        addCoin(x, y);
      }
      if (mapTemplate[templateY][templateX] == "PH") {
        addHeart(x, y);
      }
      if (mapTemplate[templateY][templateX] == "HM") {
        addHostileMelee(x, y);
      }
      if (mapTemplate[templateY][templateX] == "HR") {
        addHostileRanged(x, y);
      }
    }
  }
  //Adds the generated distance
  GenerateDistance += mapTemplate[0].length;
}
