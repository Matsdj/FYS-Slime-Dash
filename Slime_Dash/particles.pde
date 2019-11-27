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

//maximum totaal aantal particles
int c =1000;
//aantal particles gespawned (niet editen, edit per onderdeel als het activeerd)
int particleamount = 0;
//minimale x coordinaat waar particles spawnen(niet editen, edit per onderdeel als het activeerd)
int particlexmin = 0;
//maximale x coordinaat waar particles spawnen(niet editen, edit per onderdeel als het activeerd)
int particlexmax = 0;
//minimale y coordinaat waar particles spawnen(niet editen, edit per onderdeel als het activeerd)
int particleymin = 0;
//maximale y coordinaat waar particles spawnen(niet editen, edit per onderdeel als het activeerd)
int particleymax = 0;
//de snelheid van particles in de x direction(niet editen, edit per onderdeel als het activeerd)
int particlespeedx = 0;
//de snelheid van particles in de y direction(niet editen, edit per onderdeel als het activeerd)
int particlespeedy = 0;
//de diameter van de particles(niet editen, edit per onderdeel als het activeerd)
int particlesize = 0;
//de roodintensitijd van de particles(niet editen, edit per onderdeel als het activeerd)
int particlered = 0;
//de groenintensitijd van de particles(niet editen, edit per onderdeel als het activeerd)
int particlegreen = 0;
//de blauwintensitijd van de particles(niet editen, edit per onderdeel als het activeerd)
int particleblue = 0;
//hoelang het duurt voordat de particles verdwijnen(niet editen, edit per onderdeel als het activeerd)
int particledecaytimer = 0;
//zet op true om de particles te laten spawnen(niet deze editen, maar allen in de andere lijnen code)
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
