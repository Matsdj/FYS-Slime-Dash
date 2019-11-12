void debug(){
if (inputsPressed.hasValue(96)) {
      if (debug == false) {
        debug = true;
      } else {
        debug = false;
      }
  }
  if (debug == true) {
    textAlign(LEFT);
    fill(255, 255, 255);
    textSize(40);
    text("fps:"+frameRate, 0, 150);
    String inputsString = "Inputs:";
    for (int i = 0; i < inputs.size(); i++) {
      inputsString += inputs.get(i) + "|";
    }
    text(inputsString,0,200);
    text("time:"+time,0,250);
    
  }
}
