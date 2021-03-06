//Laurens
final color RED = color(255, 0, 0), DARK_RED = color(150, 0, 0), YELLOW = color(255, 255, 0), BLACK = color(0), WHITE = color(255), GREY = color(180);
final int PARTICLE_TEXT_SIZE = 50, PARTICLE_SIZE = 10, PARTICLE_SIZE_SMALL = 5, PARTICLE_SIZE_LARGE = 15, PARTICLE_SPEED = 5, PARTICLE_SPEED_HIGH = 10, PARTICLE_LIFE = 60, PARTICLE_LIFE_SHORT = 30;
final float PARTICLE_GRAVITY = 0.4;
final String NO_TEXT = "";
float HighscoreOffline = 0;

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
  final int MELEE_DAMAGE = 25, ARROW_DAMAGE = 15, ARCHER_DAMAGE = 25, SPIKE_DAMAGE = 15, FEEDBACK_PARTICLE_AMOUNT = 1;
  final float FEEDBACK_PARTICLE_GRAVITY = -0.5, FEEDBACK_PARTICLE_AREA= 0, FEEDBACK_PARTICLE_SPEED= 0;
  // tutorial
  float tutX, tutY, buttonSize;
  String tutText;
  color circleColor = YELLOW;
  float buttonX, buttonY, buttontextX, buttontextY, tutorialImgY, TutImgX, tutDashX;
  //HEALTHBAR
  final int NO_HEALTH = 0;
  final float MAX_HEALTH = 100;
  float healthBarX, healthBarY, healthBarCurve, healthBarCurveNormal, healthBarLength, healthBarHeight, healthMult, health;
  color healthC = color(RED, 255);
  //dashbar
  float dashmain, dashH, dashL, dashL2, dashX, dashY, dashX2, dashL3, dashX3;
  final float DASHCHARGE_PARTICLE_AMOUNT = 100, DASHCHARGE_PARTICLE_GRAVITY = 0.01;
  float[] dashChargeX = new float[4];
  boolean charge1 = false, charge2 = false, charge3 = false;
  //score
  float scoreX, scoreY, scoreSize, score, scoreNormal;
  //game over
  boolean getHighscore=false;
  float Highscore = 0;
  String gOver, newHighscore;
  float gOverX, gOverY, goFadeIn, gOSize;
  boolean death;
  float nice = 69;
  //highscore
  float highscoreY, goScoreY;

  HUD() {
    //tutorial
    tutX = width/2;
    tutY = height/4;
    tutText = "";
    buttonSize = 35;
    buttonX = globalScale*1.7;
    buttonY = 115;
    buttontextY = 100;
    tutorialImgY = 120;
    TutImgX = globalScale*2;
    tutDashX = globalScale*1.5;
    //healthbar
    healthBarX = 30+(globalScale/18);
    healthBarY = 40;
    healthBarLength = globalScale*4;
    healthBarHeight = globalScale*0.8;
    /*als je jou object of enemy damage wil laten gebruik je health*/
    health = MAX_HEALTH;
    healthMult = 1;
    death = false;
    //dash bar
    dashH = healthBarHeight/3;
    dashL = dashX;
    dashL2 = dashX2;
    dashL3 = dashX3;
    dashChargeX[0] = healthBarLength*.25;
    dashChargeX[1] = healthBarLength*.5;
    dashChargeX[2] = healthBarLength*.75;
    dashX = healthBarX;
    dashX2 = healthBarLength*0.35;
    dashX3 = healthBarLength*0.6;
    dashY = healthBarY+globalScale*1.5;
    //score
    scoreX = width*0.98;
    scoreY = width*0.039;
    scoreSize = width*0.025;
    scoreNormal = width*0.025;
    score = 0;
    //highscore
    newHighscore = "";
    highscoreY = 200;
    //game over
    gOver = "";
    gOverX = width/2;
    gOverY = height/2.3;
    gOSize = width*0.04;
    goFadeIn = 0;
    goScoreY = 100;
  }

  void update() {
    //score
    scoreSize = width*0.025+constrain(playerCatchUp*2, 0, 100);
    if (death==false&&room=="game") {
      score +=globalScrollSpeed/globalScale*10;
    }
    //healthbar
    //healthbar laat damage cooldown zien door donkerrood te worden
    //easter egg
    if (health==nice) {
      createParticle(healthBarX, scoreY, 0, PARTICLE_TEXT_SIZE, color(WHITE), color(WHITE), 1, 0, false, PARTICLE_LIFE_SHORT, "NICE ;)", FEEDBACK_PARTICLE_AMOUNT);
    }
    //als de player damage cooldown heeft wordt de healthbar donkerrood
    if (player.dmgCooldown >=0) {
      healthC = color(DARK_RED);
    } else {
      healthC = color(RED);
    }
    /*wanneer enemy collision heeft met player dan damage, geluid en particles*/
    if (player.enemyDamage==true&& death==false) {
      /*verander deze om enemy damage aan te passen*/
      //healthMult is voor de damagereduction als je de healthupgrade koopt
      if (meleeDamage==true) {
        meleeDmg.play();
        health = health-(MELEE_DAMAGE*healthMult);
        createParticle(player.x, player.y, FEEDBACK_PARTICLE_AREA, PARTICLE_TEXT_SIZE, color(BLACK), color(RED), FEEDBACK_PARTICLE_GRAVITY, FEEDBACK_PARTICLE_SPEED, false, PARTICLE_LIFE_SHORT, "-"+floor(MELEE_DAMAGE*healthMult), FEEDBACK_PARTICLE_AMOUNT);
        meleeDamage=false;
      }
      if ( arrowDamage==true) {
        arrowHit.play();
        health = health-(ARROW_DAMAGE*healthMult);
        createParticle(player.x, player.y, FEEDBACK_PARTICLE_AREA, PARTICLE_TEXT_SIZE, color(BLACK), color(RED), FEEDBACK_PARTICLE_GRAVITY, FEEDBACK_PARTICLE_SPEED, false, PARTICLE_LIFE_SHORT, "-"+floor(ARROW_DAMAGE*healthMult), FEEDBACK_PARTICLE_AMOUNT);
        arrowDamage=false;
      }
      if ( archerDamage==true) {
        health = health-(ARCHER_DAMAGE*healthMult);
        createParticle(player.x, player.y, FEEDBACK_PARTICLE_AREA, PARTICLE_TEXT_SIZE, color(BLACK), color(RED), FEEDBACK_PARTICLE_GRAVITY, FEEDBACK_PARTICLE_SPEED, false, PARTICLE_LIFE_SHORT, "-"+floor(ARCHER_DAMAGE*healthMult), FEEDBACK_PARTICLE_AMOUNT);
        archerDamage=false;
      }
      if ( spikeDamage==true) {
        spikeDmg.play();
        health = health-(SPIKE_DAMAGE*healthMult);
        createParticle(player.x, player.y, FEEDBACK_PARTICLE_AREA, PARTICLE_TEXT_SIZE, color(BLACK), color(RED), FEEDBACK_PARTICLE_GRAVITY, FEEDBACK_PARTICLE_SPEED, false, PARTICLE_LIFE_SHORT, "-"+floor(SPIKE_DAMAGE*healthMult), FEEDBACK_PARTICLE_AMOUNT);
        spikeDamage=false;
      }

      player.enemyDamage= false;
      healthC = color(WHITE);
    }
    if (health > MAX_HEALTH) health = MAX_HEALTH;
    //dash bar
    //particles wanneer een dashcharge is geladen
    if (charge1==true) {
      createParticle(dashChargeX[0], dashY, FEEDBACK_PARTICLE_AREA, PARTICLE_SIZE, color(0, 100, 200), color(0, 100, 255), DASHCHARGE_PARTICLE_GRAVITY, PARTICLE_SPEED, false, PARTICLE_LIFE_SHORT, NO_TEXT, DASHCHARGE_PARTICLE_AMOUNT);
    }
    if (charge2==true) {
      createParticle(dashChargeX[1], dashY, FEEDBACK_PARTICLE_AREA, PARTICLE_SIZE, color(0, 100, 200), color(0, 100, 255), DASHCHARGE_PARTICLE_GRAVITY, PARTICLE_SPEED, false, PARTICLE_LIFE_SHORT, NO_TEXT, DASHCHARGE_PARTICLE_AMOUNT);
    }
    if (charge3==true) {
      createParticle(dashChargeX[3], dashY, FEEDBACK_PARTICLE_AREA, PARTICLE_SIZE, color(0, 100, 200), color(0, 100, 255), DASHCHARGE_PARTICLE_GRAVITY, PARTICLE_SPEED, false, PARTICLE_LIFE_SHORT, NO_TEXT, DASHCHARGE_PARTICLE_AMOUNT);
    }
    //dashcharges worden hier gemaakt
    if (player.dashCooldown >=player.DASH_COOLDOWN_CHARGE) {

      dashL = dashChargeX[0];
    } else dashL=dashX;
    if (player.dashCooldown ==player.DASH_COOLDOWN_CHARGE-1) {
      charge1=true;
    } else charge1=false;
    if (player.dashCooldown >=player.DASH_COOLDOWN_CHARGE*2) {
      dashL2 = dashChargeX[1];
    } else dashL2=dashX2;
    if (player.dashCooldown == player.DASH_COOLDOWN_CHARGE*2-1) {
      charge2=true;
    } else charge2=false;
    if (player.dashCooldown >=player.DASH_COOLDOWN_CHARGE*3) {
      dashL3 = dashChargeX[2];
    } else dashL3 = dashX3;
    if (player.dashCooldown ==player.DASH_COOLDOWN_CHARGE*3-1) {
      charge3=true;
    } else charge3=false;

    //game over
    /*game over text*/
    if (score > HighscoreOffline && offline) {
      HighscoreOffline = score;
    }
    if (getHighscore ==true && !offline) {
      Highscore = floor(getScore(user.id, score));
      updateUser();
      updateAchievements();
      getHighscores();
    } else if (getHighscore ==true && offline) {
      Highscore = HighscoreOffline;
    }

    if (health <= NO_HEALTH) {
      getHighscore =true;
      death = true;
      health = NO_HEALTH;
    }
    if (Highscore!= NO_HEALTH) {
      getHighscore =false;
    } //navigatie in game over scherm
    if (death == true) {
      miniMarch.stop();
      /*makes GO text fade in*/
      gOver = "Game over";
      goFadeIn += 2;
      /*stops player movement*/
      player.moveSpeed = NO_HEALTH;
      //Q om naar main menu te gaan
      if (inputsPressed(keyM)) {
        Dede.stop();
        gameReset();
        room= "mainM";
      }
      /* B om opnieuw te proberen in beide modes*/
      if (inputsPressed.hasValue(keyB)==true && room=="game") {
        death = false;
        Dede.stop();
        gameReset();
        room = "game";
        march[0]= true;
        march[1]= true;
        march[2]= true;
        march[3]= true;
      }//death in de tutorial?
      if (inputsPressed(keyB)==true && room=="game2") {
        death = false;
        Dede.stop();
        gameReset();
        room = "game2";
        march[0] = false;
      }
    }    //tutorial
    //if statement voor tutorial mode plaatjes
    if (room=="game2") {
      fill(circleColor);
      ellipseMode(RADIUS);
      stroke(BLACK);
      strokeWeight(5);
      textSize(PARTICLE_TEXT_SIZE);
      tint(GREY);
      imageMode(CENTER);
      //tutorial plaatjes en button
      //jump tutorial
      if (traveledDistance >0 && traveledDistance <5) {
        tutText = "B";
        ellipse(player.x-buttonX, player.y-buttonY, buttonSize, buttonSize);
        fill(BLACK);
        text(tutText, player.x-TutImgX, player.y-buttontextY);
        image(playerSprite[4], player.x, player.y-tutorialImgY);
      } //dash tutorial
      else if (traveledDistance >5 &&traveledDistance <22) {
        circleColor = color(RED);
        tutText = "A";
        ellipse(player.x-buttonX, player.y-buttonY, buttonSize, buttonSize);
        fill(BLACK);
        text(tutText, player.x-TutImgX, player.y-buttontextY);
        image(playerSprite[5], player.x, player.y-tutorialImgY);
      } //dash door enemy tutorial
      else if (traveledDistance >25 && traveledDistance <55) {
        circleColor = color(RED);
        tutText = "A";
        ellipse(player.x-buttonX, player.y-buttonY, buttonSize, buttonSize);
        fill(BLACK);
        text(tutText, player.x-TutImgX, player.y-buttontextY);
        image(playerSprite[5], player.x, player.y-tutorialImgY);
        image(enemySprite[0], player.x+globalScale, player.y-tutorialImgY);
        image(enemyDeathSprite, player.x+TutImgX, player.y-tutorialImgY);
      } //dash voor vuur uit tutorial
      else if (traveledDistance >90 && traveledDistance <133) {
        circleColor = color(RED);
        tutText = "A";
        ellipse(player.x-buttonX, player.y-buttonY, buttonSize, buttonSize);
        fill(BLACK);
        text(tutText, player.x-TutImgX, player.y-buttontextY);
        image(fire, player.x, player.y-190, fireWidth, fireHeight);
        image(playerSprite[6], player.x, player.y-tutorialImgY);
        image(playerSprite[5], player.x+tutDashX, player.y-tutorialImgY);
        image(playerSprite[1], player.x+fireWidth, player.y-tutorialImgY);
      }
    }
    imageMode(CORNER);
    tint(WHITE);
  }
  void draw() {
    //healthbar
    /*healthbar backdrop*/
    fill(BLACK, 50);
    rect(healthBarX+(globalScale/3), healthBarY+(globalScale/3), healthBarLength*((constrain(MAX_HEALTH, NO_HEALTH, MAX_HEALTH))/MAX_HEALTH), globalScale*0.7);
    /*actual health indicator*/
    fill(healthC);
    rect(healthBarX+(globalScale/3), healthBarY+(globalScale/3), healthBarLength*((constrain(health, NO_HEALTH, MAX_HEALTH))/MAX_HEALTH), globalScale*0.7);
    /*health border*/
    image(healthbar, healthBarX, healthBarY, globalScale*4.6, globalScale*1.4);
    fill(WHITE);
    textSize(scoreNormal);
    text(floor(constrain(health, NO_HEALTH, MAX_HEALTH)), healthBarX+(globalScale/2), healthBarY+(globalScale*0.85));
    //dash charges
    stroke(BLACK);
    strokeWeight(20);
    line(dashX, dashY, dashL, dashY);
    line(dashX2, dashY, dashL2, dashY);
    line(dashX3, dashY, dashL3, dashY);
    stroke(0, 100, 200);
    strokeWeight(10);
    line(dashX, dashY, dashL, dashY);
    line(dashX2, dashY, dashL2, dashY);
    line(dashX3, dashY, dashL3, dashY);
    //score
    textAlign(RIGHT);
    fill(BLACK);
    textSize(scoreSize);
    text(floor(score), scoreX, scoreY);
    //particles die meer worden aan wanneer je aan de rechterkant van het scherm zit
    float catchUpX = width+50, catchUpY = scoreY+20, catchUpSize = constrain(floor(playerCatchUp/1.3), 0, 100), catchUpGravity = -0.1, catchUpSpeed = floor(playerCatchUp), catchUpAmount = 1;
    createParticle(catchUpX, catchUpY, 0, catchUpSize, color(WHITE), color(200), catchUpGravity, catchUpSpeed, false, PARTICLE_LIFE, NO_TEXT, catchUpAmount);
    stroke(BLACK);
    strokeWeight(2);
    line(width-(width/8), scoreY+20, width, scoreY+20);
    //coins
    textSize(scoreNormal);
    text(floor(coins), scoreX-30, scoreY+70);
    stroke(BLACK);
    fill(YELLOW);
    image(coin, scoreX-20+shake, scoreY+40, 40, 40);
    //Game Over text en score
    fill(#A300FC, goFadeIn);
    textAlign(CENTER);
    textSize(constrain(goFadeIn, 1, gOSize));
    text(gOver, gOverX-generalTextOffset-2, gOverY-generalTextOffset-generalTextOffset);
    text("score " + floor(score), gOverX-generalTextOffset, gOverY+goScoreY-generalTextOffset);
    fill(YELLOW, goFadeIn);
    text(gOver, gOverX+generalTextOffset, gOverY+generalTextOffset);
    text("score " + floor(score), gOverX+generalTextOffset, gOverY+goScoreY+generalTextOffset);
    fill(BLACK, goFadeIn);
    text(gOver, gOverX, gOverY);
    text("score " + floor(score), gOverX, gOverY+goScoreY);
    text(gOver, gOverX-generalTextOffset, gOverY-generalTextOffset);
    //highscore
    fill(#A300FC, goFadeIn);
    text("highscore "+floor(Highscore), gOverX-generalTextOffset, gOverY+highscoreY-generalTextOffset);
    text("                       Pos:"+scorePos, gOverX-generalTextOffset, gOverY+highscoreY-generalTextOffset);
    fill(YELLOW, goFadeIn);
    text(gOver, gOverX+generalTextOffset, gOverY+generalTextOffset);
    text("highscore " + floor(Highscore), gOverX+generalTextOffset, gOverY+highscoreY+generalTextOffset);
    text("                       Pos:"+scorePos, gOverX-generalTextOffset, gOverY+highscoreY+generalTextOffset);
    fill(BLACK, goFadeIn);
    text(gOver, gOverX, gOverY);
    text("highscore " + floor(Highscore), gOverX, gOverY+highscoreY);
    //NAVIGATION
    textAlign(LEFT);
    textSize(menu.tekstSize[2]);
    fill(WHITE, goFadeIn);
    text("Sta", menu.tekstX, menu.navTextY);
    fill(BLACK, goFadeIn);
    text("  " +"Retry", menu.tekstX+50, menu.navTextY);
    fill(WHITE, goFadeIn);
    text("Sel", menu.tekstX*2, menu.navTextY);
    fill(BLACK, goFadeIn);
    text("  "+"Menu", menu.tekstX*2+50, menu.navTextY);
  }
}
//PARTICLES////////////////////////////////////////
Particle[] particles = new Particle[10000];
//variablen die je kan invullen terwijl je je particles creert
void createParticle(float x, float y, float particleArea, float particleSize, color kleurMin, color kleurMax, float gravity, float speed, boolean collision, int life, String text, float count) {
  for (int i = 0; i < count; i++) {
    particles[freeParticleIndex()].enableParticle(x, y, particleArea, particleSize, kleurMin, kleurMax, gravity, speed, collision, life, text);
  }
}
//checkt of de particle actief is en kijkt voor een vrije plek in de particle array
int freeParticleIndex() {
  for (int i = 0; i < particles.length; i++) {
    if (particles[i].active == false) {
      return i;
    }
  }
  println("ERROR MAX("+particles.length+")ACTIVE PARTICLES REACHED");
  return particles.length-1;
}
void particleSetup() {
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle();
  }
}
void particleUpdate() {
  for (int i = 0; i < particles.length; i++) {
    if (particles[i].active == true) {
      particles[i].update();
    }
  }
}
void particleDraw() {
  for (int i = 0; i < particles.length; i++) {
    if (particles[i].active == true) {
      particles[i].draw();
    }
  }
}

class Particle {
  float x, y, vx, vy, size, count, gravity, life;
  color kleur;
  boolean active = false, collision = true;
  String text = "";
  int LifeMax = 60;

  // setup van de particle
  void enableParticle(float enteredValueX, float enteredValueY, float area, float enteredValueSize, color kleur1, color kleur2, float enteredValueGravity, float speed, boolean enteredValueCollision, int enteredValueLife, String enteredValueText) {
    x = enteredValueX;
    y = enteredValueY;
    size = enteredValueSize;
    //zorgt ervoor dat er binnen de 2 aangegeven kleurwaarden wordt gerandomised
    float per = random(1);
    float r = min(red(kleur1), red(kleur2))+ per *(max(red(kleur1), red(kleur2))-min(red(kleur1), red(kleur2)));
    float g = min(green(kleur1), green(kleur2))+ per *(max(green(kleur1), green(kleur2))-min(green(kleur1), green(kleur2)));
    float b = min(blue(kleur1), blue(kleur2))+ per *(max(blue(kleur1), blue(kleur2))-min(blue(kleur1), blue(kleur2)));
    kleur = color(r, g, b);
    gravity = enteredValueGravity;
    text = enteredValueText;
    collision = enteredValueCollision;
    //Direction
    float a;
    if (text == "") {
      a = random(-PI, PI);
    } else {
      a = PI;
    }
    speed = random(speed/10, speed);
    vx = sin(a)*speed;
    vy = cos(a)*speed;
    x -= sin(a)*random(area/2);
    y += cos(a)*random(area/2);
    active = true;
    LifeMax = enteredValueLife;
    life = LifeMax;
  }
  void update() {
    //checkt collision met alle blocks
    if (collision) {
      if (blockCollision(x, y, size) != null) {
        vx = 0;
        vy = 0;
      }
    }
    //zorgt ervoor dat de particles meescrollen met de map
    x -= vx+globalScrollSpeed;
    y += vy+globalVerticalSpeed;
    vy += gravity;
    //zorgt ervoor dat de particles faden
    if (life <= 0) {
      active = false;
    } else {
      life-=1;
    }
  }
  void draw() {
    noStroke();
    float alpha = 255*life/LifeMax;
    fill(kleur, alpha);
    //als er geen tekst is in createparticle dan zijn de particles squares
    if (text == "") {
      rect(x, y, size, size);
    } else {
      textSize(size);
      text(text, x, y);
    }
  }
}

//Collin en Mats
float shake =0, shakeResistance = 0.8;

void shakeUpdate() {
  if (!interfaces.death) {
    shake *= -shakeResistance;
  } else {
    shake = 0;
  }
}
void shake(float shakeDiameter) {
  if (!interfaces.death) {
    shake = shakeDiameter;
  }
}
