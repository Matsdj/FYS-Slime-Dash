//Mats
//hier maak ik de variabelen aan
float GenerateDistance;
ArrayList<String[][]> mapTemplateList = new ArrayList<String[][]>();
//Setup allows for reset
void mapSetup() {
  GenerateDistance = 0;
  makeMap();
}
//Looks if it has generated to the edge of the screen
void mapUpdate() {
  if (GenerateDistance < width/globalScale) {
    makeMap();
  }
  GenerateDistance-=globalScrollSpeed/globalScale;
}
//Adds a new template behind the last generated one
void makeMap() {
  templateSetup();
  String[][] mapTemplate = mapTemplateList.get(floor(random(mapTemplateList.size())));
  for (int templateY = 0; templateY < mapTemplate.length; templateY++) {
    for (int templateX = 0; templateX < mapTemplate[templateY].length; templateX++) {
      float x = (GenerateDistance+templateX)*globalScale, 
        y = templateY*globalScale;
      if (mapTemplate[templateY][templateX] == "Block") {
        blocks.add(new Block(x, y));
      }
      if (mapTemplate[templateY][templateX] == "Spike") {
        addspike(x,y);
      }
      if (mapTemplate[templateY][templateX] == "Coin1") {
        addCoin(x,y);
      }
      if (mapTemplate[templateY][templateX] == "Heart") {
        addHeart(x,y);
      }
      if (mapTemplate[templateY][templateX] == "Enemy") {
        addHostile(x,y);
      }
    }
  }
  GenerateDistance += mapTemplate[0].length;
}
