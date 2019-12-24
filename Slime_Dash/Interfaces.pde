//Laurens

/*
/NAVIGATIE/
 P = pauze (START)
 Q = terug (B)
 SPACE = verder (A)
 */
int  textNorm = 50, textBig = 75, generalTextOffset =2;

//PAUSE//////////////////////////////////////////
void pauseSetup() {
  pause = new Pause();
}
Pause pause;

class Pause {
  float pauseV, fade, pauseBackX, pauseBackY, pauseTxtY, pauseTxtX;
  Pause() {
    //fade voor pause
    fade = 2;
    pauseV +=fade;
    pauseBackX = pauseBackY = 0;
    pauseTxtX = width/2;
    pauseTxtY = height/4;
  }

  void update() {
    /*druk op spacebar om naar game te gaan*/
    if (room == "pause2" && (inputs.hasValue(keySpace)||inputs.hasValue(keyRight))&&cooldown<COOLDOWN_MIN) {
      room = "game2";
      cooldown= COOLDOWN_MAX;
    }
    /*druk op 'p' om naar pause te gaan*/
    else if (room == "game2" && inputs.hasValue(keyP) && interfaces.death == false &&cooldown<COOLDOWN_MIN) {
      room = "pause2";
      cooldown= COOLDOWN_MAX;
    }
    /*druk op spacebar om naar game te gaan*/
    if (room == "pause" && (inputs.hasValue(keySpace)||inputs.hasValue(keyRight))&&cooldown<COOLDOWN_MIN) {
      room = "game";
      cooldown= COOLDOWN_MAX;
    }
    /*druk op 'p' om naar pause te gaan*/
    else if (room == "game" && inputs.hasValue(keyP) && interfaces.death == false ) {
      room = "pause";
      // druk op q of t om naar main menu te gaan
    } else if (room == "game2" && inputs.hasValue(keyP) && interfaces.death == false) {
      room = "pause2";
    } else if ((room == "pause"||room =="pause2") && (inputs.hasValue(keyQ)||inputs.hasValue(keyT))&&cooldown<COOLDOWN_MIN) {
      cooldown= COOLDOWN_MAX;
      GameSlow.stop();
      GameMid.stop();
      GameFast.stop();
      setup();
      room = "mainM";
      march[0]=true;
      march[1]=true;
      march[2]=true;
      march[3]=true;
    }

    if (pauseV >=20) {
      pauseV +=0;
    }
  }

  void draw() {
    fill(BLACK, pauseV);
    rect(pauseBackX, pauseBackY, width, height);
    fill(WHITE);
    textAlign(CENTER);
    textSize(100);
    text("PAUSED", pauseTxtX, pauseTxtY);
    textSize(60);
    text("Score "+ floor(interfaces.score), pauseTxtX, height/2);
    text("Coins "+ floor(coins), pauseTxtX, height/1.6);
    //NAVIGATION
    textSize(main.tekstSize[2]);
    textAlign(LEFT);
    fill(BLACK);
    text("A", main.tekstX+2, main.navTextY+generalTextOffset);
    text("A", main.tekstX-2, main.navTextY-generalTextOffset);
    fill(RED);
    text("A", main.tekstX, main.navTextY);
    text("  " +"Continue", main.tekstX+2, main.navTextY+generalTextOffset);
    text("  " +"Continue", main.tekstX-2, main.navTextY-generalTextOffset);
    fill(BLACK);
    text("  " +"Continue", main.tekstX, main.navTextY);
    //YELLOW back
    fill(BLACK);
    text("B", main.tekstX*2+2, main.navTextY+generalTextOffset);
    text("B", main.tekstX*2-2, main.navTextY-generalTextOffset);
    fill(RED);
    text("B", main.tekstX*2, main.navTextY);
    text("  "+"Menu", main.tekstX*2+2, main.navTextY+generalTextOffset);
    text("  "+"Menu", main.tekstX*2-2, main.navTextY-generalTextOffset);
    fill(0);
    text("  "+"Menu", main.tekstX*2, main.navTextY);
  }
}

//main Menu///////////////////////
void mainMSetup() {
  main = new MainM();
}
MainM main;

class MainM {

  float sizeW, sizeH, tekstX, tekstY, navTextY ;
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
    highlight = color(WHITE);
    select1 = highlight;
    select2 = GREY;
    navTextY = (height/3)*2.8;
  }
  void update() {

    if (select1 == highlight) {
      tekstSize[0] =textBig;
      tekstSize[1] =textNorm;
    }//Down in het menu
    if (select1 == highlight&&keyCode==keyDown ) {
      select1 = GREY;
      select2 = highlight;
    }
    if (select2 == highlight) {
      tekstSize[1]= textBig;
      tekstSize[0]= textNorm;
    }//Up in het menu
    if (select2 == highlight&&keyCode==keyUp ) {
      select2 = GREY;
      select1 = highlight;
    }

    // spatie om naar andere rooms te gaan
    if (select1==highlight&&room == "mainM" && keyCode == keySpace &&cooldown<0) {
      room = "difficulty";
      SpeedUp.play();
      cooldown= COOLDOWN_MAX;
    }
    if (select2==highlight &&room == "mainM" && keyCode == keySpace &&cooldown<0) {
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
    fill(BLACK);
    text("A", main.tekstX+2, main.navTextY+generalTextOffset);
    text("A", main.tekstX-2, main.navTextY-generalTextOffset);
    fill(RED);
    text("A", main.tekstX, main.navTextY);
    text("  " +"Select", main.tekstX-2, main.navTextY-generalTextOffset);
    text("  " +"Select", main.tekstX+2, main.navTextY+generalTextOffset);
    fill(BLACK);
    text("  " +"Select", main.tekstX, main.navTextY);
    image(slimeDash, width/4+shake, height/100, width/3, height/3);
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
    perchSelectX, perchSelectY, 
    perchTLState, perchTRState, perchBLState, perchBRState, 
    doubleJumpPrice = 100, 
    dashPrice = 20, 
    healthPrice = 20, 
    coinPrice = 20;
  String upgradeMaxText = "UPGRADE ALREADY MAXED";
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
    perchTL = perch[perchTLState];
    perchTR = perch[perchTRState];
    perchBL = perch[perchBLState];
    perchBR = perch[perchBRState];
    perchTLState = 0;
    perchTRState = 0;
    perchBLState = 0;
    perchBRState = 0;
  }
  void update() {
    if (keyCode ==keyQ&&cooldown<COOLDOWN_MIN) {
      room= "mainM";
      cooldown=COOLDOWN_MAX;
    }
    if (room=="upgrades") {
      if (keyCode==keyDown && perchSelectY == perchUp) {
        perchSelectY = perchDown;
      }  
      if (keyCode ==keyUp && perchSelectY == perchDown) {
        perchSelectY = perchUp;
      }      
      if (keyCode==keyRight && perchSelectX == perchLeft) {
        perchSelectX = perchRight;
      }  
      if (keyCode ==keyLeft && perchSelectX == perchRight) {
        perchSelectX = perchLeft;
      }
      // ff quick coin cheat
      if (keyPressed && key == '=') {
        coins += 10;
      }
      if (perchTLState < perch.length - 1) {       
        if (inputsPressed.hasValue(keySpace) && perchSelectX == perchLeft && perchSelectY == perchUp && coins >= doubleJumpPrice) {
          perchTLState = 3;
          perchTL = perch[perchTLState];
          coins -= doubleJumpPrice;
          player.maxJumpAmount = 1;
        } else if (inputsPressed.hasValue(keySpace) && perchSelectX == perchLeft && perchSelectY == perchUp && perchTLState < 3) { 
          textAlign(CENTER);
          fill(BLACK);
          text("YOU CAN'T AFFORD THAT", width/2+generalTextOffset, height/2+generalTextOffset);
          fill(RED);
          text("YOU CAN'T AFFORD THAT", width/2, height/2);
          textAlign(LEFT, CENTER);
        }
      }
      if (perchTRState < perch.length - 1) {       
        if (inputsPressed.hasValue(keySpace) && perchSelectX == perchRight && perchSelectY == perchUp && coins >= dashPrice) {
          perchTRState++;
          perchTR = perch[perchTRState];
          cooldown = COOLDOWN_UPGRADE;
          coins -= dashPrice;
          player.dashCooldownMax += 20;
          dashPrice = dashPrice * 2;
          textAlign(CENTER);
          fill(WHITE);
          text("DASH COOLDOWN REDUCED", width/2+generalTextOffset, height/2+generalTextOffset);
          fill(BLACK);
          text("DASH COOLDOWN REDUCED", width/2, height/2);
          textAlign(LEFT, CENTER);
        } else if (inputsPressed.hasValue(keySpace) && perchSelectX == perchRight && perchSelectY == perchUp && perchTRState < 3) {
          textAlign(CENTER);
          fill(BLACK);
          text("YOU CAN'T AFFORD THAT", width/2+generalTextOffset, height/2+generalTextOffset);
          fill(RED);
          text("YOU CAN'T AFFORD THAT", width/2, height/2);
          textAlign(LEFT, CENTER);
        }
      }
      if (perchBLState < perch.length - 1) {       
        if (inputsPressed.hasValue(keySpace) && perchSelectX == perchLeft && perchSelectY == perchDown && coins >= healthPrice) {
          perchBLState++;
          perchBL = perch[perchBLState];
          cooldown = COOLDOWN_UPGRADE;
          coins -= healthPrice;
          healthPrice = healthPrice * 2;
          if (perchBLState==1)interfaces.healthMult =0.8;
          if (perchBLState==2)interfaces.healthMult =0.7;
          if (perchBLState==3)interfaces.healthMult =0.5;
          textAlign(CENTER);
          fill(WHITE);
          text("HEALTH INCREASED", width/2+generalTextOffset, height/2+generalTextOffset);
          fill(BLACK);
          text("HEALTH INCREASED", width/2, height/2);
          textAlign(LEFT, CENTER);
        } else if (inputsPressed.hasValue(keySpace) && perchSelectX == perchLeft && perchSelectY == perchDown && perchBLState < 3) {
          textAlign(CENTER);
          fill(BLACK);
          text("YOU CAN'T AFFORD THAT", width/2+generalTextOffset, height/2+generalTextOffset);
          fill(RED);
          text("YOU CAN'T AFFORD THAT", width/2, height/2);
          textAlign(LEFT, CENTER);
        }
      }
      if (perchBRState < perch.length - 1) {       
        if (inputsPressed.hasValue(keySpace) && perchSelectX == perchRight && perchSelectY == perchDown && coins >= coinPrice) {
          perchBRState++;
          perchBR = perch[perchBRState];
          cooldown = COOLDOWN_UPGRADE;
          coins -= coinPrice;
          coinValue = coinValue * 2;
          coinPrice = coinPrice * 2;
          textAlign(CENTER);
          fill(WHITE);
          text("COIN VALUE INCREASED", width/2+generalTextOffset, height/2+generalTextOffset);
          fill(BLACK);
          text("COIN VALUE INCREASED", width/2, height/2);
          textAlign(LEFT, CENTER);
        } else if (inputsPressed.hasValue(keySpace) && perchSelectX == perchRight && perchSelectY == perchDown && perchBRState < 3) {
          textAlign(CENTER);
          fill(BLACK);
          text("YOU CAN'T AFFORD THAT", width/2+generalTextOffset, height/2+generalTextOffset);
          fill(RED);
          text("YOU CAN'T AFFORD THAT", width/2, height/2);
          textAlign(LEFT, CENTER);
        }
      }
      if (inputsPressed.hasValue(keySpace) && perchSelectX == perchLeft && perchSelectY == perchUp && perchTLState == perch.length -1 ) {
        textAlign(CENTER);
        fill(WHITE);
        text(upgradeMaxText, width/2+generalTextOffset, height/2+generalTextOffset);
        fill(BLACK);
        text(upgradeMaxText, width/2, height/2);
        textAlign(LEFT, CENTER);
      }
      if (inputsPressed.hasValue(keySpace) && perchSelectX == perchRight && perchSelectY == perchUp && perchTRState == perch.length -1 ) {
        textAlign(CENTER);
        fill(WHITE);
        text(upgradeMaxText, width/2+generalTextOffset, height/2+generalTextOffset);
        fill(BLACK);
        text(upgradeMaxText, width/2, height/2);
        textAlign(LEFT, CENTER);
      }
      if (inputsPressed.hasValue(keySpace) && perchSelectX == perchLeft && perchSelectY == perchDown && perchBLState == perch.length -1 ) {
        textAlign(CENTER);
        fill(WHITE);
        text(upgradeMaxText, width/2+generalTextOffset, height/2+generalTextOffset);
        fill(BLACK);
        text(upgradeMaxText, width/2, height/2);
        textAlign(LEFT, CENTER);
      }
      if (inputsPressed.hasValue(keySpace) && perchSelectX == perchRight && perchSelectY == perchDown && perchBRState == perch.length -1 ) {
        textAlign(CENTER);
        fill(WHITE);
        text(upgradeMaxText, width/2+generalTextOffset, height/2+generalTextOffset);
        fill(BLACK);
        text(upgradeMaxText, width/2, height/2);
        textAlign(LEFT, CENTER);
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
    text("Double Jump : " + doubleJumpPrice, perchLeft+xOffset, perchUp+yOffset);
    //top right
    image(perchTR, perchRight, perchUp, perchW, perchH);
    textSize(23);
    text("Dash Cooldown : " + dashPrice, perchRight+xOffset, perchUp+yOffset);
    //bottom left
    textSize(25);
    image(perchBL, perchLeft, perchDown, perchW, perchH);
    text("Health : " + healthPrice, perchLeft+xOffset, perchDown+yOffset);
    //bottom right
    image(perchBR, perchRight, perchDown, perchW, perchH);
    text("Coin Value : " + coinPrice, perchRight+xOffset, perchDown+yOffset);
    textSize(main.tekstSize[2]);
    fill(BLACK);
    text("A", main.tekstX+generalTextOffset, main.navTextY+generalTextOffset);
    text("A", main.tekstX-generalTextOffset, main.navTextY-generalTextOffset);
    fill(RED);
    text("A", main.tekstX, main.navTextY);
    text("  " +"Select", main.tekstX+generalTextOffset, main.navTextY+generalTextOffset);
    text("  " +"Select", main.tekstX-generalTextOffset, main.navTextY-generalTextOffset);
    fill(BLACK);
    text("B", main.tekstX*2+generalTextOffset, main.navTextY+generalTextOffset);
    text("B", main.tekstX*2-generalTextOffset, main.navTextY-generalTextOffset);
    text("  " +"Select", main.tekstX, main.navTextY);
    fill(YELLOW);
    text("B", main.tekstX*2, main.navTextY);
    text("  "+"Back", main.tekstX*2+generalTextOffset, main.navTextY+generalTextOffset);
    text("  "+"Back", main.tekstX*2-generalTextOffset, main.navTextY-generalTextOffset);
    fill(BLACK);
    text("  "+"Back", main.tekstX*2, main.navTextY);
    text(floor(coins), width - 100, 50);
    stroke(BLACK);
    fill(YELLOW);
    image(coin, width - 175, 30, 40, 40);
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
    tekstSize[0] = textBig;
    tekstSize[1] = textNorm;
    tekstSize[2] = 40;    
    tekstX = width/4;
    tekstY = height/3;
    highlight = color(WHITE);
    select1 = highlight;
    select2 = GREY;
  }
  void update() {
    if (select1 == highlight) {
      tekstSize[0] =textBig;
      tekstSize[1] =textNorm;
    }//naar beneden in menu
    if (select1 == highlight&&keyCode==keyDown) {
      select1 = GREY;
      select2 = highlight;
    }
    if (select2 == highlight) {
      tekstSize[1]= textBig;
      tekstSize[0]= textNorm;
    }//naar boven in het menu
    if (select2 == highlight&&keyCode==keyUp) {
      select2 = GREY;
      select1 = highlight;
    }//q om terug te gaan
    if (keyCode ==keyQ&&cooldown<0) {
      room= "mainM";
      cooldown=COOLDOWN_MAX;
    }//normal game
    if (select1==highlight&&room == "difficulty" && inputs.hasValue(keySpace)&&cooldown<0 ) {
      room = "game";
      SpeedUp.play();
      cooldown=COOLDOWN_MAX;
    }//tutorial game
    if (select2==highlight &&room == "difficulty" && inputs.hasValue(keySpace)&&cooldown<0) {
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
    //NAVIGATION 
    //A=select
    fill(BLACK);
    text("A", main.tekstX+generalTextOffset, main.navTextY+generalTextOffset);
    text("A", main.tekstX-generalTextOffset, main.navTextY-generalTextOffset);
    fill(RED);
    text("A", main.tekstX, main.tekstY*2.8);
    text("  " +"Select", main.tekstX-2, main.navTextY-generalTextOffset);
    text("  " +"Select", main.tekstX+2, main.navTextY+generalTextOffset);
    fill(BLACK);
    text("  " +"Select", main.tekstX, main.navTextY);
    //B=back
    fill(BLACK);
    text("B", tekstX*2+generalTextOffset, main.navTextY+generalTextOffset);
    text("B", tekstX*2-generalTextOffset, main.navTextY-generalTextOffset);
    fill(YELLOW);
    text("B", tekstX*2, tekstY*2.8);
    text("  "+"Back", tekstX*2+generalTextOffset, main.navTextY+generalTextOffset);
    text("  "+"Back", tekstX*2-generalTextOffset, main.navTextY-generalTextOffset);
    fill(BLACK);
    text("  "+"Back", tekstX*2, main.navTextY);
  }
}
