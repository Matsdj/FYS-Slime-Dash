//collin
/*
Spike[] spike;
int ce = 1;
int c =0;
  void spikeSetup()
{

  spike = new Spike();
}

// dit heb ik gecopieerd in de hoop dat ik het werkende kon krijgen
void addspike(float x, float y) {
  for (int iSpike = 0; iSpike < hostile.length; iSpike++) {
    if (spike[iSpike] == null){
      spike[iSpike] = new spike(x,y);
      break;
    } else if(hostile[iSpike].x < 0 - hostile[iSpike].size){
      hostile[iSpike]= null;
    }
  }
}


Spike Spike;
class Spike {
 float x, y ;
  float size;
  boolean Damage;
/*
  Spike() {
    
    x[0] = globalScale*6;
    y[0] = globalScale*10;
    x[1] = globalScale*7;
    y[1] = globalScale*10;
    *//*
    size = globalScale;
    Damage = false;
  {}
  //controleerd op player aanraking
  void update() {

    if ( player.Collision(x[c], y[c], size)&& player.dmgCooldown < 0) {
      Damage=true;
      player.dmgCooldown = player.DMG_COOLDOWN;
    }
  }




  //tekent 2 spikes in een blokgrootte
  void draw()
  {
    stroke(0);
    fill (255, 0, 0);

      triangle(x[c]+size/4, y[c], x[c]+size/2, y[c]+size, x[c], y[c]+size);
      triangle(x[c]+size/4*3, y[c], x[c]+size/2, y[c]+size, x[c]+size, y[c]+size);
    
    if (c<=ce) {
      c=c+1;
    }
    if (c>ce) {
      c=0;
    }
  }


*/
