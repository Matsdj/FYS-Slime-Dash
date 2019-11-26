//Laurens

/*
/NAVIGATIE/
 P = pauze (START)
 Q = terug (B)
 SPACE = verder (A)
 */
//PAUSE//////////////////////////////////////////
void pauseSetup() {
  pause = new Pause();
}
Pause pause;

class Pause {
  float pauseV, fade;
  Pause() {
    //fade voor pause
    fade = 2;
    pauseV +=fade;
  }

  void update() {
    /*druk op spacebar om naar game te gaan*/
    if (room == "pause2" && (inputs.hasValue(32)||inputs.hasValue(39))) {
      room = "game2";
    }
    /*druk op 'p' om naar pause te gaan*/
    else if (room == "game2" && inputs.hasValue(80) && interfaces.death != true) {
      room = "pause2";
    }
    /*druk op spacebar om naar game te gaan*/
    if (room == "pause" && (inputs.hasValue(32)||inputs.hasValue(39))) {
      room = "game";
    }
    /*druk op 'p' om naar pause te gaan*/
    else if (room == "game" && inputs.hasValue(80) && interfaces.death != true) {
      room = "pause";
      // druk op q of t om naar main menu te gaan
    } else if (room == "game2" && inputs.hasValue(80) && interfaces.death != true) {
      room = "pause2";
    } else if ((room == "pause"||room =="pause2") && (inputs.hasValue(81)||inputs.hasValue(84))) {
      GameSlow.stop();
      GameMid.stop();
      GameFast.stop();
      setup();
      room = "mainM";
      march0=true;
      march1=true;
      march2=true;
      march3=true;
    }

    if (pauseV >=20) {
      pauseV +=0;
    }
  }

  void draw() {
    fill(0, 0, 0, pauseV);
    rect(0, 0, width, height);
    fill(255);
    textAlign(CENTER);
    textSize(100);
    text("PAUSED", width/2, height/4);
    textSize(60);
    text("Score "+ floor(interfaces.score), width/2, height/2);
    text("Coins "+ floor(interfaces.coins), width/2, height/1.6);
    textSize(main.tSize3);
    fill(255, 0, 0);
    textAlign(LEFT);
    text("A", main.tx, main.ty*2.8);
    fill(0);
    text("  " +"Continue", main.tx, main.ty*2.8);
    //yellow back
    fill(255, 255, 0);
    text("B", main.tx*2, main.ty*2.8);
    fill(0);
    text("  "+"Menu", main.tx*2, main.ty*2.8);
  }
}

//main Menu///////////////////////
void mainMSetup() {
  main = new MainM();
}
MainM main;

class MainM {
  final int COOLDOWN_MAX=30;
  int cooldown;
  float sizeW, sizeH, tx, ty, tSize1, tSize2, tSize3;
  int  c1, c2;
  color blink;

  MainM() {
    cooldown=COOLDOWN_MAX;
    sizeH = height/7;
    sizeW = width/2.8;
    background(0);
    tSize1 = 75;
    tSize2 = 50;
    tSize3 = 40;    
    tx = width/4;
    ty = height/3;
    blink = color(255);
    c1 = blink;
    c2 = 180;
  }
  void update() {
    if (cooldown>0) {
      cooldown--;
    }
    if (c1 == blink) {
      tSize1 =75;
      tSize2 =50;
    }//Down in het menu
    if (c1 == blink&&keyCode==40 ) {
      c1 = 180;
      c2 = blink;
    }
    if (c2 == blink) {
      tSize2= 75;
      tSize1= 50;
    }//Up in het menu
    if (c2 == blink&&keyCode==38 ) {
      c2 = 180;
      c1 = blink;
    }

    // spatie om naar andere rooms te gaan
    if (c1==blink&&room == "mainM" && keyCode ==32&& cooldown<=0) {
      room = "difficulty";
      SpeedUp.play();
      cooldown=COOLDOWN_MAX;
    }
    if (c2==blink &&room == "mainM" && keyCode ==32&& cooldown<=0) {
      room = "upgrades";
      cooldown=COOLDOWN_MAX;
    }
  }
  void draw() {
    //text
    textAlign(LEFT, CENTER);
    textSize(tSize3/2);
    textSize(tSize1);
    fill(c1);
    text("Play", tx, ty);
    textSize(tSize2);
    fill(c2);
    text("Upgrades", tx, ty*1.5);
    textSize(tSize3);
    fill(255, 0, 0);
    text("A", main.tx, main.ty*2.8);
    fill(0);
    text("  " +"Select", main.tx, main.ty*2.8);
    image(slimeDash, width/4, height/100, width/3, height/3);
  }
}

void upgradeSetup() {
  upgrade = new Upgrades();
}
Upgrades upgrade;

class Upgrades {
  int perchW = 320, perchH = 213, yOffset = width/12, xOffset=height/12, 
    perchLeft=width/8, perchRight=width - width/8 - perchW, 
    perchUp=height/8, perchDown=height - height/8 - perchH, 
    perchSelectX, perchSelectY;
  PImage[] perch = new PImage[4];
  int curPerch = 0;
  PImage perchTL, perchTR, perchBL, perchBR;
  PImage perchSelect;
  Upgrades() {
    perch[0] = loadImage("./sprites/menus/perch0.png");
    perch[1] = loadImage("./sprites/menus/perch1.png");
    perch[2] = loadImage("./sprites/menus/perch2.png");
    perch[3] = loadImage("./sprites/menus/perchmax.png");
    perchSelect = loadImage("./sprites/menus/perchselect.png");
    perchSelectX = perchLeft;
    perchSelectY = perchUp;
    perchTL = perch[0];
    perchTR = perch[0];
    perchBL = perch[0];
    perchBR = perch[0];
  }
  void update() {
    if (keyCode ==81) {
      room= "mainM";
    }
    if (room=="upgrades") {
      if (keyCode==40 && perchSelectY == perchUp) {
        perchSelectY = perchDown;
      }  
      if (keyCode ==38 && perchSelectY == perchDown) {
        perchSelectY = perchUp;
      }      
      if (keyCode==39 && perchSelectX == perchLeft) {
        perchSelectX = perchRight;
      }  
      if (keyCode ==37 && perchSelectX == perchRight) {
        perchSelectX = perchLeft;
      }
    }
  }
  void draw() {
    textSize(55);
    text("Upgrades", width/2.7, 50);
    textSize(25);
    //select
    image(perchSelect, perchSelectX, perchSelectY, perchW, perchH);
    //top left
    image(perchTL, perchLeft, perchUp, perchW, perchH);
    text("Double Jump", perchLeft+xOffset, perchUp+yOffset);
    //top right
    image(perchTR, perchRight, perchUp, perchW, perchH);
    textSize(23);
    text("Dash Cooldown", perchRight+xOffset, perchUp+yOffset);
    //bottom left
    textSize(25);
    image(perchBL, perchLeft, perchDown, perchW, perchH);
    text("Health", perchLeft+xOffset, perchDown+yOffset);
    //bottom right
    image(perchBR, perchRight, perchDown, perchW, perchH);
    text("Coin Value", perchRight+xOffset, perchDown+yOffset);
    textSize(main.tSize3);
    fill(255, 0, 0);
    text("A", main.tx, main.ty*2.8);
    fill(0);
    text("  " +"Select", main.tx, main.ty*2.8);
    fill(255, 255, 0);
    text("B", main.tx*2, main.ty*2.8);
    fill(0);
    text("  "+"Back", main.tx*2, main.ty*2.8);
  }
}
////////////////// difficulty scherm//////////////

void difSetup() {
  dif = new DIF();
}
DIF dif;

class DIF {
  float sizeW, sizeH, tx, ty, tSize1, tSize2, tSize3;
  int  c1, c2;
  color blink;
  PImage slimeDash;

  DIF() {
    textFont(font);
    sizeH = height/7;
    sizeW = width/2.8;
    background(0);
    tSize1 = 75;
    tSize2 = 50;
    tSize3 = 40;    
    tx = width/4;
    ty = height/3;
    blink = color(255);
    c1 = blink;
    c2 = 180;
  }
  void update() {
    //zorgt voor een blinking effect, kan waarschijnlijk efficienter :S
    if (c1 == blink) {
      tSize1 =75;
      tSize2 =50;
    }//naar beneden in menu
    if (c1 == blink&&keyCode==40) {
      c1 = 180;
      c2 = blink;
    }
    if (c2 == blink) {
      tSize2= 75;
      tSize1= 50;
    }//naar boven in het menu
    if (c2 == blink&&keyCode==38) {
      c2 = 180;
      c1 = blink;
    }//q om terug te gaan
    if (keyCode ==81) {
      room= "mainM";
    }//normal game
    if (c1==blink&&room == "difficulty" && inputs.hasValue(32) ) {
      room = "game";
      SpeedUp.play();
    }//tutorial game
    if (c2==blink &&room == "difficulty" && inputs.hasValue(32)) {
      room = "game2";
      SpeedUp.play();
    }
  }
  void draw() {
    //text
    textAlign(LEFT, CENTER);
    textSize(tSize3/2);
    textSize(tSize1);
    fill(c1);
    text("Normal Mode", tx, ty);
    textSize(tSize2);
    fill(c2);
    text("Tutorial Mode", tx, ty*1.5);
    textSize(tSize3);
    fill(255, 0, 0);
    text("A", main.tx, main.ty*2.8);
    fill(0);
    text("  " +"Select", main.tx, main.ty*2.8);
    //yellow back
    fill(255, 255, 0);
    text("B", tx*2, ty*2.8);
    fill(0);
    text("  "+"Back", tx*2, ty*2.8);
  }
}
