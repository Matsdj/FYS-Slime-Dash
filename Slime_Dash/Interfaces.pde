//Laurens

void interfacesSetup() {
  interfaces = new HUD();
}
HUD interfaces;
class HUD {
  //healthbar
  int healthMain, noHealth;
  float healthX, healthY, healthR, healthRNormal, healthL, healthH;
  color healthC = color(255, 0, 0, 255);
  //dashbar
  float dashmain, dashH, dashL,dashL2, dashX, dashY;
  //score
  float scoreX, scoreY, scoreSize, score;
  //game over
  String gOver;
  float gOverX, gOverY, goFadeIn, gOSize;
  boolean death;

  HUD() {
    //healthbar
    healthX= width*0.02;
    healthY= width*0.02;
    healthL = width*0.195;
    healthH = height*0.056;
    healthR = 20;
    healthRNormal = 20;
    noHealth = 0;
    /*als je jou object of enemy damage wil laten gebruik je healthMain*/
    healthMain = 100;
    death = false;
    //dash bar
    dashH = healthH/3;
    dashL = healthL;
    dashL2 = constrain(healthL,0,healthL);
    dashX = healthX;
    dashY = width*0.055;
    //score
    scoreX = width*0.98;
    scoreY = width*0.039;
    scoreSize = width*0.025;
    score = 0;

    //game over
    gOver = "";
    gOverX = width/2;
    gOverY = height/2;
    gOSize = width*0.04;
    goFadeIn = 0;
  }

  void update() {
    //healthbar
    /* zorgt er voor dat health niet boven 100 gaat*/
    healthMain = constrain(healthMain, 0, 100);

    /*zorgt ervoor dat de healthbar altijd de juiste ronding heeft*/
    noStroke();
    if (healthMain >= 95) {
      healthR= 20-((float(20)*(100-healthMain)/5));
    } else {
      healthR = 0;
    }
    /*wanneer enemy collision heeft met player dan damage*/

    if (player.enemyDamage==true) {
      player.enemyDamage= false;
      /*verander deze om enemy damage aan te passen*/
      healthMain = healthMain-20;
    }

    //dash bar
    dashL2 = constrain(-player.dashCooldown*50,0,dashL);
    
    //game over
    /*game over text*/
    if (healthMain <= noHealth) {
      death = true;
      healthMain = 0;
    }


    if (death == true) {
      /*makes GO text fade in*/
      gOver = "Game over";
      goFadeIn += 3;
      /*stops player movement*/
      player.moveSpeed = 0;
    }
    /* spacebar om te resetten*/
    if (death ==true && inputs.hasValue(32)==true) {
      death = false;
      setup();
      room = "game";
    }
  }
  void draw() {
    //healthbar
    /*healthbar backdrop*/
    noStroke();
    fill(0, 0, 0, 50);
    rect(healthX, healthY, healthL, healthH, healthRNormal);
    /*actual health indicator*/
    noStroke();
    fill(healthC);
    if (healthMain > 100) healthMain = 100;
    rect(healthX, healthY, healthL*(float(healthMain)/100), healthH, healthRNormal, healthR, healthR, healthRNormal);
    /*static border*/
    stroke(0);
    noFill();
    strokeWeight(2);
    rect(healthX, healthY, healthL, healthH, healthRNormal);
    //dash bar 
    /*dashbar backdrop*/
    noStroke();
    fill(0, 0, 0, 50);
    rect(dashX, dashY, dashL, dashH, healthRNormal);
    /*actual dash indicator*/
    noStroke();
    fill(#5AFF03, 255);
    rect(dashX, dashY, dashL2, dashH, healthRNormal);

    /* border*/
    stroke(0);
    noFill();
    rect(dashX, dashY, dashL, dashH, healthRNormal);

    //score
    score +=globalScrollSpeed;
    textAlign(RIGHT);
    fill(0);
    textSize(scoreSize);
    text(floor(score), scoreX, scoreY);
    line(width-(width/8), scoreY+20, width, scoreY+20);
    //Game Over
    fill(0, 0, 0, goFadeIn);
    textAlign(CENTER);
    textSize(gOSize);
    text(gOver, gOverX, gOverY);
    //fade out on death
    if (death == true) {
      player.fade -= 3;
    }
  }
}

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
    if (room == "pause" && inputs.hasValue(32)==true) {
      room = "game";
    }
    /*druk op 'p' om naar pause te gaan*/
    else if (room == "game" && inputs.hasValue(80)) {
      room = "pause";
    } else if (room == "pause" && inputs.hasValue(81)) {
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
void mainMSetup() {
  main = new MainM();
}
MainM main;

class MainM {
  float bx, by, sizeW, sizeH, tx, ty, tSize, sdColor, blink;
  boolean hover, blinkC;
  //PFont font;


  MainM() {
    sizeH = height/7;
    sizeW = width/2.8;
    bx = (width/2)-(sizeW/2);
    by = (height/2)-(sizeH/2);
    //font = loadFont("vlw");
    //textFont(font);

    background(0);
    tSize = 50;
    tx = width/2;
    ty = height/4*3;
    sdColor = 255;
    blink = 255;
    blinkC = false;
  }
  void update() {
    if (room == "mainM" && inputs.hasValue(32)==true) {
      room = "game";
    }
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
  }
  void draw() {
    /* fill(20);
     rect(bx, by, sizeW, sizeH);
     fill(255);*/

    //stars
    fill(0, 3);
    rect(0, 0, width, height);
    fill(255);
    ellipse(random(width), random(height), 3, 3);
    //text
    textAlign(CENTER, CENTER);    
    textSize(tSize/2);
    text("pause = p", 100, height-50);
    textSize(tSize*2);
    fill(0, sdColor, 0);
    text("Slime Dash", width/2, height/4);
    textSize(tSize);
    fill(blink, blink, blink);
    text("press SPACEBAR to play", tx, ty);
  }
}
