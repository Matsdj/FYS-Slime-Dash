//Mats

IntList inputs = new IntList();
//Alleen op de frame waarin de toets is ingedrukt bevat inputPressed de toets
IntList inputsPressed = new IntList();
int inputsPressedCooldown = 0;
final int INPUTS_PRESSED_COOLDOWN_MAX = 6;
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
  if (inputsPressedCooldown > 0) {
    inputsPressedCooldown--;
  }
}
boolean inputsPressed(int keyNumber) {
  if (inputsPressed.hasValue(keyNumber) && inputsPressedCooldown <= 0) {
    inputsPressedCooldown = INPUTS_PRESSED_COOLDOWN_MAX;
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
int keyZ = 90, keyT = 84;

//DEBUG///////////////////////////////////////////////
boolean debug = false, 
  testTemplates = false;
final int DEBUG_TEXT = 25;
void debug() {
  if (inputsPressed(96)) {
    if (debug == false) {
      debug = true;
    } else {
      debug = false;
    }
  }
  if (debug == true) {
    String debugText;
    textAlign(LEFT);
    fill(255, 255, 255);
    textSize(DEBUG_TEXT);
    debugText ="Fps:"+frameRate;
    String inputsString = "Inputs:";
    for (int i = 0; i < inputs.size(); i++) {
      inputsString += inputs.get(i) + "|";
    }
    debugText += ","+inputsString;
    debugText += ",Time:"+time;
    debugText += ",ScrollSpeed:"+globalScrollSpeed;
    debugText += ",Height:"+VerticalDistance;
    debugText += ",TravelDist:"+traveledDistance;
    debugText += ",Room:"+room;
    debugText += ",P.insideblock:"+player.insideBlock();
    debugText += ",ActiveBlocks:"+activeBlocks;
    debugText += ",TestTemplates:"+testTemplates;
    debugText += ",AllowVertical:"+ allowVerticalMovement;
    debugText += ",VerticalDistance:"+ VerticalDistance;
    debugText += ","+interfaces.scoreSize;
    String[] debugArray = debugText.split(",");
    for (int i = 0; i < debugArray.length; i++) {
      text(debugArray[i], 0, i*DEBUG_TEXT+height/4);
    }
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
