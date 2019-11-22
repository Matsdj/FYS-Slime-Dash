//Laurens

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
    if (room == "pause" && (inputs.hasValue(32)||inputs.hasValue(39))) {
      room = "game";
    }
    /*druk op 'p' om naar pause te gaan*/
    else if (room == "game" && inputs.hasValue(80) && interfaces.death != true) {
      room = "pause";
     // druk op q of t om naar main menu te gaan
    } else if (room == "pause" && (inputs.hasValue(81)||inputs.hasValue(84))) {
      GameSlow.stop();
      GameMid.stop();
      GameFast.stop();
      setup();
      room = "mainM";
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
    text("resume = spacebar", width/2, height*0.70);
    text("main menu = q", width/2, height*0.82);
  }
}

//main Menu///////////////////////
void mainMSetup() {
  main = new MainM();
}
MainM main;

class MainM {
  float bx, by, sizeW, sizeH, tx, ty, tSize, sdColor;
  boolean hover, blinkC;
  int blink, c1, c2, c3;
  //PFont font;
    PImage slimeDash;

  MainM() {
      slimeDash = loadImage("./sprites/menus/SlimeDash.png");
    sizeH = height/7;
    sizeW = width/2.8;
    bx = (width/2)-(sizeW/2);
    by = (height/2)-(sizeH/2);
    //font = loadFont("vlw");
    //textFont(font);
    background(0);
    tSize = 50;
    tx = width/4;
    ty = height/3;
    sdColor = 255;
    blink = 255;
    blinkC = false;
    c1 = 255;
    c2 = 255;
    c3 = 255;
  }
  void update() {
    //zorgt voor een blinking effect, kan waarschijnlijk efficienter :S
    if (blink >=255) {
      blinkC = false;
    }
    if (blinkC==false) {
      blink -=5;
    } 
    if (blink <= 0) {
      blinkC =true;
    }
    if (blinkC == true) {
      blink +=5;
    }
    c1 = blink;
    if (c1 == blink&&keyCode==40) {
      c1 = 255;
      c2 = blink;
    }
    if (c2 == blink&&keyCode==38) {
      c2 = 255;
      c1 = blink;
    }


    if (c1 == blink&&room == "mainM" && keyCode ==32) {
      room = "game";
      SpeedUp.play();
    }
    if (c2 == blink&&room == "mainM" && keyCode ==32) {
      room = "settings";
    }
  }
  void draw() {
    /* fill(20);
     rect(bx, by, sizeW, sizeH);
     fill(255);*/

    //text
    textAlign(LEFT, CENTER);
    textSize(tSize/2);
    text("pause = p | dash = z", 200, height-50);
    textSize(tSize);
    fill(c1);
    text("Play", tx, ty);
    fill(c2);
    text("Settings", tx, ty*1.5);
    fill(c3);
    text("press SPACEBAR to select", tx, ty*2);
  image(slimeDash,width/4,height/100,width/3,height/3);
  }
}

void settingSetup() {
  setting = new Settings();
}
Settings setting;

class Settings {


  Settings() {
  }
  void update() {
  }
  void draw() {
    fill(0, 3);
    rect(0, 0, width, height);
    fill(255);
    ellipse(random(width), random(height), 3, 3);
  }
}
