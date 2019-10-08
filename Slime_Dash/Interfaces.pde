void interfacesSetup() {
  interfaces = new Interfaces();
}
Interfaces interfaces;
class Interfaces {
  //healthbar
  int healthMain, noHealth;
  float healthX, healthY, healthR, healthRNormal, healthL, healthH;
  //score
  int score;
  float scoreX, scoreY,scoreSize;
  //game over
  String gOver;
  float gOverX, gOverY;
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
    //score
    scoreX = width*0.98;
    scoreY = width*0.039;
    score = 000000000;
    scoreSize = width*0.025;

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
    textAlign(RIGHT);
    fill(0);
    textSize(scoreSize);
    text(score, scoreX, scoreY);
    line(width-(width/8), scoreY+20, width, scoreY+20);
    //Game Over
    textAlign(CENTER);
    textSize(50);
    text(gOver, gOverX, gOverY);

    if (mousePressed ==true)
      score +=100;
  }
}
