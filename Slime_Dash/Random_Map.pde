//Mats
//hier maak ik de variabelen aan
float GenerateDistance;
ArrayList<String[][]> mapTemplateList = new ArrayList<String[][]>();
//Setup allows for reset
void mapSetup() {
  GenerateDistance = 0;
  makeMap(false);
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
  if (random == true){
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
        blocks.add(new Block(x, y));
      }
      if (mapTemplate[templateY][templateX] == "BI") {
        blocks.add(new Block(x, y, ICECOLOR));
      }
      if (mapTemplate[templateY][templateX] == "BM") {
        blocks.add(new Block(x, y, true));
      }
      if (mapTemplate[templateY][templateX] == "SD") {
        addspike(x,y);
      }
      if (mapTemplate[templateY][templateX] == "FD") {
        addflame(x,y);
      }
      if (mapTemplate[templateY][templateX] == "PC") {
        addCoin(x,y);
      }
      if (mapTemplate[templateY][templateX] == "PH") {
        addHeart(x,y);
      }
      if (mapTemplate[templateY][templateX] == "HM") {
        addHostile(x,y);
      }
      if (mapTemplate[templateY][templateX] == "HR") {
        addHostileMelee(x,y);
      }
    }
  }
  //Adds the generated distance
  GenerateDistance += mapTemplate[0].length;
}
