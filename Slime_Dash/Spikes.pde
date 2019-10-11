//collin
int c = 3;
void spikeSetup()
{
     
      spike = new Spike();

}

Spike spike;
class Spike {
  float x, y, size;
  boolean Damage;

  Spike() {
    x = globalScale*6;
    y = globalScale*10;
    size = globalScale;
    Damage = false;
  }
  //controleerd op player aanraking
  void update() {

if( player.Collision(x,y,size)&& player.dmgCooldown < 0){
 Damage=true;
 player.dmgCooldown = player.DMG_COOLDOWN;

}


  

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
