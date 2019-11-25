//collin


int maxdoortimer = 900;
int doortimer = 0;
Door[] doors;
void dooreSetup()
{

  doors = new Door[100];
}
void doorUpdate() {
  for (int iDoor =0; iDoor< doors.length; iDoor++) {
    if (doors[iDoor] != null) {
      doors[iDoor].update();
      if (doors[iDoor].x < 0 - doors[iDoor].size) {
        doors[iDoor]= null;
      }
    }
  }
}

void addDoor(float x, float y) {
  for (int iDoor = 0; iDoor < doors.length; iDoor++) {
    if (doors[iDoor] == null) {
      doors[iDoor] = new Door(x, y);
      break;
     
    }
  }
}
void doorDraw() {
  for (int iDoor = 0; iDoor < doors.length; iDoor++) {
    if (doors[iDoor] != null) {
      doors[iDoor].draw();
    }
  }
}

class Door {
  float x, y, size;


  Door(float inputX, float inputY) {

    x = inputX;
    y = inputY;

    size = globalScale;
     player.enemyDamage = false;
  }
  //controleerd op player aanraking
  void update() {

    if ( player.hitboxCollision(x, y, size, size)&& doortimer<=0)
    {if (player.dashActive==true){
    player.dashActive=false;
    }
if (player.moving==true){
player.moving=false;
}
      
    }
    x -= globalScrollSpeed;
  }




  //tekent 2 spikes in een blokgrootte
  void draw()
  {
    stroke(0);
if(doortimer<=0)
      fill (139, 69, 19);
   quad(x, y+size, x, y-size, x+size, y-size, x+size, y+size);
  }
}



//collin

Button[] buttons;
void buttonSetup()
{

  buttons = new Button[100];
}
void buttonUpdate() {
  for (int iButton =0; iButton< buttons.length; iButton++) {
    if (buttons[iButton] != null) {
      buttons[iButton].update();
      if (buttons[iButton].x < 0 - buttons[iButton].size) {
        buttons[iButton]= null;
      }
    }
  }
}

void addButton(float x, float y) {
  for (int iButton = 0; iButton < buttons.length; iButton++) {
    if (buttons[iButton] == null) {
      buttons[iButton] = new Button(x, y);
      break;
     
    }
  }
}
void buttonDraw() {
  for (int iButton = 0; iButton < buttons.length; iButton++) {
    if (buttons[iButton] != null) {
      buttons[iButton].draw();
    }
  }
}

class Button {
  float x, y, size;


  Button(float inputX, float inputY) {

    x = inputX;
    y = inputY;

    size = globalScale;
     player.enemyDamage = false;
  }
  //controleerd op player aanraking
  void update() {

    if ( player.hitboxCollision(x, y, size, size)) {
 doortimer=maxdoortimer;
      
    }
    x -= globalScrollSpeed;
  }




  //tekent 2 spikes in een blokgrootte
  void draw()
  {
    stroke(0);
    fill (200, 200, 200);
    triangle(x+size/2, y+size/5*4, x+size, y+size, x, y+size);
  }
}
