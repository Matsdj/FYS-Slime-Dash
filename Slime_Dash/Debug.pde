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
    text("Fps:"+frameRate, 0, 150);
    String inputsString = "Inputs:";
    for (int i = 0; i < inputs.size(); i++) {
      inputsString += inputs.get(i) + "|";
    }
    text(inputsString, 0, 200);
    text("Time:"+time, 0, 250);
    text("ScrollSpeed:"+globalScrollSpeed, 0, 300);
    text("Height:"+VerticalDistance, 0, 350);
    text("TravelDist:"+traveledDistance, 0, 400);
    text("Room:"+room, 0, 450);
    text("P.insideblock:"+player.insideBlock(), 0, 500);
    text("ActiveBlocks:"+activeBlocks, 0, 550);
    text("TestTemplates:"+testTemplates, 0, 600);
    text(playerCatchUp, 0, 650);
    text(interfaces.scoreSize, 0, 700);
    if (mousePressed) {
      player.x = mouseX;
      player.y = mouseY;
    }
    if (inputsPressed.hasValue(84)) {
      if (testTemplates) {
        testTemplates = false;
      } else {
        testTemplates = true;
      }
    }
  } else {
  if (testTemplates){
    testTemplates = false;
  }
  }
  fill(0);
}
