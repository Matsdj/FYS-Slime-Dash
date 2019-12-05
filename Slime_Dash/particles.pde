//Mats
Particle[] particles = new Particle[1000];

void createParticle(float x, float y, float size, color kleurMin, color kleurMax, float gravity, float speed, float count) {
  for (int i = 0; i < count; i++) {
    particles[freeParticleIndex()].enableParticle(x, y, size, kleurMin, kleurMax, gravity, speed);
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
  boolean active = false;
  final int LIFE_MAX = 60;

  void enableParticle(float ix, float iy, float iSize, color iKleurMin, color iKleurMax, float iGravity, float speed) {
    x = ix;
    y = iy;
    size = iSize;
    float r = red(iKleurMin);
    kleur = iKleurMin;
    gravity = iGravity;
    //Direction
    float a = random(-PI, PI);
    speed = random(speed/10,speed);
    vx = sin(a)*speed;
    vy = cos(a)*speed;
    active = true;
    life = LIFE_MAX;
  }
  void update() {
    if (blockCollision(x,y,size) != null){
      vx = 0;
      vy = 0;
    }
    x -= vx+globalScrollSpeed;
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
