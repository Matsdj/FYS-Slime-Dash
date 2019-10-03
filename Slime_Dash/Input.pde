IntList inputs = new IntList();
void keyPressed() {
  if (inputs.hasValue(keyCode) == false) {
    inputs.append(keyCode);
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
/* Je kan dit gebruiken door:
vul bij keyCode gewoon het nummer van de key in
keyCodes kan je krijgen op https://keycode.info
if (inputs.hasValue(keyCode) == true) {
  //de code die jij wil gebruiken wanneer er een toets ingedrukt wordt
}

*/
