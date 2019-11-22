//collin

//blue barricade
BlueL[] blueL;
void BlueLSetup()
{

  blueL = new BlueL[100];
}
void blueLUpdate() {
  for (int iBlueL =0; iBlueL< blueL.length; iBlueL++) {
    if (blueL[iBlueL] != null) {
      blueL[iBlueL].update();
      if (blueL[iBlueL].x < 0 - blueL[iBlueL].size) {
        blueL[iBlueL]= null;
      }
    }
  }
}

void addBlueL(float x, float y) {
  for (int iBlueL = 0; iBlueL < blueL.length; iBlueL++) {
    if (blueL[iBlueL] == null) {
      blueL[iBlueL] = new BlueL(x, y);
      break;
    }
  }
}
void blueLDraw() {
  for (int iBlueL = 0; iBlueL < blueL.length; iBlueL++) {
    if (blueL[iBlueL] != null) {
      blueL[iBlueL].draw();
    }
  }
}

class BlueL {
  float x, y, size;
  int timedoor = 0;


  BlueL(float inputX, float inputY) {

    x = inputX;
    y = inputY;

    size = globalScale;
    player.enemyDamage = false;
  }
  //controleerd op player aanraking
  void update() {
    if (switchC==1) {
      if ( player.hitboxCollision(x, y, size)&& player.dmgCooldown < 0) {
        player.enemyDamage=true;
        player.dmgCooldown = player.DMG_COOLDOWN;
      }
    }
    x -= globalScrollSpeed;
  }
}




//switch

Switch[] switchs;
void switchSetup()
{

  switchs = new Switch[100];
}
void switchsUpdate() {
  for (int iSwitch =0; iSwitch< switchs.length; iSwitch++) {
    if (switchs[iSwitch] != null) {
      switchs[iSwitch].update();
      if (switchs[iSwitch].x < 0 - switchs[iSwitch].size) {
        switchs[iSwitch]= null;
      }
    }
  }
}

void addSwitchs(float x, float y) {
  for (int iSwitch = 0; iSwitch < switchs.length; iSwitch++) {
    if (switchs[iSwitch] == null) {
      switchs[iSwitch] = new Switch(x, y);
      break;
    }
  }
}
void switchDraw() {
  for (int iSwitch = 0; iSwitch < switchs.length; iSwitch++) {
    if (switchs[iSwitch] != null) {
      switchs[iSwitch].draw();
    }
  }
}

class Switch {
  float x, y, size;
  int switchT=0;
  int switchS = 120;
  Switch(float inputX, float inputY) {

    x = inputX;
    y = inputY;

    size = globalScale;
    player.enemyDamage = false;
  }
  //controleerd op player aanraking
  void update() {
    if (switchT>0) {
      if ( player.hitboxCollision(x, y, size)) {
        if (switchT > switchS) {
          switchC = switchC+1;
        }
        if (switchC ==2 ) {
          switchC = 0;
        }
        switchT = switchT++;
      }
    }

    if (switchT>120) {
      switchT = 0;
    }
    x -= globalScrollSpeed;
  }


//yellow barricade


YellowL[] yellowL;
void BlueLSetup()
{

  yellowL = new YellowL[100];
}
void blueLUpdate() {
  for (int iYellowL =0; iYellowL< yellowL.length; iYellowL++) {
    if (yellowL[iYellowL] != null) {
      yellowL[iYellowL].update();
      if (yellowL[iYellowL].x < 0 - yellowL[iYellowL].size) {
        yellowL[iYellowL]= null;
      }
    }
  }
}

void addYellowL(float x, float y) {
  for (int iYellowL = 0; iYellowL < yellowL.length; iYellowL++) {
    if (yellowL[iYellowL] == null) {
      yellowL[iYellowL] = new YellowL(x, y);
      break;
    }
  }
}
void blueLDraw() {
  for (int iYellowL = 0; iYellowL < yellowL.length; iYellowL++) {
    if (yellowL[iYellowL] != null) {
      yellowL[iYellowL].draw();
    }
  }
}

class YellowL {
  float x, y, size;



  YellowL(float inputX, float inputY) {

    x = inputX;
    y = inputY;

    size = globalScale;
    player.enemyDamage = false;
  }
  //controleerd op player aanraking
  void update() {
    if (switchC==0) {
      if ( player.hitboxCollision(x, y, size)&& player.dmgCooldown < 0) {
        player.enemyDamage=true;
        player.dmgCooldown = player.DMG_COOLDOWN;
      }
    }
    x -= globalScrollSpeed;
  }
}



  //tekent de juiste bliksembarricade
  void draw()
  {
    stroke(0);
    fill (127);
    if (switchC==0) {
      fill (0, 0, 255);
      quad(x, y+size, x, y-size, x+size, y-size, x+size, y+size);
    }
    if (switchC==0) {
      fill (0, 255, 255);
      quad(x, y+size, x, y-size, x+size, y-size, x+size, y+size);
    }
  }
}
