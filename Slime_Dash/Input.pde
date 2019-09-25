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
