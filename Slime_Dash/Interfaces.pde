//Laurens

void interfacesSetup() {
  interfaces = new Interfaces();
}
Interfaces interfaces;
class Interfaces {
  //healthbar
  int healthMain, noHealth;
  float healthX, healthY, healthR, healthRNormal, healthL, healthH;
  color healthC = color(255, 0, 0, 255);
  //score
  int score;
  float scoreX, scoreY, scoreSize;
  //game over
  String gOver;
  float gOverX, gOverY, goFadeIn, gOSize;
  boolean death;

  Interfaces() {
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
    //score
    scoreX = width*0.98;
    scoreY = width*0.039;
    scoreSize = width*0.025;
    score = 000000000;

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
      player.gravity = 0;
      player.dashSpeed = 0;
      player.vx = 0;
      player.vy = 0;
    }
  }
  void draw() {
    //healthbar

    /*healthbar backdrop*/
    noStroke();
    fill(0, 0, 0, 30);
    rect(healthX, healthY, healthL, healthH, healthRNormal);
    /*actual health indicator*/
    noStroke();
    fill(healthC);
    rect(healthX, healthY, healthL*(float(healthMain)/100), healthH, healthRNormal, healthR, healthR, healthRNormal);
    /*static border*/
    stroke(0);
    noFill();
    strokeWeight(2);
    rect(healthX, healthY, healthL, healthH, healthRNormal);
    //score
    textAlign(RIGHT);
    fill(0);
    textSize(scoreSize);
    text(score, scoreX, scoreY);
    line(width-(width/8), scoreY+20, width, scoreY+20);
    //Game Over
    fill(0, 0, 0, goFadeIn);
    textAlign(CENTER);
    textSize(gOSize);
    text(gOver, gOverX, gOverY);
  }
}
//PAUSE//////////////////////////////////////////
void pauseSetup() {
  pause = new Menu();
}
Menu pause;

class Menu {
  float pauseV, fade;
  Menu() {
    //fade voor pause
    fade = 2;
    pauseV +=fade;
  }

  void update() {
    /*druk op 'q' om naar game te gaan*/
    if (room == "pause" && inputs.hasValue(81)==true) {
      room = "game";
    }
    /*druk op 'w' om naar game te gaan*/
    else if (room == "game" && inputs.hasValue(87)) {
      room = "pause";
    }

    if (pauseV >=20)
    pauseV +=0;
  }

  void draw() {
    fill(0, 0, 0, pauseV);
    rect(0, 0, width, height);
    fill(255);
    textAlign(CENTER);
    textSize(100);
    text("PAUSED", width/2, height/2);
    textSize(60);
    text("PRESS 'Q' TO RESUME", width/2, height*0.82);
  }
}
