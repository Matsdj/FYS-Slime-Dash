//Laurens

void interfacesSetup() {
  interfaces = new HUD();
}
HUD interfaces;
class HUD {
  //DAMAGE NUMBERS/////////////////////////////////////
  int swordDMG = 20;
  //healthbar
  int health, noHealth;
  float healthBarX, healthBarY, healthBarCurve, healthBarCurveNormal, healthBarLength, healthBarHeight;
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

  HUD() {
    //healthbar
    healthBarX= 30+(globalScale/18);
    healthBarY= 40;
    healthBarLength = globalScale*4;
    healthBarHeight = globalScale*0.8;
    healthBarCurve = 20;
    healthBarCurveNormal = 20;
    noHealth = 0;
    /*als je jou object of enemy damage wil laten gebruik je health*/
    health = 100;
    death = false;
    //dash bar
    dashH = healthBarHeight/3;
    dashL = healthBarLength;
    dashL2 = constrain(healthBarLength, 0, healthBarLength);
    dashX = healthBarX;
    dashY = width*0.06;
    //score
    scoreX = width*0.98;
    scoreY = width*0.039;
    scoreSize = width*0.025;
    score = 0;
    //coins

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
    health = constrain(health, 0, 100);


    /*zorgt ervoor dat de healthbar altijd de juiste ronding heeft*/
    noStroke();
    if (health >= 95) {
      healthBarCurve= 20-((float(20)*(100-health)/5));
    } else {
      healthBarCurve = 0;
    }
    //healthbar laat damage cooldown zien door donkerrood te worden
    if (player.dmgCooldown >=0) {
      healthC = color(150, 0, 0);
    } else {
      healthC = color(255, 0, 0);
    }
    /*wanneer enemy collision heeft met player dan damage*/
    if (player.enemyDamage==true&& death==false) {
      player.enemyDamage= false;
      damage.play();
      healthC = color(255);
      /*verander deze om enemy damage aan te passen*/
      health = health-swordDMG;
      health = health-MagicBarricadeDMG;
    }

    //dash bar
    dashL2 = constrain(-player.dashCooldown*50, 0, dashL);

    //game over
    /*game over text*/
    if (health <= noHealth) {
      death = true;
      health = 0;
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
    /* B om te resetten*/
    if (death ==true && inputs.hasValue(18)==true && room=="game") {
      death = false;
      Dede.stop();
      setup();
      room = "game";
      march[0]= true;
      march[1]= true;
      march[2]= true;
      march[3]= true;
    }
    if (death ==true && inputs.hasValue(18)==true && room=="game2"&&cooldown<0) {
      death = false;
      Dede.stop();
      setup();
      room = "game2";
      march[0] = false;
      cooldown=COOLDOWN_MAX;
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
    rect(healthBarX, healthBarY, healthBarLength, healthBarHeight);
    /*actual health indicator*/
    noStroke();
    fill(healthC);
    if (health > 100) health = 100;
    rect(healthBarX, healthBarY, healthBarLength*(float(constrain(health, 0, 100))/100), healthBarHeight);
    /*static border*/
    stroke(0);
    noFill();
    strokeWeight(2);
    rect(healthBarX, healthBarY, healthBarLength, healthBarHeight);
    image(healthbar, 10, 15+(globalScale/18), globalScale*4.75, globalScale*1.2);
    fill(255);
    textSize(scoreSize);
    text(health, 50, healthBarY+(globalScale/2));
    //dash bar
    /*dashbar backdrop*/
    noStroke();
    fill(155);
    rect(dashX, dashY, dashL, dashH);
    /*actual dash indicator*/
    noStroke();
    fill(#5AFF03, 255);
    rect(dashX, dashY, dashL2, dashH);
    /* border*/
    stroke(0);
    noFill();
    rect(dashX, dashY, dashL, dashH);
    image(dashbar, 10, 90, 425, 70);
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
    text(floor(coins), scoreX-30, scoreY+70);
    stroke(0);
    fill(255, 255, 0);
    image(coin, scoreX-20, scoreY+40, 40, 40);

    //Game Over
    fill(#A300FC, goFadeIn);
    textAlign(CENTER);
    textSize(constrain(goFadeIn, 1, gOSize));
    text(gOver, gOverX-2, gOverY-2);
    text("score " + floor(score), gOverX-2, gOverY+98);
    fill(255, 255, 0, goFadeIn);
    text(gOver, gOverX+2, gOverY+2);
    text("score " + floor(score), gOverX+2, gOverY+102);
    fill(0, 0, 0, goFadeIn);
    text(gOver, gOverX, gOverY);
    text("score " + floor(score), gOverX, gOverY+100);
    textAlign(LEFT);
    textSize(main.tekstSize[2]);
    fill(255, 0, 0, goFadeIn);
    text("A", main.tekstX, main.tekstY*2.8);
    fill(0, goFadeIn);
    text("  " +"Retry", main.tekstX, main.tekstY*2.8);
    fill(255, 255, 0, goFadeIn);
    text("B", main.tekstX*2, main.tekstY*2.8);
    fill(0, goFadeIn);
    text("  "+"Menu", main.tekstX*2, main.tekstY*2.8);
  }
}
