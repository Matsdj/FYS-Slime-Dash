//collin


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

  Flame(float inputX, float inputY) {

    x = inputX;
    y = inputY;

    size = globalScale;
    player.enemyDamage = false;
  }
  //controleerd op player aanraking
  void update() {
    if (timeflame>timeflamemax/2) {
      if ( player.hitboxCollision(x, y, size, size)&& player.dmgCooldown < 0) {
        player.enemyDamage=true;
        player.dmgCooldown = player.DMG_COOLDOWN;
      }
    }
    x -= globalScrollSpeed;
    y += globalVerticalSpeed;
  }




  //tekent 2 spikes in een blokgrootte
  void draw()
  {
    stroke(0);
    fill (127);
    timeflame = timeflame+1;
    triangle(x+size/2, y+size/5*4, x+size, y+size, x, y+size);
    if (timeflame>timeflamemax/2) {
      fill (194, 38, 31);
      quad(x+size/2, y+size/5*4, x, y-size/5*4, x+size/2, y-size, x+size, y-size/5*4);
    }
    if (timeflame>timeflamemax*0.75) {
      timeflame = 0;
    }
  }
}
