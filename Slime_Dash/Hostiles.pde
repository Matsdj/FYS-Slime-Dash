void hostileSetup() {
  hostile = new Hostile();
}

Hostile hostile;
class Hostile {
  float ground, 
    size, 
    x, 
    y, 
    vx, 
    vy, 
    gravity, 
    dashSpeed, 

    dashTime;

  //terugzet waardes van de dashCooldown en dashTime
  boolean onGround, reset, enemyDamage;

  Hostile() {
    ground = height - globalScale;
    size = height/9;
    x = width/2;
    y = height/4;
    vx = 1;
    vy = 20;
    gravity = 1.5;
    enemyDamage = false;
  }
  void update() {
    vy *= frameSpeed;
    vx *= frameSpeed;
    gravity *= frameSpeed;
    vy += gravity;
    y += vy;
    x -=2;


    //checks if hostile is on ground
    if (y + size >= ground) {
      onGround = true;
    } else onGround = false;

    //stops falling once hostile hits ground
    if (y + size > ground && reset == false) {
      vy *= 0;
      gravity *= 0;
      y = ground - size;
      reset = true;
    } else reset = false;
    //reset makes if statement run once when landing on ground

    if (player.x+player.size >= x){
      player.pColor= 0;

    }
    if(player.pColor==0){
        enemyDamage = true;
    }
  }

  //method die checkt of collision met hostile waar is
  boolean hostileCollision(float cX, float cY, float cSize) {
    if (x + size > cX && x < cX + cSize && y + size > cY && y < cY + cSize) {
      return true;
    } else return false;
  }
  void draw() {
    stroke(0);
    strokeWeight(2);
    fill(255, 0, 0);
    rect(x, y, size, size);
  }
}
