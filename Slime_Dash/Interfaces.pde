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
    if (room == "pause2" && (inputs.hasValue(32)||inputs.hasValue(39))&&cooldown<0) {
      room = "game2";
      cooldown= COOLDOWN_MAX;
    }
    /*druk op 'p' om naar pause te gaan*/
    else if (room == "game2" && inputs.hasValue(80) && interfaces.death != true&&cooldown<0) {
      room = "pause2";
      cooldown= COOLDOWN_MAX;
    }
    /*druk op spacebar om naar game te gaan*/
    if (room == "pause" && (inputs.hasValue(32)||inputs.hasValue(39))&&cooldown<0) {
      room = "game";
      cooldown= COOLDOWN_MAX;
    }
    /*druk op 'p' om naar pause te gaan*/
    else if (room == "game" && inputs.hasValue(80) && interfaces.death != true ) {
      room = "pause";
      // druk op q of t om naar main menu te gaan
    } else if (room == "game2" && inputs.hasValue(80) && interfaces.death != true) {
      room = "pause2";
    } else if ((room == "pause"||room =="pause2") && (inputs.hasValue(81)||inputs.hasValue(84))&&cooldown<0) {
      cooldown= COOLDOWN_MAX;
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
    textSize(main.tekstSize[2]);
    fill(255, 0, 0);
    textAlign(LEFT);
    text("A", main.tekstX, main.tekstY*2.8);
    fill(0);
    text("  " +"Continue", main.tekstX, main.tekstY*2.8);
    //yellow back
    fill(255, 255, 0);
    text("B", main.tekstX*2, main.tekstY*2.8);
    fill(0);
    text("  "+"Menu", main.tekstX*2, main.tekstY*2.8);
  }
}

//main Menu///////////////////////
void mainMSetup() {
  main = new MainM();
}
MainM main;

class MainM {

  float sizeW, sizeH, tekstX, tekstY;
  int  select1, select2;
  color highlight;
  float[] tekstSize = new float[3];
  MainM() {

    sizeH = height/7;
    sizeW = width/2.8;
    background(0);
    tekstSize[0] = 75;
    tekstSize[1] = 50;
    tekstSize[2] = 40;    
    tekstX = width/4;
    tekstY = height/3;
    highlight = color(255);
    select1 = highlight;
    select2 = 180;
  }
  void update() {

    if (select1 == highlight) {
      tekstSize[0] =75;
      tekstSize[1] =50;
    }//Down in het menu
    if (select1 == highlight&&keyCode==40 ) {
      select1 = 180;
      select2 = highlight;
    }
    if (select2 == highlight) {
      tekstSize[1]= 75;
      tekstSize[0]= 50;
    }//Up in het menu
    if (select2 == highlight&&keyCode==38 ) {
      select2 = 180;
      select1 = highlight;
    }

    // spatie om naar andere rooms te gaan
    if (select1==highlight&&room == "mainM" && keyCode ==32&&cooldown<0) {
      room = "difficulty";
      SpeedUp.play();
      cooldown= COOLDOWN_MAX;
    }
    if (select2==highlight &&room == "mainM" && keyCode ==32&&cooldown<0) {
      room = "upgrades";
      cooldown= COOLDOWN_MAX;
    }
  }
  void draw() {
    //text
    textAlign(LEFT, CENTER);
    textSize(tekstSize[2]/2);
    textSize(tekstSize[0]);
    fill(select1);
    text("Play", tekstX, tekstY);
    textSize(tekstSize[1]);
    fill(select2);
    text("Upgrades", tekstX, tekstY*1.5);
    textSize(tekstSize[2]);
    fill(255, 0, 0);
    text("A", main.tekstX, main.tekstY*2.8);
    fill(0);
    text("  " +"Select", main.tekstX, main.tekstY*2.8);
    image(slimeDash, width/4, height/100, width/3, height/3);
  }
}

void upgradeSetup() {
  upgrade = new Upgrades();
}
Upgrades upgrade;

class Upgrades {
  int perchW = 320, perchH = 213, yOffset = perchH/2, xOffset=perchW/8, 
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
    if (keyCode ==81&&cooldown<0) {
      room= "mainM";
      cooldown=COOLDOWN_MAX;
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
    textSize(main.tekstSize[2]);
    fill(255, 0, 0);
    text("A", main.tekstX, main.tekstY*2.8);
    fill(0);
    text("  " +"Select", main.tekstX, main.tekstY*2.8);
    fill(255, 255, 0);
    text("B", main.tekstX*2, main.tekstY*2.8);
    fill(0);
    text("  "+"Back", main.tekstX*2, main.tekstY*2.8);
  }
}
////////////////// difficultekstY scherm//////////////

void difSetup() {
  dif = new DIF();
}
DIF dif;

class DIF {
  float sizeW, sizeH, tekstX, tekstY;
  int  select1, select2;
  color highlight;
  PImage slimeDash;
  float[] tekstSize = new float[3];

  DIF() {
    textFont(font);
    sizeH = height/7;
    sizeW = width/2.8;
    background(0);
    tekstSize[0] = 75;
    tekstSize[1] = 50;
    tekstSize[2] = 40;    
    tekstX = width/4;
    tekstY = height/3;
    highlight = color(255);
    select1 = highlight;
    select2 = 180;
  }
  void update() {
    if (select1 == highlight) {
      tekstSize[0] =75;
      tekstSize[1] =50;
    }//naar beneden in menu
    if (select1 == highlight&&keyCode==40) {
      select1 = 180;
      select2 = highlight;
    }
    if (select2 == highlight) {
      tekstSize[1]= 75;
      tekstSize[0]= 50;
    }//naar boven in het menu
    if (select2 == highlight&&keyCode==38) {
      select2 = 180;
      select1 = highlight;
    }//q om terug te gaan
    if (keyCode ==81&&cooldown<0) {
      room= "mainM";
      cooldown=COOLDOWN_MAX;
    }//normal game
    if (select1==highlight&&room == "difficulty" && inputs.hasValue(32)&&cooldown<0 ) {
      room = "game";
      SpeedUp.play();
      cooldown=COOLDOWN_MAX;
    }//tutorial game
    if (select2==highlight &&room == "difficulty" && inputs.hasValue(32)&&cooldown<0) {
      room = "game2";
      SpeedUp.play();
      cooldown=COOLDOWN_MAX;
    }
  }
  void draw() {
    //text
    textAlign(LEFT, CENTER);
    textSize(tekstSize[2]/2);
    textSize(tekstSize[0]);
    fill(select1);
    text("Normal Mode", tekstX, tekstY);
    textSize(tekstSize[1]);
    fill(select2);
    text("Tutorial Mode", tekstX, tekstY*1.5);
    textSize(tekstSize[2]);
    fill(255, 0, 0);
    text("A", main.tekstX, main.tekstY*2.8);
    fill(0);
    text("  " +"Select", main.tekstX, main.tekstY*2.8);
    //yellow back
    fill(255, 255, 0);
    text("B", tekstX*2, tekstY*2.8);
    fill(0);
    text("  "+"Back", tekstX*2, tekstY*2.8);
  }
}
