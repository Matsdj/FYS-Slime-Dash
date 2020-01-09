//Laurens

/*
/NAVIGATIE/
 P = pauze (START)
 Q = terug (B)
 SPACE = verder (A)
 */
int  textNorm = 50, textBig = 75, generalTextOffset =2;
int jumpUpgradeState = 0;
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
    if (room == "pause2" && (inputsPressed(keySpace)||inputsPressed(keyRight))&&cooldown<COOLDOWN_MIN) {
      room = "game2";
      cooldown= COOLDOWN_MAX;
    }
    /*druk op 'p' om naar pause te gaan*/
    else if (room == "game2" && inputsPressed.hasValue(keyP) && interfaces.death == false &&cooldown<COOLDOWN_MIN) {
      room = "pause2";
      cooldown= COOLDOWN_MAX;
    }
    /*druk op spacebar om naar game te gaan*/
    if (room == "pause" && (inputsPressed(keySpace)||inputsPressed(keyRight))&&cooldown<COOLDOWN_MIN) {
      room = "game";
      cooldown= COOLDOWN_MAX;
    }
    /*druk op 'p' om naar pause te gaan*/
    else if (room == "game" && inputsPressed.hasValue(keyP) && interfaces.death == false ) {
      room = "pause";
      // druk op q of t om naar main menu te gaan
    } else if (room == "game2" && inputsPressed(keyP) && interfaces.death == false) {
      room = "pause2";
    } else if ((room == "pause"||room =="pause2") && (inputsPressed(keyQ)||inputsPressed(keyT))&&cooldown<COOLDOWN_MIN) {
      cooldown= COOLDOWN_MAX;
      GameSlow.stop();
      GameMid.stop();
      GameFast.stop();
      gameReset();
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
    fill(YELLOW);
    text("B", main.tekstX*2, main.navTextY);
    text("  "+"Menu", main.tekstX*2+2, main.navTextY+generalTextOffset);
    text("  "+"Menu", main.tekstX*2-2, main.navTextY-generalTextOffset);
    fill(BLACK);
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
  int  select1, select2, select3;
  color highlight;
  float[] tekstSize = new float[4];
  MainM() {
    sizeH = height/7;
    sizeW = width/2.8;
    background(0);
    tekstSize[0] = 75;
    tekstSize[1] = 50;
    tekstSize[2] = 40;
    tekstSize[3] = 50;
    tekstX = width/4;
    tekstY = height/3;
    highlight = color(WHITE);
    select1 = highlight;
    select2 = GREY;
    select3 = GREY;
    navTextY = (height/3)*2.8;
  }
  void update() {

    if (select1 == highlight) {
      tekstSize[0] =textBig;
      tekstSize[1] =textNorm;
      tekstSize[3]= textNorm;
    }    
    if (select2 == highlight) {
      tekstSize[1]= textBig;
      tekstSize[0]= textNorm;
      tekstSize[3]= textNorm;
    }    
    if (select3 == highlight) {
      tekstSize[0]= textNorm;
      tekstSize[1]= textNorm;
      tekstSize[3]= textBig;
    }
    //Down in het menu
    if (select1 == highlight&&inputsPressed(keyDown) ) {
      Ding.play();
      select1 = GREY;
      select2 = highlight;
      select3 = GREY;
    }
    if (select2 == highlight&&inputsPressed(keyDown) ) {
      Ding.play();
      select1 = GREY;
      select2 = GREY;
      select3 = highlight;
    }
    //Up in het menu
    if (select2 == highlight&&inputsPressed(keyUp) ) {
      Ding.play();
      select1 = highlight;
      select2 = GREY;
      select3 = GREY;
    }
    if (select3 == highlight&&inputsPressed(keyUp) ) {
      Ding.play();
      select1 = GREY;
      select2 = highlight;
      select3 = GREY;
    }

    // spatie om naar andere rooms te gaan
    if (select1==highlight&&room == "mainM" && inputsPressed(keySpace) ) {
      room = "difficulty";
      SpeedUp.play();
      cooldown= COOLDOWN_MAX;
    }
    if (select2==highlight &&room == "mainM" && inputsPressed(keySpace)) {
      room = "upgrades";
      SpeedUp.play();
      cooldown= COOLDOWN_MAX;
    }    
    if (select3==highlight &&room == "mainM" && inputsPressed(keySpace)) {
      room = "Highscores";
      SpeedUp.play();
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
    fill(select3);
    textSize(tekstSize[3]);
    text("Highscores", tekstX, tekstY*2);
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
  float upgradetekstLow, upgradetekstHigh;
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
    perchTLState = 0;
    perchTRState = 1; //dash
    perchBLState = 0;
    perchBRState = 0;
    perchTL = perch[perchTLState];
    perchTR = perch[perchTRState];
    perchBL = perch[perchBLState];
    perchBR = perch[perchBRState];
    upgradetekstLow = perchDown*1.075;
    upgradetekstHigh = perchUp*1.35;
  }
  void update() {
    if (inputsPressed(keyQ)) {
      room= "mainM";
      cooldown=COOLDOWN_MAX;
    }
    if (room=="upgrades") {
      if (inputsPressed(keyDown) && perchSelectY == perchUp) {
        perchSelectY = perchDown;
        Ding.play();
      }
      if (inputsPressed(keyUp) && perchSelectY == perchDown) {
        perchSelectY = perchUp;
        Ding.play();
      }
      if (inputsPressed(keyRight) && perchSelectX == perchLeft) {
        perchSelectX = perchRight;
        Ding.play();
      }
      if (inputsPressed(keyLeft) && perchSelectX == perchRight) {
        perchSelectX = perchLeft;
        Ding.play();
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
          jumpUpgradeState = 1;
          player.maxJumpAmount = jumpUpgradeState;
          SpeedUp.play();
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
          player.dashCooldownMax = player.DASH_COOLDOWN_CHARGE * upgrade.perchTRState;
          cooldown = COOLDOWN_UPGRADE;
          coins -= dashPrice;
          dashPrice = dashPrice * 2;
          textAlign(CENTER);
          fill(WHITE);
          text("DASH CHARGES INCREASED", width/2+generalTextOffset, height/2+generalTextOffset);
          fill(BLACK);
          text("DASH CHARGES INCREASED", width/2, height/2);
          textAlign(LEFT, CENTER);
          SpeedUp.play();
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
          SpeedUp.play();
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
          coinValue ++;
          coinPrice = coinPrice * 2;
          textAlign(CENTER);
          fill(WHITE);
          text("COIN VALUE INCREASED", width/2+generalTextOffset, height/2+generalTextOffset);
          fill(BLACK);
          text("COIN VALUE INCREASED", width/2, height/2);
          textAlign(LEFT, CENTER);
          SpeedUp.play();
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
        doubleJumpPrice = 1337;
      }
      if (inputsPressed.hasValue(keySpace) && perchSelectX == perchRight && perchSelectY == perchUp && perchTRState == perch.length -1 ) {
        textAlign(CENTER);
        fill(WHITE);
        text(upgradeMaxText, width/2+generalTextOffset, height/2+generalTextOffset);
        fill(BLACK);
        text(upgradeMaxText, width/2, height/2);
        textAlign(LEFT, CENTER);
        dashPrice = 1337;
      }
      if (inputsPressed.hasValue(keySpace) && perchSelectX == perchLeft && perchSelectY == perchDown && perchBLState == perch.length -1 ) {
        textAlign(CENTER);
        fill(WHITE);
        text(upgradeMaxText, width/2+generalTextOffset, height/2+generalTextOffset);
        fill(BLACK);
        text(upgradeMaxText, width/2, height/2);
        textAlign(LEFT, CENTER);
        healthPrice = 1337;
      }
      if (inputsPressed.hasValue(keySpace) && perchSelectX == perchRight && perchSelectY == perchDown && perchBRState == perch.length -1 ) {
        textAlign(CENTER);
        fill(WHITE);
        text(upgradeMaxText, width/2+generalTextOffset, height/2+generalTextOffset);
        fill(BLACK);
        text(upgradeMaxText, width/2, height/2);
        textAlign(LEFT, CENTER);
        coinPrice=1337;
      }
    }
    /*  if (perchTLState == 3 && perchTRState == 3 && perchBLState == 3 && perchBRState == 3) {
     fill(0, 0, 0, 60);
     rect(0, 0, width, height);
     imageMode(CENTER);
     image(perch[2], width/2, height/2);
     fill(0);
     textAlign(CENTER);
     text("KING SLIME", width/2, height*0.3);
     imageMode(CORNER);
     textAlign(LEFT);
     } */
  }
  void draw() {
    textSize(55);
    text("Upgrades", width/2.7, 50);
    textSize(25);
    //select
    image(perchSelect, perchSelectX, perchSelectY, perchW, perchH);
    //top left
    image(perchTL, perchLeft, perchUp, perchW, perchH);
    text("Double Jump : "+perchTLState, perchLeft+xOffset, perchUp-yOffset/4);
    text(doubleJumpPrice, perchLeft+xOffset, perchUp+yOffset);
    //top right
    image(perchTR, perchRight, perchUp, perchW, perchH);
    textSize(23);
    text("Dash charges : "+perchTRState, perchRight+xOffset, perchUp-yOffset/4);
    text(dashPrice, perchRight+xOffset, perchUp+yOffset);
    //bottom left
    textSize(25);
    image(perchBL, perchLeft, perchDown, perchW, perchH);
    text("Health : "+perchBLState, perchLeft+xOffset, perchDown-yOffset/4);
    text(healthPrice, perchLeft+xOffset, perchDown+yOffset);
    //bottom right
    image(perchBR, perchRight, perchDown, perchW, perchH);
    text("Coin Value : "+perchBRState, perchRight+xOffset, perchDown-yOffset/4);
    text(coinPrice, perchRight+xOffset, perchDown+yOffset);
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
    if (select1 == highlight&&inputsPressed(keyDown)) {
      select1 = GREY;
      select2 = highlight;
      Ding.play();
    }
    if (select2 == highlight) {
      tekstSize[1]= textBig;
      tekstSize[0]= textNorm;
    }//naar boven in het menu
    if (select2 == highlight&&inputsPressed(keyUp)) {
      select2 = GREY;
      select1 = highlight;
      Ding.play();
    }//q om terug te gaan
    if (inputsPressed(keyQ)) {
      room= "mainM";
      cooldown=COOLDOWN_MAX;
    }//normal game
    if (select1==highlight&&room == "difficulty" && inputsPressed(keySpace) ) {
      room = "game";
      SpeedUp.play();
      cooldown=COOLDOWN_MAX;
    }//tutorial game
    if (select2==highlight &&room == "difficulty" && inputsPressed(keySpace)) {
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
//Mats
class Selection {
  int xSelected = 0, centerX, centerY;
  int[] ySelected;
  String[][] options;
  int holdKeyTime = 0;
  final color SELECTED_OPTION_COLOR = color(0, 100, 0);
  Selection(String[][] inputOptions, int inputCenterX, int inputCenterY) {
    options = inputOptions;
    ySelected = new int[inputOptions[0].length];
    centerX = inputCenterX;
    centerY = inputCenterY;
  }
  void draw() {
    //HoldKey
    if (inputs.hasValue(UP) || inputs.hasValue(DOWN)) {
      holdKeyTime++;
    } else {
      holdKeyTime = 0;
    }
    //Selection
    if (inputsPressed(LEFT)) {
      Ding.play();
      xSelected--;
      if (xSelected < 0) {
        xSelected = options.length-1;
      }
    }
    if (inputsPressed(RIGHT)) {
      Ding.play();
      xSelected++;
      if (xSelected >= options.length) {
        xSelected = 0;
      }
    }
    if (inputsPressed(UP) || (holdKeyTime > 20 && inputs.hasValue(UP) && (holdKeyTime/5f == floor(holdKeyTime/5f)))) {
      Ding.play();
      ySelected[xSelected]--;
      if (ySelected[xSelected] < 0) {
        ySelected[xSelected] = options[0].length-1;
      }
    }
    if (inputsPressed(DOWN) || (holdKeyTime > 20 && inputs.hasValue(DOWN) && (holdKeyTime/5f == floor(holdKeyTime/5f)))) {
      Ding.play();
      ySelected[xSelected]++;
      if (ySelected[xSelected] >= options[0].length) {
        ySelected[xSelected] = 0;
      }
    }
    //Drawing Selection
    textAlign(CENTER, CENTER);
    for (int ix = 0; ix < options.length; ix++) {
      for (int iy = 0; iy < options[0].length; iy++) {
        int dist = textBig;
        if (iy == ySelected[ix]) {
          textSize(textBig);
        } else {
          textSize(textNorm);
        }
        float yLoc = centerY+(dist*(iy-ySelected[ix]));
        float xLoc = centerX+(dist*(ix-xSelected));
        if (iy == ySelected[ix] && ix == xSelected && options[ix][iy].length() == 1) {
          fill(BLACK, 100);
          noStroke();
          rect(xLoc-textBig/2, yLoc-textBig/2, textBig, textBig);
        }
        fill(WHITE, 255-pow(ySelected[ix]-iy, 2)*10);
        text(options[ix][iy], xLoc, yLoc);
        if (options[ix][iy] == " ") {
          text('_', xLoc, yLoc);
        }
      }
    }
    textAlign(CORNER);
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
    stroke(BLACK);
    fill(WHITE);
  }
  String selection() {
    String string = "";
    for (int ix = 0; ix < options.length; ix++) {
      for (int iy = 0; iy < options[0].length; iy++) {
        if (iy == ySelected[ix]) {
          string += options[ix][iy];
        }
      }
    }
    return string;
  }
  int intSelection(int row) {
    for (int i = 0; i < ySelected.length; i++) {
      if (i == ySelected[row]) {
        return i;
      }
    }
    return 0;
  }
}
