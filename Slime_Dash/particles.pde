//Mats
Particle[] particles = new Particle[10000];

void createParticle(float x, float y, float size, color kleurMin, color kleurMax, float gravity, float speed, boolean collision, String text, float count) {
  for (int i = 0; i < count; i++) {
    particles[freeParticleIndex()].enableParticle(x, y, size, kleurMin, kleurMax, gravity, speed, collision, text);
  }
}
int freeParticleIndex() {
  int index = -1;
  for (int i = particles.length-1; i > 0; i--) {
    if (particles[i].active == false) {
      index = i;
    }
  }
  if (index == -1) {
    println("ERROR MAX("+particles.length+")ACTIVE PARTICLES REACHED");
    index = particles.length-1;
  }
  return index;
}
void particleSetup() {
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle();
  }
}
void particleUpdate() {
  for (int i = 0; i < particles.length; i++) {
    if (particles[i].active == true) {
      particles[i].update();
    }
  }
}
void particleDraw() {
  for (int i = 0; i < particles.length; i++) {
    if (particles[i].active == true) {
      particles[i].draw();
    }
  }
}

class Particle {
  float x, y, vx, vy, size, count, gravity, life;
  color kleur;
  boolean active = false, collision = true;
  String text = "";
  final int LIFE_MAX = 60;

  void enableParticle(float ix, float iy, float iSize, color kleurMin, color kleurMax, float iGravity, float speed, boolean iCollision, String iText) {
    x = ix;
    y = iy;
    size = iSize;
    float per = random(1);
    float r = min(red(kleurMin), red(kleurMax))+ per *(max(red(kleurMin), red(kleurMax))-min(red(kleurMin), red(kleurMax)));
    float g = min(green(kleurMin), green(kleurMax))+ per *(max(green(kleurMin), green(kleurMax))-min(green(kleurMin), green(kleurMax)));
    float b = min(blue(kleurMin), blue(kleurMax))+ per *(max(blue(kleurMin), blue(kleurMax))-min(blue(kleurMin), blue(kleurMax)));
    kleur = color(r, g, b);
    gravity = iGravity;
    text = iText;
    collision = iCollision;
    //Direction
    float a;
    if (text == "") {
      a = random(-PI, PI);
    } else {
      a = 0;
    }
    speed = random(speed/10, speed);
    vx = sin(a)*speed;
    vy = cos(a)*speed;
    active = true;
    life = LIFE_MAX;
  }
  void update() {
    if (collision) {
      if (blockCollision(x, y, size) != null) {
        vx = 0;
        vy = 0;
      }
    }
    x -= vx*speedModifier+globalScrollSpeed;
    y += vy*speedModifier+globalVerticalSpeed;
    vy += gravity;
    if (life <= 0) {
      active = false;
    } else {
      life--;
    }
  }
  void draw() {
    noStroke();
    fill(kleur);
    if (text == "") {
      rect(x, y, size, size);
    } else {
      text(text,x,y);
    }
  }
}
