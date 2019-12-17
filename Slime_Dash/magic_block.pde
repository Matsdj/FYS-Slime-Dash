//collin

final int MAGIC_FRAME_AMOUNT = 3;
final int MAGIC_TYPE_AMOUNT = 2;
final int MAGIC_FRAMERATE = 10;

float MagicBarricadeDMG = 0;
boolean switchA = false;
boolean SwitchTimerA = false;
int SwitchTimer = 0;
int SwitchTimerMax = 90;
Magic1[] magic1s;
Magic2[] magic2s;
MagicSwitch[] magicSwitchs;


void magicBlockSetup() {
  magic1Setup();
  magic2Setup();
  magicSwitchSetup();
}

void magicBlockUpdate() {
  magic1Update();
  magic2Update();
  magicSwitchUpdate();
}

void magicBlockDraw() {
  magic1Draw();
  magic2Draw();
  magicSwitchDraw();
}

//first magic wall
void magic1Setup()
{

  magic1s = new Magic1[100];
}
void magic1Update() {
  for (int iMagic1 =0; iMagic1< magic1s.length; iMagic1++) {
    if (magic1s[iMagic1] != null) {
      magic1s[iMagic1].update();
      if (magic1s[iMagic1].x < 0 - magic1s[iMagic1].size) {
        magic1s[iMagic1]= null;
      }
    }
  }
}

void addMagic1(float x, float y) {
  for (int iMagic1 = 0; iMagic1 < magic1s.length; iMagic1++) {
    if (magic1s[iMagic1] == null) {
      magic1s[iMagic1] = new Magic1(x, y);
      break;
    }
  }
}
void magic1Draw() {
  for (int iMagic1 = 0; iMagic1 < magic1s.length; iMagic1++) {
    if (magic1s[iMagic1] != null) {
      magic1s[iMagic1].draw();
    }
  }
}

class Magic1 {
  float x, y, size, spriteY;
  int frameCounter;

  Magic1(float inputX, float inputY) {

    frameCounter = 0;
    x = inputX;
    y = inputY;

    size = globalScale;
    player.enemyDamage = false;
  }
  //controleerd op player aanraking
  void update() { 
    spriteY = y - globalScale;

    if ( player.hitboxCollision(x, y, size, size)&& player.dmgCooldown < 0&&switchA==true) {
      if (interfaces.health <= 40) {
        MagicBarricadeDMG = 20;
      }
      if (interfaces.health > 40) {
        MagicBarricadeDMG = interfaces.health/2;
      }
      player.enemyDamage=true;
      player.dmgCooldown = player.DMG_COOLDOWN;
      interfaces.health = interfaces.health - MagicBarricadeDMG;   }
    x -= globalScrollSpeed;
    y += globalVerticalSpeed;

    if (frameCount % MAGIC_FRAMERATE == 0) {
      frameCounter++;
      if (frameCounter >= MAGIC_FRAME_AMOUNT) {
        frameCounter = 0;
      }
    }
  }




  //tekent de eerste magic wall (rood)
  void draw()
  {
    /* stroke(0);
     fill (255, 0, 0);*/

    if (switchA==true) {
      /*fill (255, 0, 0);
       quad(x, y+size, x, y-size, x+size, y-size, x+size, y+size);*/
      image(magicSprite[0][frameCounter], x+xshake, spriteY);
    } else image(magicStaticSprite, x+xshake, spriteY);
  }
}






//second magic wall


void magic2Setup()
{

  magic2s = new Magic2[100];
}
void magic2Update() {
  for (int iMagic2 =0; iMagic2< magic2s.length; iMagic2++) {
    if (magic2s[iMagic2] != null) {
      magic2s[iMagic2].update();
      if (magic2s[iMagic2].x < 0 - magic2s[iMagic2].size) {
        magic2s[iMagic2]= null;
      }
    }
  }
}

void addMagic2(float x, float y) {
  for (int iMagic2 = 0; iMagic2 < magic2s.length; iMagic2++) {
    if (magic2s[iMagic2] == null) {
      magic2s[iMagic2] = new Magic2(x, y);
      break;
    }
  }
}
void magic2Draw() {
  for (int iMagic2 = 0; iMagic2 < magic2s.length; iMagic2++) {
    if (magic2s[iMagic2] != null) {
      magic2s[iMagic2].draw();
    }
  }
}

class Magic2 {
  float x, y, size, spriteY;
  int frameCounter;

  Magic2(float inputX, float inputY) {

    frameCounter = 0;
    x = inputX;
    y = inputY;

    size = globalScale;
    player.enemyDamage = false;
  }
  //controleerd op player aanraking
  void update() {
    spriteY = y - globalScale;

    if ( player.hitboxCollision(x, y, size, size)&& player.dmgCooldown < 0&&switchA==false) {
      if (interfaces.health <= 40) {
        MagicBarricadeDMG = 20;
      }
      if (interfaces.health > 40) {
        MagicBarricadeDMG = interfaces.health/2;
      }
      player.enemyDamage=true;
      player.dmgCooldown = player.DMG_COOLDOWN;
            interfaces.health = interfaces.health - MagicBarricadeDMG; 
    }
    x -= globalScrollSpeed;
    y += globalVerticalSpeed;

    if (frameCount % MAGIC_FRAMERATE == 0) {
      frameCounter++;
      if (frameCounter >= MAGIC_FRAME_AMOUNT) {
        frameCounter = 0;
      }
    }
  }




  //tekent de tweede magic block (blauw)
  void draw()
  {
    stroke(0);
    fill (255, 0, 0);

    if (switchA==false) {
      /*fill (255, 0, 0);
       quad(x, y+size, x, y-size, x+size, y-size, x+size, y+size);*/
      image(magicSprite[1][frameCounter], x+xshake, spriteY);
    } else image(magicStaticSprite, x+xshake, spriteY);
  }
}








//switch

void magicSwitchSetup()
{

  magicSwitchs = new MagicSwitch[100];
}
void magicSwitchUpdate() {
  for (int iMagicSwitch =0; iMagicSwitch< magicSwitchs.length; iMagicSwitch++) {
    if (magicSwitchs[iMagicSwitch] != null) {
      magicSwitchs[iMagicSwitch].update();
      if (magicSwitchs[iMagicSwitch].x < 0 - magicSwitchs[iMagicSwitch].size) {
        magicSwitchs[iMagicSwitch]= null;
      }
    }
  }
}

void addMagicSwitch(float x, float y) {
  for (int iMagicSwitch = 0; iMagicSwitch < magicSwitchs.length; iMagicSwitch++) {
    if (magicSwitchs[iMagicSwitch] == null) {
      magicSwitchs[iMagicSwitch] = new MagicSwitch(x, y);
      break;
    }
  }
}
void magicSwitchDraw() {
  for (int iMagicSwitch = 0; iMagicSwitch < magicSwitchs.length; iMagicSwitch++) {
    if (magicSwitchs[iMagicSwitch] != null) {
      magicSwitchs[iMagicSwitch].draw();
    }
  }
}

class MagicSwitch {
  float x, y, size;


  MagicSwitch(float inputX, float inputY) {

    x = inputX;
    y = inputY;

    size = globalScale;
    player.enemyDamage = false;
  }
  //controleerd op player aanraking
  void update() {

    if ( player.hitboxCollision(x, y, size, size)&& SwitchTimerA == false) {
      SwitchTimer = SwitchTimerMax;
      switchA = !switchA;
      SwitchTimerA = true;
    }
    x -= globalScrollSpeed;
    y += globalVerticalSpeed;
    if (SwitchTimerA==true) {
      SwitchTimer = SwitchTimer -1;
    }

    if (SwitchTimer<=0) {
      SwitchTimerA = false;
    }
  }




  //tekent de switch
  void draw()
  {
    stroke(0);
    fill (255, 0, 0);


    fill (140);
    quad(x+xshake, y+size, x+0.3*size+xshake, y+0.8*size, x+size-0.3*size+xshake, y+0.8*size, x+size+xshake, y+size);
    if (switchA==false) {
      fill(0, 0, 255);
      quad(x+0.3*size+xshake, y+0.8*size, x+size-0.3*size+xshake, y+0.8*size, x+size-0.4*size+xshake, y+0.7*size, x+0.4*size+xshake, y+0.7*size);
    }
    if (switchA==true) {
      fill(255, 0, 0);
      quad(x+0.3*size+xshake, y+0.8*size, x+size-0.3*size+xshake, y+0.8*size, x+size-0.4*size+xshake, y+0.7*size, x+0.4*size+xshake, y+0.7*size);
    }
  }
}
