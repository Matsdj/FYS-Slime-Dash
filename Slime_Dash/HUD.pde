//Laurens
final color RED = color(255, 0, 0);
final color YELLOW = color(255, 255, 0);
final color BLACK = color(0);
final color WHITE = color(255);
final color GREY = color(180);
final int PARTICLE_TEXT_SIZE = 50;
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
  final int MELEE_DAMAGE = 25;
  final int ARROW_DAMAGE = 15;
  final int ARCHER_DAMAGE = 25;
  final int SPIKE_DAMAGE = 15;
  // tutorial
  float tutX, tutY;
  String tutText;
  PImage[] tutorial = new PImage[4];
  color circleColor = YELLOW;
  ;
  //HEALTHBAR
  final int NO_HEALTH = 0;
  final float MAX_HEALTH = 100;
  float healthBarX, healthBarY, healthBarCurve, healthBarCurveNormal, healthBarLength, healthBarHeight, healthMult, health;
  color healthC = color(RED, 255);
  //dashbar
  float dashmain, dashH, dashL, dashL2, dashX, dashY, dashX2, dashL3, dashX3;
  boolean charge1 = false, charge2 = false, charge3 = false;
  //score
  float scoreX, scoreY, scoreSize, score, scoreNormal;
  //game over
  boolean getHighscore=false;
  float Highscore = 0;
  String gOver;
  float gOverX, gOverY, goFadeIn, gOSize;
  boolean death;

  //coins

  HUD() {
    //tutorial
    tutX = width/2;
    tutY = height/4;
    tutText = "";
    tutorial[0] = playerSprite[4];
    //healthbar
    healthBarX = 30+(globalScale/18);
    healthBarY = 40;
    healthBarLength = globalScale*4;
    healthBarHeight = globalScale*0.8;
    healthBarCurve = 20;
    healthBarCurveNormal = 20;
    /*als je jou object of enemy damage wil laten gebruik je health*/
    health = MAX_HEALTH;
    healthMult = 1;
    death = false;
    //dash bar
    dashH = healthBarHeight/3;
    dashL = dashX;
    dashL2 = dashX2;
    dashL3 = dashX3;
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
    //healthbar laat damage cooldown zien door donkerrood te worden
    //easter egg
    if (health==69) {
      createParticle(healthBarX, scoreY, 0, PARTICLE_TEXT_SIZE, color(WHITE), color(WHITE), 1, 0, false, 30, "NICE ;)", 1);
    }
    //als de player damage cooldown heeft wordt de healthbar donkerrood
    if (player.dmgCooldown >=0) {
      healthC = color(150, 0, 0);
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
        createParticle(player.x, player.y, 0, PARTICLE_TEXT_SIZE, color(BLACK), color(RED), -0.5, 0, false, 30, "-"+floor(MELEE_DAMAGE*healthMult), 1);
        meleeDamage=false;
      }
      if ( arrowDamage==true) {
        arrowHit.play();
        health = health-(ARROW_DAMAGE*healthMult);
        createParticle(player.x, player.y, 0, PARTICLE_TEXT_SIZE, color(BLACK), color(RED), -0.5, 0, false, 30, "-"+floor(ARROW_DAMAGE*healthMult), 1);
        arrowDamage=false;
      }
      if ( archerDamage==true) {
        health = health-(ARCHER_DAMAGE*healthMult);
        createParticle(player.x, player.y, 0, PARTICLE_TEXT_SIZE, color(BLACK), color(RED), -0.5, 0, false, 30, "-"+floor(ARCHER_DAMAGE*healthMult), 1);
        archerDamage=false;
      }
      if ( spikeDamage==true) {
        spikeDmg.play();
        health = health-(SPIKE_DAMAGE*healthMult);
        createParticle(player.x, player.y, 0, PARTICLE_TEXT_SIZE, color(BLACK), color(RED), -0.5, 0, false, 30, "-"+floor(SPIKE_DAMAGE*healthMult), 1);
        spikeDamage=false;
      }

      player.enemyDamage= false;
      healthC = color(WHITE);
    }

    //dash bar
    //particles wanneer een dashcharge is geladen
    if (charge1==true) {
      createParticle(healthBarLength*0.25, dashY, 0, 10, color(0, 100, 200), color(0, 100, 255), .01, 5, false, 30, "", 100);
    }
    if (charge2==true) {
      createParticle(healthBarLength*0.5, dashY, 0, 10, color(0, 100, 200), color(0, 100, 255), .01, 5, false, 30, "", 100);
    }
    if (charge3==true) {
      createParticle(healthBarLength*0.75, dashY, 0, 10, color(0, 100, 200), color(0, 100, 255), .01, 5, false, 30, "", 100);
    }
    //dashcharges worden hier gemaakt
    if (player.dashCooldown >=player.DASH_COOLDOWN_CHARGE) {

      dashL = healthBarLength*0.25;
    } else dashL=dashX;
    if (player.dashCooldown ==player.DASH_COOLDOWN_CHARGE-1) {
      charge1=true;
    } else charge1=false;
    if (player.dashCooldown >=player.DASH_COOLDOWN_CHARGE*2) {
      dashL2 = healthBarLength*0.5;
    } else dashL2=dashX2;
    if (player.dashCooldown == player.DASH_COOLDOWN_CHARGE*2-1) {
      charge2=true;
    } else charge2=false;
    if (player.dashCooldown >=player.DASH_COOLDOWN_CHARGE*3) {
      dashL3 = healthBarLength*0.75;
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
    } else if (getHighscore ==true && offline) {
      Highscore = HighscoreOffline;
    }

    if (health <= NO_HEALTH) {
      getHighscore =true;
      death = true;
      health = NO_HEALTH;
    }
    if (Highscore!= 0) {
      getHighscore =false;
    } //navigatie in game over scherm
    if (death == true) {
      miniMarch.stop();
      /*makes GO text fade in*/
      gOver = "Game over";
      goFadeIn += 2;
      /*stops player movement*/
      player.moveSpeed = 0;
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
      textSize(menu.tekstSize[1]);
      tint(155);
      imageMode(CENTER);
      //tutorial plaatjes en button
      //jump tutorial
      if (traveledDistance >0 && traveledDistance <5) {
        tutText = "B";
        ellipse(player.x-(globalScale*2)+(width/100), player.y-115, 35, 35);
        fill(BLACK);
        text(tutText, player.x-(globalScale*2), player.y-100);
        image(playerSprite[4], player.x, player.y-120);
      } //dash tutorial
      else if (traveledDistance >5 &&traveledDistance <22) {
        circleColor = color(RED);
        tutText = "A";
        ellipse(player.x-(globalScale*2)+(width/100), player.y-115, 35, 35);
        fill(BLACK);
        text(tutText, player.x-(globalScale*2), player.y-100);
        image(playerSprite[5], player.x, player.y-120);
      } //dash door enemy tutorial
      else if (traveledDistance >25 && traveledDistance <55) {
        circleColor = color(RED);
        tutText = "A";
        ellipse(player.x-(globalScale*2)+(width/100), player.y-115, 35, 35);
        fill(BLACK);
        text(tutText, player.x-(globalScale*2), player.y-100);
        image(playerSprite[5], player.x, player.y-120);
        image(enemySprite[0], player.x+globalScale, player.y-120);
        image(enemyDeathSprite, player.x+globalScale*2, player.y-120);
      } //dash voor vuur uit tutorial
      else if (traveledDistance >90 && traveledDistance <133) {
        circleColor = color(RED);
        tutText = "A";
        ellipse(player.x-(globalScale*2)+(width/100), player.y-115, 35, 35);
        fill(BLACK);
        text(tutText, player.x-(globalScale*2), player.y-100);
        image(fire, player.x, player.y-190, globalScale*3, globalScale*3);
        image(playerSprite[6], player.x, player.y-120);
        image(playerSprite[5], player.x+globalScale*1.5, player.y-120);
        image(playerSprite[1], player.x+globalScale*3, player.y-120);
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
    if (health > MAX_HEALTH) health = MAX_HEALTH;
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
    if (death==false&&room=="game") {
      score +=globalScrollSpeed/globalScale*10;
    }
    textAlign(RIGHT);
    fill(BLACK);
    textSize(scoreSize);
    text(floor(score), scoreX, scoreY);
    //particles die meer worden aan wanneer je aan de rechterkant van het scherm zit
    float catchUpX = width+50, catchUpY = scoreY+20, catchUpSize = constrain(floor(playerCatchUp/1.3), 0, 100), catchUpGravity = -0.1, catchUpSpeed = floor(playerCatchUp), catchUpAmount = 1;
    createParticle(catchUpX, catchUpY, 0, catchUpSize, color(WHITE), color(200), catchUpGravity, catchUpSpeed, false, 60, "", catchUpAmount);
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
    text(gOver, gOverX-generalTextOffset-2, gOverY-generalTextOffset-2);
    text("score " + floor(score), gOverX-generalTextOffset, gOverY+98);
    fill(YELLOW, goFadeIn);
    text(gOver, gOverX+generalTextOffset, gOverY+generalTextOffset);
    text("score " + floor(score), gOverX+generalTextOffset, gOverY+102);
    fill(BLACK, goFadeIn);
    text(gOver, gOverX, gOverY);
    text("score " + floor(score), gOverX, gOverY+100);
    text(gOver, gOverX-generalTextOffset, gOverY-generalTextOffset);
    //highscore
    fill(#A300FC, goFadeIn);
    text("highscore " + floor(Highscore), gOverX-generalTextOffset, gOverY+148);
    fill(YELLOW, goFadeIn);
    text(gOver, gOverX+generalTextOffset, gOverY+generalTextOffset);
    text("highscore " + floor(Highscore), gOverX+generalTextOffset, gOverY+152);
    fill(BLACK, goFadeIn);
    text(gOver, gOverX, gOverY);
    text("highscore " + floor(Highscore), gOverX, gOverY+150);
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

//Mats en Laurens
Particle[] particles = new Particle[10000];
//variablen die je kan invullen terwijl je je particles creert
void createParticle(float x, float y, float particleArea, float particleSize, color kleurMin, color kleurMax, float gravity, float speed, boolean collision, int life, String text, float count) {
  for (int i = 0; i < count; i++) {
    particles[freeParticleIndex()].enableParticle(x, y, particleArea, particleSize, kleurMin, kleurMax, gravity, speed, collision, life, text);
  }
}
void particleDashable(float x, float y, float area) {
  createParticle(x, y, area, 5, color(0, 255, 0), color(100, 255, 100), 0, 2, false, 30, "", 1);
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
  void enableParticle(float ix, float iy, float area, float iSize, color kleurMin, color kleurMax, float iGravity, float speed, boolean iCollision, int iLife, String iText) {
    x = ix;
    y = iy;
    size = iSize;
    float per = random(1);
    float r = min(red(kleurMin), red(kleurMax))+ per *(max(red(kleurMin), red(kleurMax))-min(red(kleurMin), red(kleurMax)));
    float g = min(green(kleurMin), green(kleurMax))+ per *(max(green(kleurMin), green(kleurMax))-min(green(kleurMin), green(kleurMax)));
    float b = min(blue(kleurMin), blue(kleurMax))+ per *(max(blue(kleurMin), blue(kleurMax))-min(blue(kleurMin), blue(kleurMax)));
    kleur = color(r, g, b);
    gravity = iGravity;
    text = iText;
    collision = iCollision;
    //Direction
    float a;
    if (text == "") {
      a = random(-PI, PI);
    } else {
      a = 0;
    }
    speed = random(speed/10, speed);
    vx = sin(a)*speed;
    vy = cos(a)*speed;
    x -= sin(a)*random(area/2);
    y += cos(a)*random(area/2);
    active = true;
    LifeMax = iLife;
    life = LifeMax;
  }
  void update() {
    if (collision) {
      if (blockCollision(x, y, size) != null) {
        vx = 0;
        vy = 0;
      }
    }
    x -= vx*speedModifier+globalScrollSpeed;
    y += vy*speedModifier+globalVerticalSpeed;
    vy += gravity;
    if (life <= 0) {
      active = false;
    } else {
      life--;
    }
  }
  void draw() {
    noStroke();
    float alpha = 255*life/LifeMax;
    fill(kleur, alpha);
    if (text == "") {
      rect(x, y, size, size);
    } else {
      textSize(size);
      text(text, x, y);
    }
  }
}

//Collin
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
