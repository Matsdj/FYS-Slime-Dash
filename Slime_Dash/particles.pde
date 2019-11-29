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
  boolean gravity;


  Particle[] particle;

  //kracht van de gravity(zwaartekracht)
  float gravitystrength = 2;
  //maximum totaal aantal particles
  int c =1000;
  //aantal particles gespawned
  int particleamount = 0;
  //minimale x coordinaat waar particles spawnen
  int particlexmin = 0;
  //maximale x coordinaat waar particles spawnen
  int particlexmax = 0;
  //minimale y coordinaat waar particles spawnen
  int particleymin = 0;
  //maximale y coordinaat waar particles spawnen
  int particleymax = 0;
  //de minimalesnelheid van particles in de x direction
  int particlespeedxmin = 0;
  //de maximale snelheid van particles in de x direction
  int particlespeedxmax = 0;
  //de minimalesnelheid van particles in de y direction
  int particlespeedymin = 0;
  //de maximale snelheid van particles in de y direction
  int particlespeedymax = 0;
  //de diameter van de particles
  int particlesize = 0;
  //de roodintensitijd van de particles
  int particlered = 0;
  //de groenintensitijd van de particles
  int particlegreen = 0;
  //de blauwintensitijd van de particles
  int particleblue = 0;
  //hoelang het duurt voordat de particles verdwijnen
  int particledecaytimer = 0;
  //zet de zwaartekracht op particles aan
  boolean particlegravity = false;
  //zet op true om de particles te laten spawnen
  boolean activateparticles = false;
  //Gravity Speed Creator (niet editen op welke manier dan ook)
  float gsc = 0;


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
        particle[i].xs = random(particlespeedxmin, particlespeedxmax);
        particle[i].ys = random(particlespeedymin, particlespeedymax);
        particle[i].r = particlered;
        particle[i].g = particlegreen;
        particle[i].b = particleblue;
        particle[i].s = particlesize;
        particle[i].decay = particledecaytimer;
        particle[i].gravity = particlegravity;
        activateparticles=false;
        gsc = particle[i].decay;
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
    }





    for (int i = 0; i <particleamount; i++) {
      if (particle[i].decay > 0) {
        particle[i].decay = particle[i].decay - 1;

        fill( particle[i].r, particle[i].g, particle[i].b);
        circle(particle[i].x, particle[i].y, particle[i].s);
        particle[i].x = particle[i].x + particle[i].xs;
        particle[i].y = particle[i].y + particle[i].ys;
        if (particle[i].gravity == true) {
          particle[i].y = particle[i].y + (gravitystrength*(gsc-particle[i].decay));
        }
      }
    }
  }
}
