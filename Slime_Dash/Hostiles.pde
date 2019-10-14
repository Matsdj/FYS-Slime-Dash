//Laurens

void hostileSetup() {
  hostile = new Hostile();
}

Hostile hostile;
class Hostile {
  float size, x, y, vx;

  Hostile() {
    size = globalScale;
    x = globalScale * 3;
    y = globalScale*10;
    vx = 2;
  }
  void update() {
    if(blockCollision(x+vx,y,size) != null){
      while(blockCollision(x+sign(vx),y,size) == null){
        x += sign(vx);
      }
      vx *= -1;
    }
    x += vx;

    //reset makes if statement run once when landing on ground
    if (x<=0) {
      x =0;
    } else if (x>= width-size) {
      x = width-size;
    }
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
