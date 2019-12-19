boolean debug = false, 
  testTemplates = false;
void debug() {
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
    text("Fps:"+frameRate, 0, 200);
    String inputsString = "Inputs:";
    for (int i = 0; i < inputs.size(); i++) {
      inputsString += inputs.get(i) + "|";
    }
    text(inputsString, 0, 250);
    text("Time:"+time, 0, 300);
    text("ScrollSpeed:"+globalScrollSpeed, 0, 350);
    text("Height:"+VerticalDistance, 0, 400);
    text("TravelDist:"+traveledDistance, 0, 450);
    text("Room:"+room, 0, 500);
    text("P.insideblock:"+player.insideBlock(), 0, 550);
    text("ActiveBlocks:"+activeBlocks, 0, 600);
    text("TestTemplates:"+testTemplates, 0, 650);
    text("Slow Mo:"+ speedModifier, 0, 700);
    text(interfaces.scoreSize, 0, 750);
    if (mousePressed) {
      player.x = mouseX-player.size/2;
      player.y = mouseY-player.size/2;
    }
    if (inputsPressed.hasValue(keyT)) {
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
