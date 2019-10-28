//Mats
/*
Alle mogelijke strings
 "  " nothing
 "BD" ("B"lock "D"efault)
 "BI" ("B"lock "I"ce)
 "BM" ("B"lock "M"oving)
 "SD" ("S"pike "D"efault)
 "PC" ("P"ickup "C"oin)
 "PH" ("P"ickup "H"ealth)
 "H1" ("H"ostile "1")
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
  mapTemplateList.add(quickJump());
  mapTemplateList.add(easywalk());
  mapTemplateList.add(iceBoost());
}
String[][] mapTemplateExample() {
  int exampleHeight = 12;
  int exampleWidth = 10;
  String[][] mapTemplateExample = new String[exampleHeight][exampleWidth];
  //                                     0     1     2     3     4     5     6     7     8     9
  mapTemplateExample[0] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  mapTemplateExample[1] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  mapTemplateExample[2] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  mapTemplateExample[3] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  mapTemplateExample[4] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  mapTemplateExample[5] = new String[] {"  ", "  ", "  ", "  ", "PH", "  ", "PC", "  ", "  ", "  "};
  mapTemplateExample[6] = new String[] {"BD", "BM", "  ", "  ", "BI", "BI", "BI", "BI", "  ", "  "};
  mapTemplateExample[7] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  mapTemplateExample[8] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  mapTemplateExample[9] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD"};
  mapTemplateExample[10] =new String[] {"  ", "  ", "SD", "  ", "  ", "  ", "  ", "  ", "  ", "BD"};
  mapTemplateExample[11] =new String[] {"BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD"};
  if (random(2) > 2) {
    mapTemplateExample[10][8] = "H1";
  }
  return mapTemplateExample;
}

String[][] theBigS() {
  int exampleHeight = 12;
  int exampleWidth = 16;
  String[][] theBigS = new String[exampleHeight][exampleWidth];
  //                          0     1     2     3     4     5     6     7     8     9     10    11    12    13    14    15
  theBigS[0] = new String[] {"  ", "  ", "  ", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "  ", "  ", "  ", "  "};
  theBigS[1] = new String[] {"  ", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  theBigS[2] = new String[] {"  ", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  theBigS[3] = new String[] {"  ", "  ", "  ", "BD", "  ", "  ", "BD", "BD", "BD", "BD", "BD", "BD", "  ", "  ", "  ", "  "};
  theBigS[4] = new String[] {"  ", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  "};
  theBigS[5] = new String[] {"  ", "  ", "  ", "BD", "  ", "  ", "  ", "PC", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  "};
  theBigS[6] = new String[] {"  ", "  ", "  ", "BD", "BD", "BD", "BD", "BD", "BD", "  ", "  ", "BD", "  ", "  ", "SD", "SD"};
  theBigS[7] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "BD", "BD"};
  theBigS[8] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  "};
  theBigS[9] = new String[] {"  ", "  ", "  ", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "  ", "  ", "  ", "  "};
  theBigS[10] =new String[] {"  ", "  ", "SD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "  ", "  ", "PC", "  "};
  theBigS[11] =new String[] {"BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD"};
  if (random(2) > 1) {
    theBigS[2][7] = "H1";
  }
  return theBigS;
}

String[][] rockyPath() {
  int exampleHeight = 12;
  int exampleWidth = 16;
  String[][] rockyPath = new String[exampleHeight][exampleWidth];
  //                            0     1     2     3     4     5     6     7     8     9     10    11    12    13    14    15
  rockyPath[0] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  rockyPath[1] = new String[] {"  ", "PC", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  rockyPath[2] = new String[] {"  ", "BD", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  rockyPath[3] = new String[] {"  ", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  rockyPath[4] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  rockyPath[5] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  rockyPath[6] = new String[] {"  ", "  ", "  ", "  ", "BD", "BD", "  ", "  ", "  ", "SD", "  ", "  ", "BD", "SD", "  ", "  "};
  rockyPath[7] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "BD", "BD", "SD", "  "};
  rockyPath[8] = new String[] {"  ", "BD", "BD", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "BD", "BD"};
  rockyPath[9] = new String[] {"  ", "BD", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "BD", "BD", "BD", "  ", "  ", "  "};
  rockyPath[10] =new String[] {"BD", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "BD", "  ", "  "};
  rockyPath[11] =new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "BD", "BD"};
  return rockyPath;
}

String[][] spikeyTower() {
  int exampleHeight = 12;
  int exampleWidth = 16;
  String[][] spikeyTower = new String[exampleHeight][exampleWidth];
  //                              0     1     2     3     4     5     6     7     8     9     10    11    12    13    14    15
  spikeyTower[0] = new String[] {"  ", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "  ", "  ", "  ", "  ", "  ", "  "};
  spikeyTower[1] = new String[] {"  ", "BD", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "  ", "  "};
  spikeyTower[2] = new String[] {"  ", "BD", "  ", "  ", "  ", "  ", "  ", "PC", "  ", "BD", "  ", "  ", "  ", "  ", "  ", "  "};
  spikeyTower[3] = new String[] {"  ", "BD", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "  ", "  "};
  spikeyTower[4] = new String[] {"  ", "BD", "  ", "  ", "  ", "  ", "SD", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "  ", "  "};
  spikeyTower[5] = new String[] {"  ", "BD", "  ", "  ", "BD", "BD", "BD", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "  ", "  "};
  spikeyTower[6] = new String[] {"  ", "BD", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "  ", "  "};
  spikeyTower[7] = new String[] {"  ", "BD", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "BD", "PC", "  ", "  ", "  ", "  ", "BD"};
  spikeyTower[8] = new String[] {"  ", "BD", "BD", "  ", "  ", "BD", "  ", "  ", "BD", "BD", "BD", "  ", "  ", "  ", "  ", "  "};
  spikeyTower[9] = new String[] {"  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "  ", "  "};
  spikeyTower[10] =new String[] {"  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  spikeyTower[11] =new String[] {"BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "  ", "  ", "  ", "  "};
  return spikeyTower;
}

String[][] spikeFall() {
  int exampleHeight = 12;
  int exampleWidth = 10;
  String[][] spikeFall = new String[exampleHeight][exampleWidth];
  //                            0     1     2     3     4     5     6     7     8     9     10    11    12    13    14    15
  spikeFall[0] = new String[] {"BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "  ", "  ", "  ", "  ", "  ", "  "};
  spikeFall[1] = new String[] {"BD", "PH", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "  ", "  "};
  spikeFall[2] = new String[] {"BD", "BD", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "  ", "  "};
  spikeFall[3] = new String[] {"  ", "BD", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "  ", "  "};
  spikeFall[4] = new String[] {"  ", "BD", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "  ", "  "};
  spikeFall[5] = new String[] {"  ", "BD", "  ", "BD", "BD", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "  ", "  "};
  spikeFall[6] = new String[] {"  ", "BD", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "  ", "  "};
  spikeFall[7] = new String[] {"  ", "BD", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "BD", "  ", "  "};
  spikeFall[8] = new String[] {"  ", "BD", "BD", "  ", "BD", "SD", "  ", "  ", "SD", "BD", "  ", "  ", "  ", "BD", "  ", "  "};
  spikeFall[9] = new String[] {"  ", "  ", "  ", "  ", "BD", "BD", "  ", "  ", "BD", "BD", "  ", "  ", "BD", "BD", "  ", "  "};
  spikeFall[10] =new String[] {"  ", "  ", "  ", "  ", "BD", "PC", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "BD", "  ", "  "};
  spikeFall[11] =new String[] {"BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "  ", "  "};

  return spikeFall;
}

String[][] floatingPath() {
  int exampleHeight = 12;
  int exampleWidth = 10;
  String[][] floatingPath = new String[exampleHeight][exampleWidth];
  //                               0     1     2     3     4     5     6     7     8     9     10    11    12    13    14
  floatingPath[0] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  floatingPath[1] = new String[] {"  ", "  ", "  ", "  ", "  ", "PH", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  "};
  floatingPath[2] = new String[] {"  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  "};
  floatingPath[3] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "  ", "BD", "  ", "  ", "  ", "  "};
  floatingPath[4] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  "};
  floatingPath[5] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  "};
  floatingPath[6] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "BD", "  ", "  ", "  ", "  "};
  floatingPath[7] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "BD", "  ", "  ", "  ", "  "};
  floatingPath[8] = new String[] {"  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "BD"};
  floatingPath[9] = new String[] {"  ", "  ", "  ", "BD", "BD", "  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "BD"};
  floatingPath[10]= new String[] {"  ", "BD", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "BD"};
  floatingPath[11]= new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "BD"};
  return floatingPath;
}

String[][] quickJump() {
  int exampleHeight = 12;
  int exampleWidth = 10;
  String[][] quickJump = new String[exampleHeight][exampleWidth];
  //                               0     1     2     3     4     5     6     7     8     9     10    11    12    13    14
  quickJump[0] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  quickJump[1] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  quickJump[2] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  quickJump[3] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  quickJump[4] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  quickJump[5] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  quickJump[6] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  quickJump[7] = new String[] {"  ", "  ", "  ", "  ", "BI", "  ", "  ", "  ", "BI", "  ", "  ", "  ", "BD", "  ", "  "};
  quickJump[8] = new String[] {"  ", "BI", "  ", "  ", "BD", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "BD", "BD", "  "};
  quickJump[9] = new String[] {"  ", "BD", "  ", "  ", "BD", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "BD", "BD", "BD"};
  quickJump[10]= new String[] {"  ", "BD", "  ", "  ", "BD", "BD", "  ", "  ", "BD", "BD", "  ", "  ", "BD", "BD", "BD"};
  quickJump[11]= new String[] {"BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD"};
  return quickJump;
}

String[][] easywalk() {
  int exampleHeight = 12;
  int exampleWidth = 10;
  String[][] easywalk = new String[exampleHeight][exampleWidth];
  //                               0     1     2     3     4     5     6     7     8     9     10    11    12    13    14
  easywalk[0] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  easywalk[1] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  easywalk[2] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  easywalk[3] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  easywalk[4] = new String[] {"  ", "  ", "PC", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  easywalk[5] = new String[] {"  ", "  ", "BD", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  easywalk[6] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  easywalk[7] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "  ", "  "};
  easywalk[8] = new String[] {"  ", "  ", "  ", "  ", "  ", "BD", "  ", "  ", "  ", "BD", "BD", "  ", "  ", "  ", "  "};
  easywalk[9] = new String[] {"  ", "  ", "  ", "  ", "BD", "BD", "  ", "  ", "  ", "BD", "BD", "BD", "  ", "  ", "  "};
  easywalk[10]= new String[] {"  ", "  ", "  ", "BD", "BD", "BD", "SD", "SD", "SD", "BD", "BD", "BD", "BD", "  ", "  "};
  easywalk[11]= new String[] {"BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD", "BD"};
  return easywalk;
}

String[][] iceBoost() {
  int exampleHeight = 12;
  int exampleWidth = 10;
  String[][] iceBoost = new String[exampleHeight][exampleWidth];
  //                               0     1     2     3     4     5     6     7     8     9     10    11    12    13    14
  iceBoost[0] = new String[] {"  ", "BD", "  ", "  ", "  ", "  ", "BD", "BD", "BD", "BD", "BD", "  ", "  ", "  ", "  ", "  "};
  iceBoost[1] = new String[] {"  ", "BD", "  ", "  ", "  ", "SD", "  ", "  ", "  ", "PC", "PC", "  ", "  ", "  ", "  ", "  "};
  iceBoost[2] = new String[] {"  ", "BD", "  ", "  ", "  ", "BD", "BD", "BD", "BD", "BD", "BD", "  ", "  ", "  ", "  ", "  "};
  iceBoost[3] = new String[] {"  ", "BD", "  ", "  ", "  ", "  ", "BD", "PH", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  iceBoost[4] = new String[] {"  ", "BD", "BM", "  ", "  ", "  ", "BD", "BD", "BD", "BD", "BD", "BD", "  ", "  ", "  ", "  "};
  iceBoost[5] = new String[] {"  ", "BD", "  ", "  ", "  ", "  ", "BD", "BD", "BD", "BD", "BD", "  ", "  ", "  ", "  ", "  "};
  iceBoost[6] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "BD", "BD", "BD", "BD", "BD", "  ", "  ", "  ", "  ", "  "};
  iceBoost[7] = new String[] {"  ", "  ", "  ", "  ", "  ", "BD", "BD", "BD", "BD", "BD", "BD", "  ", "  ", "  ", "  ", "  "};
  iceBoost[8] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "BD", "BD", "BD", "BD", "BD", "  ", "  ", "  ", "  ", "  "};
  iceBoost[9] = new String[] {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "};
  iceBoost[10]= new String[] {"  ", "  ", "  ", "  ", "BI", "BI", "BI", "  ", "  ", "  ", "BI", "BI", "BI", "  ", "  ", "  "};
  iceBoost[11]= new String[] {"BD", "BD", "BD", "BD", "BD", "BD", "BD", "  ", "  ", "  ", "BD", "BD", "BD", "BD", "BD", "BD"};
  return iceBoost;
}
