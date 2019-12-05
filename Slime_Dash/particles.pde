//Mats
Particle[] particles = new Particle[1000];

void createParticle(float x, float y, float size, color kleur, float gravity, float speed, float count) {
  for (int i = 0; i < count; i++) {
    particles[freeParticleIndex()].enableParticle(x, y, size, kleur, gravity, speed);
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
    index = particles.length;
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
  boolean active = false;
  final int LIFE_MAX = 120;

  void enableParticle(float ix, float iy, float iSize, color iKleur, float iGravity, float speed) {
    x = ix;
    y = iy;
    size = iSize;
    kleur = iKleur;
    gravity = iGravity;
    //Direction
    float a = random(-PI, PI);
    vx = sin(a)*speed;
    vy = sin(a)*speed;
    active = true;
    life = LIFE_MAX;
  }
  void update() {
    x += vx+globalScrollSpeed;
    y += vy+globalVerticalSpeed;
    vy += gravity;
    life--;
    if (life <= 0) {
      active = false;
    }
  }
  void draw() {
    noStroke();
    fill(kleur);
    rect(x, y, size, size);
  }
}
