//Mats

IntList inputs = new IntList();
//Alleen op de frame waarin de toets is ingedrukt bevat inputPressed de toets
IntList inputsPressed = new IntList();
void keyPressed() {
  if (inputs.hasValue(keyCode) == false) {
    inputs.append(keyCode);
    inputsPressed.append(keyCode);
  }
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
/* Je kan dit gebruiken door:
 
 if (inputs.hasValue(keyCode) == true) {
 //de code die jij wil gebruiken wanneer er een toets ingedrukt wordt
 }
 vul bij keyCode gewoon het nummer van de key in.
 keyCodes kan je krijgen op: https://keycode.info
 
 */
