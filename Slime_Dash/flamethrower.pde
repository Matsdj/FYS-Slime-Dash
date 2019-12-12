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
void flameUpdate() {
  for (int iFlame =0; iFlame< flames.length; iFlame++) {
    if (flames[iFlame] != null) {
      flames[iFlame].update();
      if (flames[iFlame].x < 0 - flames[iFlame].size) {
        flames[iFlame]= null;
      }
    }
  }
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
      image(flamethrowerSprite[6], x, spriteY);
    } else {
      image(flamethrowerSprite[0], x, spriteY);
    }
  }

  //controleerd op player aanraking
  void update() {
    timeflame = timeflame+1;
    if (burn == true&&burndamage <= totalburndamage*60) {
      burndamage = burndamage +1;
      burntimer = burntimer+1;
      if (burntimer >= 60) {
        burntimer-=60;
        interfaces.health = interfaces.health-1;
      }
      createParticle(player.x+(player.hitSize/2), player.y+(player.hitSize/2), 5, color(#FFF300), color(#FF9900), -.05, 2, true, "", 1);
    } else burn = false;

    if (player.dashActive==true && burn == true) {
      burn = false;
      createParticle(player.x+(player.hitSize/2), player.y+(player.hitSize/2), 15, color(#FFF300), color(#FF9900), -.2, 2, true, "", 3);
    }
    if (timeflame>timeflamemax/2) {
      if ( player.hitboxCollision(x, y, size, size)) {
        interfaces.health = interfaces.health-0.5;
        burndamage = 0;
        if (player.dashActive==false) {
          burn = true;
        } else burn = false;
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
