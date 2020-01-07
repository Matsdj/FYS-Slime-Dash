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
