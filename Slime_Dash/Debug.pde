void debug(){
if (inputs.hasValue(128) || inputs.hasValue(96)) {
    if (debugLastFrame == false) {
      if (debug == false) {
        debug = true;
      } else {
        debug = false;
      }
    }
    debugLastFrame = true;
  } else debugLastFrame = false;
  if (debug == true) {
    fill(255, 0, 0);
    textSize(40);
    text(frameRate, width/2, 50);
    //for (int i = 0; ) {
    //  text(inputs.get(1), 20, 100);
    //}
  }
}
