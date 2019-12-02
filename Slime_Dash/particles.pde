
// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 
ParticleSystem ps;
class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    particles.add(new Particle(origin));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}


// A simple Particle class

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float size;
  

  Particle(PVector ding) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    position = ding.copy();
    lifespan = 255;
    size=8;
  }

  void run() {
    update();
    display();
  }


  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.0;
   if ( blockCollision(position.x, position.y+velocity.y, size) !=null){
   acceleration = new PVector(0,0);
   velocity = new PVector(0,0);
   }
  }

  void display() {
    stroke(255, lifespan);
    fill(0, lifespan);
    rect(position.x, position.y, size, size);
  }


  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
