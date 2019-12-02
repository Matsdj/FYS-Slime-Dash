//Laurens

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




class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float size;
  int partKleur;

  Particle(PVector ding) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    position = ding.copy();
    lifespan = 255;
    size=8;
    partKleur = color(0);
  }

  void run() {
    update();
    display();
  }


  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.0;
    position.x -=globalScrollSpeed;
    if ( blockCollision(position.x, position.y+velocity.y, size) !=null) {
      while (blockCollision(position.x, position.y+sign(velocity.y), size) == null) {
        position.y += sign(velocity.y);
      }
      acceleration.y=0;
      velocity.y =0;
    }
    if ( blockCollision(position.x+velocity.x, position.y, size) !=null) {
      while (blockCollision(position.x+sign(velocity.x), position.y, size) == null) {
        position.x += sign(velocity.x);
      }
      acceleration.x=0;
      velocity.x =0;
    }
  }

  void display() {
    noStroke();
    partKleur++;
    fill(partKleur, lifespan);
    rect(position.x, position.y, size, size);
    //text("boop",position.x, position.y);
  }


  boolean isDead() {
    if (lifespan < 0.0||position.x<0) {
      return true;
    } else {
      return false;
    }
  }
}
