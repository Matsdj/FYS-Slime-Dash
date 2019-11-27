class Particle {

  float x;
  float y;
  float xs;
  float ys;
  float r;
  float g;
  float b;
  float s;
  float decay;
}

Particle[] particle;


int c =1000;
int particleamount = 0;
int particlexmin = 0;
int particlexmax = 0;
int particleymin = 0;
int particleymax = 0;
int particlespeedx = 0;
int particlespeedy = 0;
int particlesize = 0;
int particlered = 0;
int particlegreen = 0;
int particleblue = 0;
int particledecaytimer = 0;
boolean activateparticles = false;


//niet bewerken
int particletimertotal = 0;


void particlesetup() {

  particle = new Particle[c];

  for (int i = 0; i <c; i++) {
    particle[i] = new Particle();
  }
}


void activateparticles() {

  if (activateparticles==true) {
    for (int i = 0; i <particleamount; i++) {
      particle[i].x = random(particlexmin, particlexmax);
      particle[i].y = random(particleymin, particleymax);
      particle[i].xs = particlespeedx;
      particle[i].ys = particlespeedy;
      particle[i].r = particlered;
      particle[i].g = particlegreen;
      particle[i].b = particleblue;
      particle[i].s = particlesize;
      particle[i].decay = particledecaytimer;
      activateparticles=false;
    }
  }
  for (int i = 0; i <particleamount; i++) {
    particle[i].x = particle[i].x + particle[i].xs;
    particle[i].y = particle[i].y + particle[i].ys;
    if (particle[i].decay <= 0) {
      particle[i].x = 0;
      particle[i].y = 0;
      particle[i].xs = 0;
      particle[i].ys = 0;
      particle[i].r = 0;
      particle[i].g = 0;
      particle[i].b = 0;
      particle[i].s = 0;
    }
    if (particle[i].decay > 0) {
      particle[i].decay = particle[i].decay - 1;
    }
  }


  for (int i = 0; i <particleamount; i++) {
    fill( particle[i].r, particle[i].g, particle[i].b);
    circle(particle[i].x, particle[i].y, particle[i].s);
  }
}
