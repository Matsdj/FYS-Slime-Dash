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

if((player.x > spike.x && player.x < spike.x+size && player.y < spike.y && player.y > spike.y) || (player.x+globalScale > spike.x && player.x+globalScale < spike.x+size && player.y < spike.y && player.y > spike.y)) {
spike.Damage=true;

}
if((player.x > spike.x && player.x < spike.x+size && player.y+globalScale < spike.y && player.y+globalScale > spike.y) || (player.x+globalScale > spike.x && player.x+globalScale < spike.x+size && player.y+globalScale < spike.y && player.y+globalScale > spike.y)) {
spike.Damage=true;

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
