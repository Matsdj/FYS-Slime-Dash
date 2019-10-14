//Chris
Hostile[] hostile;
int hostileSize = 50;

void hostileSetup() {
  hostile = new Hostile[hostileSize];
}
void addHostile(float x, float y) {
  for (int iHostile = 0; iHostile < hostile.length; iHostile++) {
    if (hostile[iHostile] == null){
      hostile[iHostile] = new Hostile(x,y);
      break;
    }
  }
}
void hostileUpdate() {
  for (int iHostile = 0; iHostile < hostile.length; iHostile++) {
    if (hostile[iHostile] != null) {
      hostile[iHostile].update();
    }
  }
}
void hostileDraw() {
  for (int iHostile = 0; iHostile < hostile.length; iHostile++) {
    if (hostile[iHostile] != null) {
      hostile[iHostile].draw();
    }
  }
}
class Hostile {
  float size, x, y, vx;

  Hostile(float enemyX, float enemyY) {
    size = globalScale;
    x = enemyX;
    y = enemyY;
    vx = 2;
  }
  void update() {
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
    if (player.Collision(x, y, size) && player.dmgCooldown < 0) {
      player.enemyDamage = true;
      player.dmgCooldown = player.DMG_COOLDOWN;
    }
  }


  void draw() {
    stroke(0);
    strokeWeight(2);
    fill(255, 0, 0);
    rect(x, y, size, size);
  }
}
