//Chris
HostileMelee[] hostileMelee;
HostileRanged[] hostileRanged;

int killCount = 0;

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
      image(enemySprite[enemyWalkFrame], -x-globalScale+shake, y - globalScale/32*2);
      popMatrix();
    } else {
      image(enemySprite[enemyWalkFrame], x+shake, y - globalScale/32*2);
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
    if (player.Collision(x, y, size) && player.dashActive && !dead) {
      if (meleeDeath.isPlaying() ==false) {
        damage.play();
        meleeDeath.play();
      }
      killCount++;
      dead = true;
      interfaces.score += ENEMYSCORE;
      createParticle(x+size/2, y+size/2, size, 10, color(255, 0, 0), 0, 2, 50, true, 60, "", 100);
      speedModifier = 0.001;
      shake(globalScale/2);
    } else if (player.hitboxCollision(x, y, size, size) && player.dmgCooldown < 0 && !dead) {
      player.enemyDamage = true;
      interfaces.meleeDamage = true;
      player.dmgCooldown = player.DMG_COOLDOWN;
      shake(player.DAMAGED_SHAKE_DIAMETER);
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
      image(archerSprite[enemyBreathFrame], -x-globalScale+shake, y - globalScale/32);
      popMatrix();
    } else {
      image(archerSprite[enemyBreathFrame], x+shake, y - globalScale/32);
    }
  }

  void update() {
    x -= globalScrollSpeed;
    y += globalVerticalSpeed;

    if (player.Collision(x, y, size) && player.dashActive && !dead) {
      damage.play();
      killCount++;
      dead = true;
      createParticle(x+size/2, y+size/2, size, 10, color(255, 0, 0), 0, 2, 50, true, 60, "", 100);
      speedModifier = 0.0001;
      shake(globalScale/2);
    } 
    if (player.hitboxCollision(x, y, size, size) && player.dmgCooldown < 0 && !dead) {
      player.enemyDamage = true;
      interfaces.archerDamage = true;
      player.dmgCooldown = player.DMG_COOLDOWN;
      shake(player.DAMAGED_SHAKE_DIAMETER);
    }

    if (dead) {
      reset();
      interfaces.score += ENEMYSCORE;
    } else if (x < 0 - globalScale *2) {
      reset();
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

//Ivano /////////////arrow//////////////////////
final int ARROW_AMOUNT = 20;

void arrowSetup() {
  ArrowList = new Arrow[ARROW_AMOUNT];

  for (int iArrow = 0; iArrow < ARROW_AMOUNT; iArrow++) {
    ArrowList[iArrow] = new Arrow();
  }
}

void arrowUpdate() {
  for (int iArrow = 0; iArrow < ARROW_AMOUNT; iArrow++) {
    if (ArrowList[iArrow].isActive) {
      ArrowList[iArrow].update();
    }
  }
}

void arrowDraw() {
  for (int iArrow = 0; iArrow < ARROW_AMOUNT; iArrow++) {
    if (ArrowList[iArrow].isActive) {
      ArrowList[iArrow].draw();
    }
  }
}

Arrow[] ArrowList;

class Arrow {
  final float ARROW_VELOCITY = globalScale/7;

  float x, y, vx, aWidth, aHeight;
  boolean isActive = false, goLeft, isHit = false, isLeft;

  Arrow() {
    aWidth = globalScale/32*28;
    aHeight = globalScale/32*7;
    reset();
  }

  void reset() {
    isActive = false;
    x = -globalScale *10;
    y = -globalScale *10;
  }

  void activate(float activatex, float activatey, boolean isLefti) {
    isActive = true;
    y = activatey;
    isLeft = isLefti;
    if (isLefti) {
      vx = -ARROW_VELOCITY;
      x = activatex - aWidth;
    } else {
      vx = ARROW_VELOCITY;
      x = activatex;
    }
  }

  void update() {
    x += vx;
    x -= globalScrollSpeed;
    y += globalVerticalSpeed;

    if (player.hitboxCollision(x, y, aWidth, aHeight) && vx != 0 &&player.dashActive==true) {
      reset();
    } else if (player.hitboxCollision(x, y, aWidth, aHeight) && vx != 0 && player.dashActive!=true) {
      interfaces.arrowDamage=true;
      player.enemyDamage = true;
      shake(player.DAMAGED_SHAKE_DIAMETER);
      reset();
    } 
    if (vx != 0 && blockCollision(x, y, aHeight) != null) {
      wallArrow.play();
      vx = 0;
    }
    if (x + aWidth < 0 || x > width) {
      reset();
    }
  }

  void draw() {
    if (isLeft) {
      pushMatrix();
      scale(-1.0, 1.0);
      image(arrowSprite, -x-arrowSprite.width+shake, y);
      popMatrix();
    } else image(arrowSprite, x+shake, y);
  }
}
