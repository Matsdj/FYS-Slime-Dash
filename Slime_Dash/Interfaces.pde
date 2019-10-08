void interfacesSetup() {
  interfaces = new Interfaces();
}
Interfaces interfaces;
class Interfaces {
  //healthbar
  int healthMain, noHealth;
  float healthX, healthY;
  float healthR,healthRNormal, healthL, healthH;
  //score
  int score;
  float scoreX, scoreY;
  //game over
  String gOver;
  float gOverX, gOverY;
  boolean death;

  Interfaces() {
    //healthbar
    healthX=width*0.039;
    healthY= width*0.039;
    healthL = width*0.195;
    healthH = height*0.056;
    healthR = 20;
    healthRNormal = 20;

    noHealth = 0;
    /*als je jou object of enemy damage wil laten gebruik je healthMain*/
    healthMain = 100;
    //score
    scoreX = width-healthX;
    scoreY = width*0.039;
    score = 000000000;

    //game over
    gOver = "";
    gOverX = width/2;
    gOverY = height/2;
    death = false;
  }

  void update() {
    //healthbar
    /*zorgt ervoor dat de healthbar altijd de juiste ronding heeft*/
    noStroke();
    if (healthMain >= 95) {
      healthR= 20-((float(20)*(100-healthMain)/5));
    } else {
      healthR = 0;
    }

    //game over
    /*game over text*/
    if (healthMain <= noHealth) {
      death = true;
      healthMain = 0;
    }
    /*stop bewegen*/
    if (death == true) {
      gOver = "Game over";
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
    fill(255, 255, 0);
    rect(healthX, healthY, healthL, healthH, healthRNormal);
    /*actual health indicator*/
    noStroke();
    fill(255, 0, 0);
    rect(healthX, healthY, healthL*(float(healthMain)/100), healthH, healthRNormal, healthR, healthR, healthRNormal);
    /*static border*/
    stroke(0);
    noFill();
    strokeWeight(2);
    rect(healthX, healthY, healthL, healthH, healthRNormal);
    //score
    fill(0);
    textSize(30);
    text(score, scoreX, scoreY);
    //Game Over
    textAlign(CENTER);
    textSize(50);
    text(gOver, gOverX, gOverY);
/*
    if (mousePressed ==true)
      score +=2;
      */
  }
}
