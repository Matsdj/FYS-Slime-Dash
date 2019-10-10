// IVANO

void pickupsSetup() {
  pickups = new Pickups(500, height - (1.5 * globalScale), color(255, 255, 0));
}
Pickups pickups;

class Pickups {
  float x, y, pickupSize;
  boolean pickedUp;
  color c = color(255, 255, 0);
  Pickups(float px, float py, color pc) {
    x = px;
    y = py;
    c = pc;
    pickupSize = globalScale;
    pickedUp = false;
  }
// collision check of de player de coin aanraakt 
  void update() {
    if (player.Collision(x - (0.5 * globalScale), y - (0.5 * globalScale), pickupSize)) {
      pickedUp = true;
    }
// score update bij pickup van coin & reset terug naar false zodat er opnieuw een coin opgepakt kan worden    
    if (pickedUp == true) {
      interfaces.score += 100;
      x = random(0 + (0.5 * globalScale), width - (0.5 * globalScale));
      pickedUp = false;
    }
  }

  void draw() {
    fill(c);
    ellipse(x, y, pickupSize, pickupSize);
  }
}
