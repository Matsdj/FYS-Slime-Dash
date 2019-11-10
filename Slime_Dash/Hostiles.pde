//Chris
Hostile[] hostile;
int hostileSize = 50;

final float ENEMYSCORE = 200;

PImage[] enemySprite;
final int ENEMY_SPRITE_AMOUNT = 2;

void hostileSetup() {
  hostile = new Hostile[hostileSize];

  enemySprite = new PImage[ENEMY_SPRITE_AMOUNT];
  for (int iSprite = 0; iSprite < ENEMY_SPRITE_AMOUNT; iSprite++) {
    enemySprite[iSprite] = loadImage("sprites/enemy/enemy"+ iSprite + ".png");
  }
}
void addHostile(float x, float y) {
  for (int iHostile = 0; iHostile < hostile.length; iHostile++) {
    if (hostile[iHostile] == null) {
      hostile[iHostile] = new Hostile(x, y);
      break;
    }
  }
}
void hostileUpdate() {
  for (int iHostile = 0; iHostile < hostile.length; iHostile++) {
    if (hostile[iHostile] != null) {
      hostile[iHostile].update();
      if (hostile[iHostile].x < 0 - hostile[iHostile].size) {
        hostile[iHostile]= null;
      }
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
  int enemyWalkFrame;
  float size, x, y, vx;
  boolean dead;

  final int ENEMY_SPRITE_FRAMERATE = 20;
  
  Hostile(float enemyX, float enemyY) {
    size = globalScale;
    x = enemyX;
    y = enemyY;
    vx = globalScale/30;
    dead = false;
  }

  void enemyAnimation() {
    //sprites 32*34
    if (vx<0) {
      pushMatrix();
      scale(-1.0, 1.0);
      image(enemySprite[enemyWalkFrame], -x-globalScale, y - globalScale/32*2, globalScale, globalScale + globalScale/32*2);
      popMatrix();
    } else {
      image(enemySprite[enemyWalkFrame], x, y - globalScale/32*2, globalScale, globalScale + globalScale/32*2);
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
    } else if (player.hitboxCollision(x, y, size) && player.dmgCooldown < 0 && !dead) {
      player.enemyDamage = true;
      player.dmgCooldown = player.DMG_COOLDOWN;
    } 
    if (dead) {
      x = -globalScale*2;
      interfaces.score += ENEMYSCORE;
    }
    
    //animatie updates
    if(frameCount % ENEMY_SPRITE_FRAMERATE == 0){
      enemyWalkFrame++;
    }
    if(enemyWalkFrame >= ENEMY_SPRITE_AMOUNT){
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
