//collin

void spikesetup()
{
  spike = new Spike()
}

Spike spike;
class Spike {
float x, y, size;
boolean enemyDamage;

Spike() {
x = 10;
y = 10;
size = GlobalScale;
}





void draw()
{
fill (255, 0, 0);
triangle(x, y+size, x+size, y+size, x+0.5*size, y);



}
}
