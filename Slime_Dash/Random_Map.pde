//Mats
//hier maak ik de lijsten aan
int GenerateDistance = 0;
//Makes a line of blocks at the bottom of the screen
ArrayList<String[][]> mapTemplateList = new ArrayList<String[][]>();
void mapSetup() {
  mapTemplateList.add(mapTemplateExample());
  String[][] mapTemplate = mapTemplateExample();
  for (int templateY = 0; templateY < mapTemplate.length; templateY++) {
    for (int templateX = 0; templateX < mapTemplate[templateY].length; templateX++) {
      float x = (GenerateDistance+templateX)*globalScale,
            y = templateY*globalScale;
      if (mapTemplate[templateY][templateX] == "Block"){
        blocks.add(new Block(x,y));
      }
      if (mapTemplate[templateY][templateX] == "Spike"){
        //blocks.add(new Spike(x,y));
      }
      if (mapTemplate[templateY][templateX] == "Coin1"){
        CoinList[10] = new PCoin(x,y);
      }
    }
  }
  GenerateDistance += mapTemplate[0].length;
}

void mapUpdate() {
  GenerateDistance = floor(player.x/globalScale);
}
