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
    if (hostileRanged[iHostile].isActive) {
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
    if (vx<0) {
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
    if (blockCollision(x+vx, y, size) != null) {
      while (blockCollision(x+sign(vx), y, size) == null) {
        x += sign(vx);
      }
      vx *= -1;
    } else if (blockCollision(x-size, y+1, size) == null || blockCollision(x+size, y+1, size) == null) {
      vx *= -1;
    }
    x += vx;

    //checkt collision met player
    if (player.Collision(x, y, size) && player.dashActive) {
      dead = true;
    } else if (player.hitboxCollision(x, y, size, size) && player.dmgCooldown < 0 && !dead) {
      player.enemyDamage = true;
      player.dmgCooldown = player.DMG_COOLDOWN;
    } 
    if (dead) {      
      reset();
      // x = -globalScale * 2;
      interfaces.score += ENEMYSCORE;
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
  boolean dead, isActive;

  HostileRanged() {
    size = globalScale;
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

  void update() {
    x -= globalScrollSpeed;

    if (player.Collision(x, y, size) && player.dashActive) {
      dead = true;
    } else if (player.hitboxCollision(x, y, size, size) && player.dmgCooldown < 0 && !dead) {
      player.enemyDamage = true;
      player.dmgCooldown = player.DMG_COOLDOWN;
    } 
    if (dead) {
      x = -globalScale*2;
      interfaces.score += ENEMYSCORE;
    }
  }

  void draw() {
    stroke(0);
    strokeWeight(2);
    fill(255, 0, 0);
    rect(x, y, size, size);
  }
}
