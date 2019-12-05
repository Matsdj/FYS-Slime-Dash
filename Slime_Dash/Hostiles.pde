//Chris
HostileMelee[] hostileMelee;
HostileRanged[] hostileRanged;

final int HOSTILE_AMOUNT = 10;

final float ENEMYSCORE = 200;

final int ENEMY_SPRITE_AMOUNT = 2;

void hostileSetup() {
  hostileMelee = new HostileMelee[HOSTILE_AMOUNT];
  hostileRanged = new HostileRanged[HOSTILE_AMOUNT];

  for (int iHostile = 0; iHostile < HOSTILE_AMOUNT; iHostile++) {
    hostileMelee[iHostile] = new HostileMelee();
    hostileRanged[iHostile] = new HostileRanged();
  }
}
void addHostileMelee(float x, float y) {
  for (int iHostile = 0; iHostile < HOSTILE_AMOUNT; iHostile++) {
    if (!hostileMelee[iHostile].isActive) {
      hostileMelee[iHostile].activate(x, y);
      break;
    }
  }
}

void addHostileRanged(float x, float y) {
  for (int iHostile = 0; iHostile < HOSTILE_AMOUNT; iHostile++) {
    if (!hostileRanged[iHostile].isActive) {
      hostileRanged[iHostile].activate(x, y);
      break;
    }
  }
}

void hostileUpdate() {
  for (int iHostile = 0; iHostile < HOSTILE_AMOUNT; iHostile++) {
    if (hostileMelee[iHostile].isActive) {
      hostileMelee[iHostile].update();
    }
    if (hostileRanged[iHostile].isActive) {
      hostileRanged[iHostile].update();
    }
  }
}
void hostileDraw() {
  for (int iHostile = 0; iHostile < HOSTILE_AMOUNT; iHostile++) {
    if (hostileMelee[iHostile].isActive) {
      hostileMelee[iHostile].draw();
    }
    if (hostileRanged[iHostile].isActive) {
      hostileRanged[iHostile].draw();
    }
  }
}
class HostileMelee {
  final float WALK_SPEED = globalScale/32;
  int enemyWalkFrame;
  float size, x, y, vx;
  boolean dead, isActive;

  final int ENEMY_SPRITE_FRAMERATE = 20;

  HostileMelee() {
    size = globalScale;
    reset();
  }

  void reset() {
    isActive = false;
    x = -globalScale *10;
    y = -globalScale *10;
    vx = 0;
  }

  void activate(float activatex, float activatey) {
    isActive = true;
    dead = false;
    x = activatex;
    y = activatey;
    vx = WALK_SPEED;
  }

  void enemyAnimation() {
    //sprites 32*34
    if (dead) {
      image(enemyDeathSprite, x, y - globalScale/32*2);
    } else if (vx<0) {
      pushMatrix();
      scale(-1.0, 1.0);
      image(enemySprite[enemyWalkFrame], -x-globalScale, y - globalScale/32*2);
      popMatrix();
    } else {
      image(enemySprite[enemyWalkFrame], x, y - globalScale/32*2);
    }
  }
  void update() {
    x -= globalScrollSpeed;
    y += globalVerticalSpeed;

    //makes the enemy change direction when hitting a wall or a hole in the ground
    if (blockCollision(x+vx, y, size) != null) {
      while (blockCollision(x+sign(vx), y, size) == null) {
        x += sign(vx);
      }
      vx *= -1;
    } else if (blockCollision(x-size, y+1, size) == null || blockCollision(x+size, y+1, size) == null) {
      vx *= -1;
    }
    x += vx;

    //checks hitbox collision with player
    //if player dashes through the enemy, it dies
    if (player.Collision(x, y, size) && player.dashActive) {
      dead = true;
      interfaces.health += (interfaces.swordDMG/2);
      createParticle(x, y, 10, color(255, 0, 0), 0, 0.5, 5, 10);
    } else if (player.hitboxCollision(x, y, size, size) && player.dmgCooldown < 0 && !dead) {
      player.enemyDamage = true;
      player.dmgCooldown = player.DMG_COOLDOWN;
    } else if (x < 0 - globalScale *2) {
      reset();
    }

    if (dead) {
      vx = 0;
    }

    //animatie updates
    if (frameCount % ENEMY_SPRITE_FRAMERATE == 0) {
      enemyWalkFrame++;
    }
    if (enemyWalkFrame >= ENEMY_SPRITE_AMOUNT) {
      enemyWalkFrame = 0;
    }
  }


  void draw() {
    stroke(0);
    strokeWeight(2);
    fill(255, 0, 0);
    //rect(x, y, size, size);
    enemyAnimation();
  }
}

class HostileRanged {
  float x, y, size;
  final int ARROW_COOLDOWN_MAX = 120;
  final int ARCHER_SHOOT_FRAMES = 25;
  int arrowCooldown, enemyBreathFrame;
  boolean dead, isActive, isLeft;

  HostileRanged() {
    size = globalScale;
    arrowCooldown = ARROW_COOLDOWN_MAX;
    reset();
  }

  void reset() {
    isActive = false;
    x = -globalScale *10;
    y = -globalScale *10;
  }

  void activate(float activatex, float activatey) {
    isActive = true;
    dead = false;
    x = activatex;
    y = activatey;
  }

  void enemyAnimation() {
    if (isLeft) {
      pushMatrix();
      scale(-1.0, 1.0);
      image(archerSprite[enemyBreathFrame], -x-globalScale, y - globalScale/32);
      popMatrix();
    } else {
      image(archerSprite[enemyBreathFrame], x, y - globalScale/32);
    }
  }

  void update() {
    x -= globalScrollSpeed;
    y += globalVerticalSpeed;

    if (player.Collision(x, y, size) && player.dashActive) {
      dead = true;
    } else if (player.hitboxCollision(x, y, size, size) && player.dmgCooldown < 0 && !dead) {
      player.enemyDamage = true;
      player.dmgCooldown = player.DMG_COOLDOWN;
      createParticle(x, y, 10, color(255, 255, 0),0, 0.5, 5, 10);
    } 
    if (dead) {
      reset();
      //x = -globalScale*2;
      interfaces.score += ENEMYSCORE;
    }
    if (isActive) {
      for (int iArrow = 0; iArrow < ARROW_AMOUNT; iArrow++) {
        if (!ArrowList[iArrow].isActive && arrowCooldown < 0) {
          ArrowList[iArrow].activate(x + size / 2, y + (size / 2) - (ArrowList[iArrow].aHeight / 2), isLeft);
          arrowCooldown = ARROW_COOLDOWN_MAX;
          break;
        }
      }
    }
    if (x > player.x && isActive) {
      isLeft = true;
    } else {
      isLeft = false;
    }
    arrowCooldown--;

    //animation
    if (ARCHER_SHOOT_FRAMES > arrowCooldown) {
      enemyBreathFrame = 1;
    } else enemyBreathFrame = 0;
  }

  void draw() {
    enemyAnimation();
  }
}
