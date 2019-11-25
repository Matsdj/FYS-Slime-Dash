//Laurens

void interfacesSetup() {
  interfaces = new HUD();
}
HUD interfaces;
class HUD {
  //DAMAGE NUMBERS/////////////////////////////////////
  int swordDMG = 20;
  //healthbar
  int healthMain, noHealth;
  float healthX, healthY, healthR, healthRNormal, healthL, healthH;
  color healthC = color(255, 0, 0, 255);
  //dashbar
  float dashmain, dashH, dashL, dashL2, dashX, dashY;
  //score
  float scoreX, scoreY, scoreSize, score;
  //game over
  String gOver;
  float gOverX, gOverY, goFadeIn, gOSize;
  boolean death;
  //coins
float coins;
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
    dashL2 = constrain(healthL, 0, healthL);
    dashX = healthX;
    dashY = width*0.055;
    //score
    scoreX = width*0.98;
    scoreY = width*0.039;
    scoreSize = width*0.025;
    score = 0;
    //coins
    coins = 0;
    //game over
    gOver = "";
    gOverX = width/2;
    gOverY = height/2.3;
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
    //healthbar laat damage cooldown zien door donkerrood te worden
    if (player.dmgCooldown >=0) {
      healthC = color(150, 0, 0);
    } else {
      healthC = color(255, 0, 0);
    }
    /*wanneer enemy collision heeft met player dan damage*/
    if (player.enemyDamage==true) {
      player.enemyDamage= false;
      healthC = color(255);
      /*verander deze om enemy damage aan te passen*/
      healthMain = healthMain-swordDMG;
    } 

    //dash bar
    dashL2 = constrain(-player.dashCooldown*50, 0, dashL);

    //game over
    /*game over text*/
    if (healthMain <= noHealth) {
      death = true;
      healthMain = 0;
    }
    if (death == true) {
      /*makes GO text fade in*/
      gOver = "Game over";
      goFadeIn += 2;
      /*stops player movement*/
      player.moveSpeed = 0;
      //Q om naar main menu te gaan
      if (keyCode ==81) {
        Dede.stop();
        setup();
        room= "mainM";
      }
    }
    /* spacebar om te resetten*/
    if (death ==true && inputs.hasValue(32)==true && room=="game") {
      death = false;
      Dede.stop();
      setup();
      room = "game";
      march0= true;
      march1= true;
      march2= true;
      march3= true;
    } 
    if (death ==true && inputs.hasValue(32)==true && room=="game2") {
      death = false;
      Dede.stop();
      setup();
      room = "game2";
      march0 = false;
    } 
    //fade out on death
    if (death == true) {
      player.fade -= 3;
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
    rect(healthX, healthY, healthL*(float(constrain(healthMain, 0, 100))/100), healthH, healthRNormal, healthR, healthR, healthRNormal);
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
    if (death==false&&room=="game") {
      score +=globalScrollSpeed/10;
    }
    textAlign(RIGHT);
    fill(0);
    textSize(scoreSize);
    text(floor(score), scoreX, scoreY);
    line(width-(width/8), scoreY+20, width, scoreY+20);
    //coins
    text(floor(coins),scoreX-30,scoreY+70);
    stroke(0);
    fill(255,255,0);
    image(coin,scoreX-20,scoreY+40,40,40);
 
    //Game Over
    fill(#A300FC, goFadeIn);
    textAlign(CENTER);
    textSize(constrain(goFadeIn, 1, gOSize));
    text(gOver, gOverX-2, gOverY-2);
    text("score =" + floor(score), gOverX-2, gOverY+98);
    fill(255, 255, 0, goFadeIn);
    textAlign(CENTER);
    textSize(constrain(goFadeIn, 1, gOSize));
    text(gOver, gOverX+2, gOverY+2);
    text("score =" + floor(score), gOverX+2, gOverY+102);
    fill(0, 0, 0, goFadeIn);
    textAlign(CENTER);
    textSize(constrain(goFadeIn, 1, gOSize));
    text(gOver, gOverX, gOverY);
    text("score =" + floor(score), gOverX, gOverY+100);
    textAlign(CENTER);
    textSize(constrain(goFadeIn, 1, gOSize));
    text(gOver, gOverX, gOverY);
    text("press A to restart  |   B to go to main menu", gOverX, gOverY+300);
  }
}
