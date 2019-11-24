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
    text("Fps:"+frameRate, 0, 150);
    String inputsString = "Inputs:";
    for (int i = 0; i < inputs.size(); i++) {
      inputsString += inputs.get(i) + "|";
    }
    text(inputsString,0,200);
    text("Time:"+time+", "+"ScrollSpeed:"+globalScrollSpeed,0,250);
    text("Height:"+globalVerticalDistance,0,300);
    text("Distance Traveled:"+traveledDistance,0,350);
    text("Room:"+room,0,400);
    text("P.insideblock:"+player.insideBlock(),0,450);
    text("ActiveBlocks:"+activeBlocks,0,500);
    
  }
  fill(0);
}
