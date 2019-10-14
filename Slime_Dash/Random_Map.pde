//Mats
//hier maak ik de lijsten aan
float GenerateDistance;
//Makes a line of blocks at the bottom of the screen
ArrayList<String[][]> mapTemplateList = new ArrayList<String[][]>();
void mapSetup() {
  GenerateDistance = 0;
  makeMap();
}

void mapUpdate() {
  if (GenerateDistance < width/1.2/globalScale) {
    makeMap();
  }
  GenerateDistance-=globalScrollSpeed/globalScale;
}
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
        //
      }
      if (mapTemplate[templateY][templateX] == "Coin1") {
        CoinList[10] = new PCoin(x, y);
      }
      if (mapTemplate[templateY][templateX] == "Heart") {
        HealthList[10] = new PHealth(x, y);
      }
      if (mapTemplate[templateY][templateX] == "Enemy") {
        addHostile(x,y);
      }
    }
  }
  GenerateDistance += mapTemplate[0].length;
}
