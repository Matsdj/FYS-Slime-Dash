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
  void update() {
    if (player.Collision(x - (0.5 * globalScale), y, pickupSize)) {
      pickedUp = true;
    }
    
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
