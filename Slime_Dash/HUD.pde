//Laurens

void interfacesSetup() {
  interfaces = new HUD();
}
HUD interfaces;
class HUD {
  //DAMAGE NUMBERS/////////////////////////////////////
  int swordDMG = 20;
  //healthbar
  int noHealth;
  float healthBarX, healthBarY, healthBarCurve, healthBarCurveNormal, healthBarLength, healthBarHeight, healthMult, health;
  color healthC = color(255, 0, 0, 255);
  //dashbar
  float dashmain, dashH, dashL, dashL2, dashX, dashY;
  final float DASH_SMOL_MAX =globalScale;
  float dashSmol, dashLsmol, dashLsmol2;
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
    healthMult = 1;
    death = false;
    //dash bar
    dashH = healthBarHeight/3;
    dashL = healthBarLength;
    dashL2 = constrain(healthBarLength, 0, healthBarLength);
    dashX = healthBarX+(globalScale/4);
    dashY = healthBarY+globalScale*1.5;
    dashLsmol = globalScale/5;
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
      //healthMult is voor de damageReduction als je een upgrade koopt
      health = health-(swordDMG*healthMult);
      health = health-(MagicBarricadeDMG*healthMult);
    }

    //dash bar
    dashL2 = constrain(-player.dashCooldown*50, 0, dashL);
    dashLsmol2 = constrain(-player.dashCooldown*50, 0, dashLsmol);


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
      if (keyCode ==77) {
        Dede.stop();
        setup();
        room= "mainM";
      }
    }
    /* B om te resetten*/
    if (death ==true && inputs.hasValue(66)==true && room=="game") {
      death = false;
      Dede.stop();
      setup();
      room = "game";
      march[0]= true;
      march[1]= true;
      march[2]= true;
      march[3]= true;
    }
    if (death ==true && inputs.hasValue(66)==true && room=="game2") {
      death = false;
      Dede.stop();
      setup();
      room = "game2";
      march[0] = false;
    }
  }
  void draw() {
    //healthbar
    /*healthbar backdrop*/
    fill(0, 50);
    rect(healthBarX+(globalScale/3), healthBarY+(globalScale/3), healthBarLength*(float(constrain(100, 0, 100))/100), globalScale*0.7);
    /*actual health indicator*/

    fill(healthC);
    if (health > 100) health = 100;
    rect(healthBarX+(globalScale/3), healthBarY+(globalScale/3), healthBarLength*((constrain(health, 0, 100))/100), globalScale*0.7);

    /*static border*/
    image(healthbar, healthBarX, healthBarY, globalScale*4.6, globalScale*1.4);
    fill(255);
    textSize(scoreSize);
    text(floor(health), healthBarX+(globalScale/2), healthBarY+(globalScale*0.85));
    //dash bar
    /*dashbar backdrop*/
    noStroke();
    fill(155);
    rect(dashX, dashY, dashL, dashH);
    /*actual dash indicator*/
    noStroke();
    fill(255, 255);
    rect(dashX, dashY, dashL2, dashH);
    fill(255, 255);
    rect(player.x, player.y-(globalScale/5), dashLsmol2, globalScale/10);
    /* border*/
    stroke(0);
    noFill();
    rect(dashX, dashY, dashL, dashH);
    // image(dashbar, 10, 90, 425, 70);
    //score
    if (death==false&&room=="game") {
      score +=globalScrollSpeed/globalScale*10;
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
    fill(255, goFadeIn);
    text("Sta", main.tekstX, main.tekstY*2.8);
    fill(0, goFadeIn);
    text("  " +"Retry", main.tekstX+50, main.tekstY*2.8);
    fill(255, goFadeIn);
    text("Sel", main.tekstX*2, main.tekstY*2.8);
    fill(0, goFadeIn);
    text("  "+"Menu", main.tekstX*2+50, main.tekstY*2.8);
  }
}
