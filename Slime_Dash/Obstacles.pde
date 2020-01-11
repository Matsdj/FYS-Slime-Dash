//collin

Spike[] spikes;
void spikeSetup()
{

  spikes = new Spike[100];
}
void spikeUpdate() {
  for (int iSpike =0; iSpike< spikes.length; iSpike++) {
    if (spikes[iSpike] != null) {
      spikes[iSpike].update();
      if (spikes[iSpike].x < 0 - spikes[iSpike].size) {
        spikes[iSpike]= null;
      }
    }
  }
}

void addSpike(float x, float y) {
  for (int iSpike = 0; iSpike < spikes.length; iSpike++) {
    if (spikes[iSpike] == null) {
      spikes[iSpike] = new Spike(x, y);
      break;
    }
  }
}
void spikeDraw() {
  for (int iSpike = 0; iSpike < spikes.length; iSpike++) {
    if (spikes[iSpike] != null) {
      spikes[iSpike].draw();
    }
  }
}

class Spike {
  float x, y, size;


  Spike(float inputX, float inputY) {

    x = inputX;
    y = inputY;

    size = globalScale;
    player.enemyDamage = false;
  }
  //controleerd op player aanraking
  void update() {

    if ( player.hitboxCollision(x, y, size, size)&& player.dmgCooldown < 0 && player.dashActive==false) {
      player.enemyDamage=true;
      interfaces.spikeDamage=true;
      player.dmgCooldown = player.DMG_COOLDOWN;
      shake(player.DAMAGED_SHAKE_DIAMETER);
    }
    x -= globalScrollSpeed;
    y += globalVerticalSpeed;
  }




  //tekent 2 spikes in een blokgrootte
  void draw()
  {
    /* stroke(0);
     fill (255, 0, 0);

     triangle(x+size/4, y, x+size/2, y+size, x, y+size);
     triangle(x+size/4*3, y, x+size/2, y+size, x+size, y+size);*/
    image(spikeSprite, x+shake, y);
  }
}

//collin
final int FLAME_SPRITE_AMOUNT = 7;
final int FLAME_ACTIVE_SPRITE_AMOUNT = 5;
boolean burn = false;
int burndamage = 0;
int totalburndamage = 15;
int burntimer = 0;
Flame[] flames;
void flameSetup()
{

  flames = new Flame[100];
}
void burnUpdate() {
  if (burn == true&&burndamage <= totalburndamage*60) {
    burndamage = burndamage +1;
    burntimer = burntimer+1;
    if (burntimer >= 60) {
      createParticle(player.x, player.y, 0, PARTICLE_TEXT_SIZE, color(YELLOW), color(RED), -0.5, 0, false, PARTICLE_LIFE_SHORT, "-1", 1);
      slimeBurn.play();
      burntimer-=60;
      interfaces.health = interfaces.health-1;
    }
    createParticle(player.x+player.size/2, player.y+player.size/2, player.size, PARTICLE_SIZE_SMALL, color(#FFF300), color(#FF9900), -.05, 2, true, PARTICLE_LIFE, NO_TEXT, 1);

    if (player.dashActive==true) {
      burn = false;
      createParticle(player.x+player.size/2, player.y+player.size/2, player.size, PARTICLE_SIZE_LARGE, color(#FFF300), color(#FF9900), -.2, 2, true, PARTICLE_LIFE, NO_TEXT, 3);
    } else if (interfaces.death) {
      burn = false;
    }
  } else burn = false;
}
void flameUpdate() {
  for (int iFlame =0; iFlame< flames.length; iFlame++) {
    if (flames[iFlame] != null) {
      flames[iFlame].update();
      if (flames[iFlame].x < 0 - flames[iFlame].size) {
        flames[iFlame]= null;
      }
    }
  }
  burnUpdate();
}

void addFlame(float x, float y) {
  for (int iFlame = 0; iFlame < flames.length; iFlame++) {
    if (flames[iFlame] == null) {
      flames[iFlame] = new Flame(x, y);
      break;
    }
  }
}
void flameDraw() {
  for (int iFlame = 0; iFlame < flames.length; iFlame++) {
    if (flames[iFlame] != null) {
      flames[iFlame].draw();
    }
  }
}

class Flame {
  float x, y, size;
  int timeflame = 0;
  int timeflamemax = 150;
  int timeflameCancel = int(timeflamemax * 0.75);
  int flameFrameCounter, activeFlameFramesAmount, flameCancelFrame;

  Flame(float inputX, float inputY) {

    x = inputX;
    y = inputY;

    flameFrameCounter = 0;
    activeFlameFramesAmount = timeflamemax/2 - timeflameCancel;
    flameCancelFrame = 10;

    size = globalScale;
    player.enemyDamage = false;
  }

  void flameAnimation() {
    float spriteY = y - globalScale;
    if (timeflame > timeflamemax/2) {
      image(flamethrowerSprite[flameFrameCounter], x, spriteY);
    } else if (timeflame <= flameCancelFrame) {
      image(flamethrowerSprite[6], x+shake, spriteY);
    } else {
      image(flamethrowerSprite[0], x+shake, spriteY);
    }
  }

  //controleerd op player aanraking
  void update() {
    timeflame = timeflame+1;

    if (timeflame>timeflamemax/2) {
      if ( player.hitboxCollision(x, y, size, size)) {
        interfaces.health = interfaces.health-0.5;
        burndamage = 0;
        if (player.dashActive==false) {
          burn = true;
        }
      }
      //animates flamethrower
      if (timeflame % (activeFlameFramesAmount/ FLAME_ACTIVE_SPRITE_AMOUNT) == 0) {
        flameFrameCounter ++;
      }
    } else {
      flameFrameCounter = 0;
    }

    x -= globalScrollSpeed;
    y += globalVerticalSpeed;


    if (timeflame>timeflameCancel) {
      timeflame = 0;
    }
  }

  //tekent 2 spikes in een blokgrootte
  void draw()
  {
    /* stroke(0);
     fill (127);

     triangle(x+size/2, y+size/5*4, x+size, y+size, x, y+size);
     if (timeflame>timeflamemax/2) {
     fill (194, 38, 31);
     quad(x+size/2, y+size/5*4, x, y-size/5*4, x+size/2, y-size, x+size, y-size/5*4);
     }*/
    flameAnimation();
  }
}
