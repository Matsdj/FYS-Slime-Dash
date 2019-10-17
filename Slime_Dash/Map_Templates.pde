//Mats
/*
Alle mogelijke strings
 "Empty"
 "Block"
 "Spike"
 "Coin1"
 "Enemy"
 "Heart"
 */
//Hier worden de mogelijke templates aan de lijst toegevoegd
void templateSetup() {
  //Clear zodat setup kan gebruikt worden om te restarten
  mapTemplateList.clear();
  mapTemplateList.add(mapTemplateExample());
  mapTemplateList.add(theBigS());
  mapTemplateList.add(rockyPath());
  mapTemplateList.add(spikeyTower());
  mapTemplateList.add(spikeFall());
  mapTemplateList.add(floatingPath());
}
String[][] mapTemplateExample() {
  int exampleHeight = 12;
  int exampleWidth = 10;
  String[][] mapTemplateExample = new String[exampleHeight][exampleWidth];
  //                                       0        1         2       3        4        5        6        7        8       9
  mapTemplateExample[0] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[1] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[2] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[3] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[4] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[5] = new String[] {"Empty", "Empty", "Empty", "Empty", "Heart", "Empty", "Coin1", "Empty", "Empty", "Empty"};
  mapTemplateExample[6] = new String[] {"Empty", "Empty", "Empty", "Empty", "Block", "Block", "Block", "Block", "Empty", "Empty"};
  mapTemplateExample[7] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[8] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[9] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block"};
  mapTemplateExample[10] =new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block"};
  mapTemplateExample[11] =new String[] {"Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block"};
  if (random(2) > 1) {
    mapTemplateExample[10][8] = "Enemy";
  }
  return mapTemplateExample;
}

String[][] theBigS() {
  int exampleHeight = 12;
  int exampleWidth = 16;
  String[][] theBigS = new String[exampleHeight][exampleWidth];
  //                                       0        1         2       3        4        5        6        7        8       9
  theBigS[0] = new String[] {"Empty", "Empty", "Empty", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Empty", "Empty", "Empty", "Empty"};
  theBigS[1] = new String[] {"Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  theBigS[2] = new String[] {"Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  theBigS[3] = new String[] {"Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Block", "Block", "Block", "Block", "Block", "Block", "Empty", "Empty", "Empty", "Empty"};
  theBigS[4] = new String[] {"Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty"};
  theBigS[5] = new String[] {"Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Coin1", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty"};
  theBigS[6] = new String[] {"Empty", "Empty", "Empty", "Block", "Block", "Block", "Block", "Block", "Block", "Empty", "Empty", "Block", "Empty", "Empty", "Spike", "Spike"};
  theBigS[7] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Block", "Block"};
  theBigS[8] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty"};
  theBigS[9] = new String[] {"Empty", "Empty", "Empty", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Empty", "Empty", "Empty", "Empty"};
  theBigS[10] =new String[] {"Empty", "Empty", "Spike", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Empty", "Empty", "Coin1", "Empty"};
  theBigS[11] =new String[] {"Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block"};
  if (random(2) > 1) {
    theBigS[2][7] = "Enemy";
  }
  return theBigS;
}

String[][] rockyPath() {
  int exampleHeight = 12;
  int exampleWidth = 16;
  String[][] rockyPath = new String[exampleHeight][exampleWidth];
  //                                       0        1         2       3        4        5        6        7        8       9
  rockyPath[0] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  rockyPath[1] = new String[] {"Empty", "Coin1", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  rockyPath[2] = new String[] {"Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  rockyPath[3] = new String[] {"Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  rockyPath[4] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  rockyPath[5] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  rockyPath[6] = new String[] {"Empty", "Empty", "Empty", "Empty", "Block", "Block", "Empty", "Empty", "Empty", "Spike", "Empty", "Empty", "Block", "Spike", "Empty", "Empty"};
  rockyPath[7] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Block", "Block", "Spike", "Empty"};
  rockyPath[8] = new String[] {"Empty", "Block", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Block", "Block"};
  rockyPath[9] = new String[] {"Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Block", "Block", "Block", "Empty", "Empty", "Empty"};
  rockyPath[10] =new String[] {"Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Block", "Empty", "Empty"};
  rockyPath[11] =new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Block", "Block"};
  return rockyPath;
}

String[][] spikeyTower() {
  int exampleHeight = 12;
  int exampleWidth = 16;
  String[][] spikeyTower = new String[exampleHeight][exampleWidth];
  //                                       0        1         2       3        4        5        6        7        8       9
  spikeyTower[0] = new String[] {"Empty", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  spikeyTower[1] = new String[] {"Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  spikeyTower[2] = new String[] {"Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Coin1", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  spikeyTower[3] = new String[] {"Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  spikeyTower[4] = new String[] {"Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Spike", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  spikeyTower[5] = new String[] {"Empty", "Block", "Empty", "Empty", "Block", "Block", "Block", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  spikeyTower[6] = new String[] {"Empty", "Block", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  spikeyTower[7] = new String[] {"Empty", "Block", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Block", "Coin1", "Empty", "Empty", "Empty", "Empty", "Block"};
  spikeyTower[8] = new String[] {"Empty", "Block", "Block", "Empty", "Empty", "Block", "Empty", "Empty", "Block", "Block", "Block", "Empty", "Empty", "Empty", "Empty", "Empty"};
  spikeyTower[9] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty"};
  spikeyTower[10] =new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  spikeyTower[11] =new String[] {"Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Empty", "Empty", "Empty", "Empty"};
  return spikeyTower;
}

String[][] spikeFall() {
  int exampleHeight = 12;
  int exampleWidth = 10;
  String[][] spikeFall = new String[exampleHeight][exampleWidth];
  //                                       0        1         2       3        4        5        6        7        8       9
  spikeFall[0] = new String[] {"Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  spikeFall[1] = new String[] {"Block", "Heart", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  spikeFall[2] = new String[] {"Block", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  spikeFall[3] = new String[] {"Empty", "Block", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  spikeFall[4] = new String[] {"Empty", "Block", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  spikeFall[5] = new String[] {"Empty", "Block", "Empty", "Block", "Block", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  spikeFall[6] = new String[] {"Empty", "Block", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  spikeFall[7] = new String[] {"Empty", "Block", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Block", "Empty", "Empty"};
  spikeFall[8] = new String[] {"Empty", "Block", "Block", "Empty", "Block", "Spike", "Empty", "Empty", "Spike", "Block", "Empty", "Empty", "Empty", "Block", "Empty", "Empty"};
  spikeFall[9] = new String[] {"Empty", "Empty", "Empty", "Empty", "Block", "Block", "Empty", "Empty", "Block", "Block", "Empty", "Empty", "Block", "Block", "Empty", "Empty"};
  spikeFall[10] =new String[] {"Empty", "Empty", "Empty", "Empty", "Block", "Coin1", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Block", "Empty", "Empty"};
  spikeFall[11] =new String[] {"Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Empty", "Empty"};

  return spikeFall;
}

String[][] floatingPath() {
  int exampleHeight = 12;
  int exampleWidth = 10;
  String[][] floatingPath = new String[exampleHeight][exampleWidth];
  //                                       0        1         2       3        4        5        6        7        8       9
  floatingPath[0] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  floatingPath[1] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Heart", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty"};
  floatingPath[2] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty"};
  floatingPath[3] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Block", "Empty", "Empty", "Empty", "Empty"};
  floatingPath[4] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty"};
  floatingPath[5] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty"};
  floatingPath[6] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Block", "Empty", "Empty", "Empty", "Empty"};
  floatingPath[7] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty"};
  floatingPath[8] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Block"};
  floatingPath[9] = new String[] {"Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Block"};
  floatingPath[10]= new String[] {"Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Block"};
  floatingPath[11]= new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty"};
  return floatingPath;
}
