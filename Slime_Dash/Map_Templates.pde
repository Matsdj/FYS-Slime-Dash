//Mats
/*
Alle mogelijke strings
 "Empty"
 "Block"
 "Spike"
 "Coin1"
 */
String[][] mapTemplateExample() {
  int exampleHeight = 12;
  int exampleWidth = 10;
  String[][] mapTemplateExample = new String[exampleHeight][exampleWidth];
  //                                       1        2         3       4        5        6        7        8        9       10
  mapTemplateExample[0] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[1] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[2] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[3] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[4] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[5] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[6] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[7] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[8] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[9] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[10] =new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[11] =new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[12] =new String[] {"Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block"};
  if (random(2) > 1) {
    mapTemplateExample[11][9] = "enemy";
  }
  return mapTemplateExample;
}
