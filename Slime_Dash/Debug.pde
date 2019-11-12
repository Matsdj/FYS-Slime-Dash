void debug(){
if (inputsPressed.hasValue(96)) {
      if (debug == false) {
        debug = true;
      } else {
        debug = false;
      }
  }
  if (debug == true) {
    fill(255, 0, 0);
    textSize(40);
    text(frameRate, width/2, 50);
    //for (int i = 0; ) {
    //  text(inputs.get(1), 20, 100);
    //}
  }
}
