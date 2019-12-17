//Laurens

void interfacesSetup() {
  interfaces = new HUD();
}
HUD interfaces;
class HUD {
  //DAMAGE NUMBERS/////////////////////////////////////
  boolean meleeDamage = false;
  boolean arrowDamage = false;
  boolean archerDamage = false;
  boolean spikeDamage = false;
  int meleeDMGnum = 20;
  int arrowDMGnum = 10;
  int archerDMGnum = 20;
  int spikeDMGnum = 10;
  // tutorial
  float tutX, tutY;
  String tutText;
  PImage[] tutorial = new PImage[4];
  color circleColor = color(255, 255, 0);
  ;
  //healthbar
  int noHealth;
  float healthBarX, healthBarY, healthBarCurve, healthBarCurveNormal, healthBarLength, healthBarHeight, healthMult, health;
  color healthC = color(255, 0, 0, 255);
  //dashbar
  float dashmain, dashH, dashL, dashL2, dashX, dashY;
  final float DASH_SMOL_MAX =globalScale;
  float dashSmol, dashLsmol, dashLsmol2;
  //score
  float scoreX, scoreY, scoreSize, score, scoreNormal;
  //game over
  String gOver;
  float gOverX, gOverY, goFadeIn, gOSize;
  boolean death;
  //coins

  HUD() {
    //tutorial
    tutX=width/2;
    tutY=height/4;
    tutText = "";
    tutorial[0] = playerSprite[4];
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
    scoreNormal= width*0.025;
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
    //score
    scoreSize = width*0.025+constrain(playerCatchUp*2, 0, 100);
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
      damage.play();
      /*verander deze om enemy damage aan te passen*/
      //healthMult is voor de damageReduction als je een upgrade koopt
      if (meleeDamage==true) {
        health = health-(meleeDMGnum*healthMult);
        meleeDamage=false;
      }
      // health = health-(MagicBarricadeDMG*healthMult);
      if ( arrowDamage==true) {
        health = health-(arrowDMGnum*healthMult);
        arrowDamage=false;
      }      
      if ( archerDamage==true) {
        health = health-(archerDMGnum*healthMult);
        archerDamage=false;
      }      
      if ( spikeDamage==true) {
        health = health-(spikeDMGnum*healthMult);
        spikeDamage=false;
      }

      player.enemyDamage= false;
      healthC = color(255);
    }

    //dash bar
    dashL2 = constrain(player.dashCooldown*5, 0, dashL);
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
    //tutorial

    if (room=="game2") {
      fill(circleColor);
      ellipseMode(RADIUS);
      stroke(0);
      strokeWeight(5);
      ellipse(width/2+(width/100), height/5-15, 35, 35);
      fill(0);
      textSize(50);
      text(tutText, width/2, height/5);
      tint(155);
      imageMode(CENTER);
      image(tutorial[0], width*0.6, height/5-20);
      if (traveledDistance >0) {
        tutText = "B";
        tutorial[0] = playerSprite[4];
      }
      if (traveledDistance >13) {
        circleColor = color(255, 0, 0);
        tutText = "A";
        tutorial[0] = playerSprite[5];
      }
    } 
    imageMode(CORNER);
    tint(255);
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
    textSize(scoreNormal);
    text(constrain(floor(health), 0, 100), healthBarX+(globalScale/2), healthBarY+(globalScale*0.85));
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
    createParticle(width+50, scoreY+20, constrain(floor(playerCatchUp/1.3), 0, 100), color(255), color(200), -.01, floor(playerCatchUp), false, "", 1);
    line(width-(width/8), scoreY+20, width, scoreY+20);
    //coins
    textSize(scoreNormal);
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
    println(traveledDistance);
  }
}
