//Mats

IntList inputs = new IntList();
//Alleen op de frame waarin de toets is ingedrukt bevat inputPressed de toets
IntList inputsPressed = new IntList();
void keyPressed() {
  if (inputs.hasValue(keyCode) == false) {
    inputs.append(keyCode);
    inputsPressed.append(keyCode);
  }
  if (keyCode == ESC) key = 0;
}
void keyReleased() {
  if (inputs.hasValue(keyCode) == true) {
    for (int i = 0; i < inputs.size(); i++) {
      if (inputs.get(i) == keyCode) {
        inputs.remove(i);
      }
    }
  }
}
void inputsPressedUpdate() {
  inputsPressed.clear();
}
boolean inputsPressed(int inputKeyCode){
  if (inputsPressed(inputKeyCode)){
    inputsPressed.removeValue(inputKeyCode);
    return true;
  } else {
    return false;
  }
}
/* Je kan dit gebruiken door:
 
 if (inputs.hasValue(keyCode) == true) {
 //de code die jij wil gebruiken wanneer er een toets ingedrukt wordt
 }
 vul bij keyCode gewoon het nummer van de key in.
 keyCodes kan je krijgen op: https://keycode.info
 
 */

//INPUT CODES
int keySpace = 32, keyQ = 81, keyP = 80, keyM = 77, keyB = 66;
int keyLeft = 37, keyRight = 39, keyUp = 38, keyDown = 40;
int keyZ = 90,keyT = 84;

//DEBUG///////////////////////////////////////////////
boolean debug = false, 
  testTemplates = false;
void debug() {
  if (inputsPressed(96)) {
    if (debug == false) {
      debug = true;
    } else {
      debug = false;
    }
  }
  if (debug == true) {
    textAlign(LEFT);
    fill(255, 255, 255);
    textSize(25);
    text("Fps:"+frameRate, 0, 200);
    String inputsString = "Inputs:";
    for (int i = 0; i < inputs.size(); i++) {
      inputsString += inputs.get(i) + "|";
    }
    text(inputsString, 0, 250);
    text("Time:"+time, 0, 275);
    text("ScrollSpeed:"+globalScrollSpeed, 0, 300);
    text("Height:"+VerticalDistance, 0, 325);
    text("TravelDist:"+traveledDistance, 0, 350);
    text("Room:"+room, 0, 375);
    text("P.insideblock:"+player.insideBlock(), 0, 400);
    text("ActiveBlocks:"+activeBlocks, 0, 425);
    text("TestTemplates:"+testTemplates, 0, 450);
    text("AllowVertical:"+ allowVerticalMovement, 0, 475);
    text("VerticalDistance:"+ VerticalDistance, 0, 500);
    text(interfaces.scoreSize, 0, 525);
    if (mousePressed) {
      player.x = mouseX-player.size/2;
      player.y = mouseY-player.size/2;
    }
    if (inputsPressed(keyT)) {
      if (testTemplates) {
        testTemplates = false;
      } else {
        testTemplates = true;
      }
    }
  } else {
    if (testTemplates) {
      testTemplates = false;
    }
  }
  fill(0);
}
