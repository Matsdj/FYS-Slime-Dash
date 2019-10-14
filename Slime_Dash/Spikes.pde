//collin

Spike[] spikes;
void spikeSetup()
{

  spikes = new Spike[100];
}
void spikeUpdate(){
  for(int i =0; i< spikes.length; i++){
    if (spikes[i] != null){
    spikes[i].update();
    }
  }
}
// dit heb ik gecopieerd in de hoop dat ik het werkende kon krijgen
void addspike(float x, float y) {
  for (int iSpike = 0; iSpike < spikes.length; iSpike++) {
    if (spikes[iSpike] == null) {
      spikes[iSpike] = new Spike(x, y);
      break;
    } else if (spikes[iSpike].x < 0 - spikes[iSpike].size) {
      spikes[iSpike]= null;
    }
  }
}

class Spike {
  float x, y, size;
  boolean Damage;

  Spike(float inputX, float inputY) {

    x = inputX;
    y = inputY;

    size = globalScale;
    Damage = false;
  }
  //controleerd op player aanraking
  void update() {

    if ( player.Collision(x, y, size)&& player.dmgCooldown < 0) {
      Damage=true;
      player.dmgCooldown = player.DMG_COOLDOWN;
    }
    x -= globalScrollSpeed;
  }




  //tekent 2 spikes in een blokgrootte
  void draw()
  {
    stroke(0);
    fill (255, 0, 0);

    triangle(x+size/4, y, x+size/2, y+size, x, y+size);
    triangle(x+size/4*3, y, x+size/2, y+size, x+size, y+size);
  }
}
