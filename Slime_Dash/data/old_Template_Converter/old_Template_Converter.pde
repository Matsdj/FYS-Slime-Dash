//Mats
//hier maak ik de variabelen aan
PImage img;
//createGraphics
PGraphics pg;
//All Final variables
final color BRICK = color(150, 150, 150);
final color STONE = color(200, 200, 200);
final color DIRT = color(150, 100, 0);
final color PLANKS = color(200, 150, 100);
final color MOVINGBRICK = color(170, 170, 170);
final int SCROLLBLOCKRED = 6; //vul bij rood 1, bij groen 1 of 0 (percentage ja of nee), en bij blauw de hoeveelheid.
final color ICE = color(0, 255, 255);
final color SPIKE = color(255, 0, 0);
final color FLAME = color(255, 150, 0);
final color COIN = color(255, 255, 0);
final color HEALTH = color(0, 255, 0);
final color HOSTILEMELEE = color(255, 0, 100);
final color HOSTILERANGED = color(255, 0, 150);
void setup() {
  templateSetup();
  for (int i = 0; i < mapTemplateListOLD.size(); i++) {
    String[][] mapTemplate = mapTemplateListOLD.get(i);
    img = createImage(mapTemplate[0].length, mapTemplate.length+1, ARGB);
    img.loadPixels();
    //Loops through list and places blocks at the correct place
    for (int templateY = 0; templateY < mapTemplate.length; templateY++) {
      for (int templateX = 0; templateX < mapTemplate[templateY].length; templateX++) {
        //Determines wat the X and Y of the blocks
        int x = templateX, 
          y = templateY, 
          loc = x + (y * mapTemplate[templateY].length);
        //Places Blocks,Spikes etc.
        if (mapTemplate[templateY][templateX] == "BD") {
          img.pixels[loc] = BRICK;
        }
        if (mapTemplate[templateY][templateX] == "BI") {
          img.pixels[loc] = ICE;
        }
        if (mapTemplate[templateY][templateX] == "BM") {
          img.pixels[loc] = MOVINGBRICK;
        }
        if (mapTemplate[templateY][templateX] == "SD") {
          img.pixels[loc] = SPIKE;
        }
        if (mapTemplate[templateY][templateX] == "FD") {
          img.pixels[loc] = FLAME;
        }
        if (mapTemplate[templateY][templateX] == "PC") {
          img.pixels[loc] = COIN;
        }
        if (mapTemplate[templateY][templateX] == "PH") {
          img.pixels[loc] = HEALTH;
        }
        if (mapTemplate[templateY][templateX] == "HM") {
          img.pixels[loc] = HOSTILEMELEE;
        }
        if (mapTemplate[templateY][templateX] == "HR") {
          img.pixels[loc] = HOSTILERANGED;
        }
      }
    }
    pg = createGraphics(img.width, img.height);
    pg.beginDraw();
    pg.background(255, 0);
    pg.image(img, 0, 0);
    pg.endDraw();
    pg.save(i+".png");
  }
}
