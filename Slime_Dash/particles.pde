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
  //aantal particles gespawned (mag niet meer dan 249 per keer zijn)
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
  //de minimaleroodintensitijd van de particles
  int particleredmin = 0;
  //de maximaleroodintensitijd van de particles
  int particleredmax = 0;
  //de minimalegroenintensitijd van de particles
  int particlegreenmin = 0;
  //de maximalegroenintensitijd van de particles
  int particlegreenmax = 0;
  //de minimaleblauwintensitijd van de particles
  int particlebluemin = 0;
  //de maximaleblauwintensitijd van de particles
  int particlebluemax = 0;
  //hoelang het duurt voordat de particles verdwijnen
  int particledecaytimer = 0;
  //zet de zwaartekracht op particles aan
  boolean particlegravity = false;
  //zet op true om de particles te laten spawnen
  boolean activateparticles = false;
  //Gravity Speed Creator (niet editen op welke manier dan ook)
  float gsc = 0;
  //teller voor aantal verschilldende particles tegelijk (TotalDifferentParticles)(max is 8)
  int tdp = 0;
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
      if (tdp==1) {
        particleamount=particleamount+250;
      }
      if (tdp==2) {
        particleamount=particleamount+500;
      }
      if (tdp==3) {
        particleamount=particleamount+750;
      }
      if (tdp==4) {
        particleamount=particleamount+1000;
      }
      if (tdp==5) {
        particleamount=particleamount+1250;
      }
      if (tdp==6) {
        particleamount=particleamount+1500;
      }
      if (tdp==7) {
        particleamount=particleamount+1750;
      }
    }


    if (activateparticles==true&&tdp==0) {
      for (int i = 0; i <particleamount; i++) {
        particle[i].x = random(particlexmin, particlexmax);
        particle[i].y = random(particleymin, particleymax);
        particle[i].xs = random(particlespeedxmin, particlespeedxmax);
        particle[i].ys = random(particlespeedymin, particlespeedymax);
        particle[i].r = random(particleredmin, particleredmax);
        particle[i].g =  random(particlegreenmin, particlegreenmax);
        particle[i].b =  random(particlebluemin, particlebluemax);
        particle[i].s = particlesize;
        particle[i].decay = particledecaytimer;
        particle[i].gravity = particlegravity;
        gsc = particle[i].decay;
      }              
      activateparticles=false;
      tdp = 1;
    }


    if (activateparticles==true&&tdp==1) {
      for (int i = 250; i <particleamount; i++) {
        particle[i].x = random(particlexmin, particlexmax);
        particle[i].y = random(particleymin, particleymax);
        particle[i].xs = random(particlespeedxmin, particlespeedxmax);
        particle[i].ys = random(particlespeedymin, particlespeedymax);
        particle[i].r = random(particleredmin, particleredmax);
        particle[i].g =  random(particlegreenmin, particlegreenmax);
        particle[i].b = random(particlebluemin, particlebluemax);
        particle[i].s = particlesize;
        particle[i].decay = particledecaytimer;
        particle[i].gravity = particlegravity;
        gsc = particle[i].decay;
      }              
      activateparticles=false;
      tdp = 2;
    }

    if (activateparticles==true&&tdp==2) {
      for (int i = 500; i <particleamount; i++) {
        particle[i].x = random(particlexmin, particlexmax);
        particle[i].y = random(particleymin, particleymax);
        particle[i].xs = random(particlespeedxmin, particlespeedxmax);
        particle[i].ys = random(particlespeedymin, particlespeedymax);
        particle[i].r = random(particleredmin, particleredmax);
        particle[i].g =  random(particlegreenmin, particlegreenmax);
        particle[i].b = random(particlebluemin, particlebluemax);
        particle[i].s = particlesize;
        particle[i].decay = particledecaytimer;
        particle[i].gravity = particlegravity;
        gsc = particle[i].decay;
      }
      activateparticles=false;
      tdp = 3;
    }

    if (activateparticles==true&&tdp==3) {
      for (int i = 750; i <particleamount; i++) {
        particle[i].x = random(particlexmin, particlexmax);
        particle[i].y = random(particleymin, particleymax);
        particle[i].xs = random(particlespeedxmin, particlespeedxmax);
        particle[i].ys = random(particlespeedymin, particlespeedymax);
        particle[i].r = random(particleredmin, particleredmax);
        particle[i].g =  random(particlegreenmin, particlegreenmax);
        particle[i].b = random(particlebluemin, particlebluemax);
        particle[i].s = particlesize;
        particle[i].decay = particledecaytimer;
        particle[i].gravity = particlegravity;
        gsc = particle[i].decay;
      }
      activateparticles=false;
      tdp = 4;
    }

    if (activateparticles==true&&tdp==4) {
      for (int i = 1000; i <particleamount; i++) {
        particle[i].x = random(particlexmin, particlexmax);
        particle[i].y = random(particleymin, particleymax);
        particle[i].xs = random(particlespeedxmin, particlespeedxmax);
        particle[i].ys = random(particlespeedymin, particlespeedymax);
        particle[i].r = random(particleredmin, particleredmax);
        particle[i].g =  random(particlegreenmin, particlegreenmax);
        particle[i].b = random(particlebluemin, particlebluemax);
        particle[i].s = particlesize;
        particle[i].decay = particledecaytimer;
        particle[i].gravity = particlegravity;
        gsc = particle[i].decay;
      }
      activateparticles=false;
      tdp = 5;
    }


    if (activateparticles==true&&tdp==5) {
      for (int i = 1250; i <particleamount; i++) {
        particle[i].x = random(particlexmin, particlexmax);
        particle[i].y = random(particleymin, particleymax);
        particle[i].xs = random(particlespeedxmin, particlespeedxmax);
        particle[i].ys = random(particlespeedymin, particlespeedymax);
        particle[i].r = random(particleredmin, particleredmax);
        particle[i].g =  random(particlegreenmin, particlegreenmax);
        particle[i].b = random(particlebluemin, particlebluemax);
        particle[i].s = particlesize;
        particle[i].decay = particledecaytimer;
        particle[i].gravity = particlegravity;
        gsc = particle[i].decay;
      }
      activateparticles=false;
      tdp = 6;
    }


    if (activateparticles==true&&tdp==6) {
      for (int i = 1500; i <particleamount; i++) {
        particle[i].x = random(particlexmin, particlexmax);
        particle[i].y = random(particleymin, particleymax);
        particle[i].xs = random(particlespeedxmin, particlespeedxmax);
        particle[i].ys = random(particlespeedymin, particlespeedymax);
        particle[i].r = random(particleredmin, particleredmax);
        particle[i].g =  random(particlegreenmin, particlegreenmax);
        particle[i].b = random(particlebluemin, particlebluemax);
        particle[i].s = particlesize;
        particle[i].decay = particledecaytimer;
        particle[i].gravity = particlegravity;
        gsc = particle[i].decay;
      }
      activateparticles=false;
      tdp = 7;
    }

    if (activateparticles==true&&tdp==7) {
      for (int i = 1750; i <particleamount; i++) {
        particle[i].x = random(particlexmin, particlexmax);
        particle[i].y = random(particleymin, particleymax);
        particle[i].xs = random(particlespeedxmin, particlespeedxmax);
        particle[i].ys = random(particlespeedymin, particlespeedymax);
        particle[i].r = random(particleredmin, particleredmax);
        particle[i].g = random(particlegreenmin, particlegreenmax);
        particle[i].b = random(particlebluemin, particlebluemax);
        particle[i].s = particlesize;
        particle[i].decay = particledecaytimer;
        particle[i].gravity = particlegravity;
        gsc = particle[i].decay;
      }
      activateparticles=false;
      tdp = 0;
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
