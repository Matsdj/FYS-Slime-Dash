//Mats
/*
Alle mogelijke strings    ColorID
 "BD" ("B"lock "D"efault) 150,150,150
 "BI" ("B"lock "I"ce)     0,255,255
 "BM" ("B"lock "M"oving)  170,170,170
 "SD" ("S"pike "D"efault) 255,0,0
 "FD" ("F"lame "D"efault) 255,150,0
 "PC" ("P"ickup "C"oin)   255,255,0
 "PH" ("P"ickup "H"ealth) 0,255,0
 "HM" ("H"ostile "M"elee) 255,0,100
 "HR" ("H"ostile "R"anged)255,0,150
*/
ArrayList<String[][]> mapTemplateListOLD = new ArrayList<String[][]>();
//Hier worden de mogelijke templates aan de lijst toegevoegd
void templateSetup() {
  //Clear zodat setup kan gebruikt worden om te restarten
  mapTemplateListOLD.clear();
  mapTemplateListOLD.add(mapTemplateExample());
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
  if (random(2) > 1) {
    mapTemplateExample[10][8] = "HM";
  }
  return mapTemplateExample;
}
