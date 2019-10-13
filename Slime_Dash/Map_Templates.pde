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
  //                                       0        1         2       3        4        5        6        7        8       9
  mapTemplateExample[0] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[1] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[2] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[3] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[4] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[5] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[6] = new String[] {"Empty", "Empty", "Empty", "Empty", "Block", "Block", "Block", "Block", "Empty", "Empty"};
  mapTemplateExample[7] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[8] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample[9] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Coin1"};
  mapTemplateExample[10] =new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Heart", "Empty", "Empty", "Empty", "Block"};
  mapTemplateExample[11] =new String[] {"Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block"};
  if (random(2) > 1) {
    mapTemplateExample[10][8] = "enemy";
  }
  return mapTemplateExample;
}

String[][] mapTemplateExample2() {
  int exampleHeight = 12;
  int exampleWidth = 16;
  String[][] mapTemplateExample2 = new String[exampleHeight][exampleWidth];
  //                                       0        1         2       3        4        5        6        7        8       9
  mapTemplateExample2[0] = new String[] {"Empty", "Empty", "Empty", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample2[1] = new String[] {"Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample2[2] = new String[] {"Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample2[3] = new String[] {"Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Block", "Block", "Block", "Block", "Block", "Block", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample2[4] = new String[] {"Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample2[5] = new String[] {"Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Coin1", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample2[6] = new String[] {"Empty", "Empty", "Empty", "Block", "Block", "Block", "Block", "Block", "Block", "Empty", "Empty", "Block", "Empty", "Empty", "Spike", "Spike"};
  mapTemplateExample2[7] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Block", "Block"};
  mapTemplateExample2[8] = new String[] {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Block", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample2[9] = new String[] {"Empty", "Empty", "Empty", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Empty", "Empty", "Empty", "Empty"};
  mapTemplateExample2[10] =new String[] {"Empty", "Spike", "Spike", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Empty", "Empty", "Coin1", "Empty"};
  mapTemplateExample2[11] =new String[] {"Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block", "Block"};
  if (random(2) > 1) {
    mapTemplateExample2[2][7] = "enemy";
  }
  return mapTemplateExample2;
}
