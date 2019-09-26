void drawHealthBar(int healthPer) {
  int healthL, healthH ;
  float healthR;
  healthL = 250;
  healthH = 40;
  healthR = 20;


  noStroke();

  if (healthPer >= 95) {
    healthR= 20-((float(20)*(100-healthPer)/5));
  }
else{
  healthR = 0;
}
  fill(255, 255, 0);
  rect(50, 50, healthL, healthH, 20);

  //actual health
  fill(255, 0, 0);
  rect(50, 50, healthL*(float(healthPer)/100), healthH, 20, healthR, healthR, 20);



  //static border
  stroke(0);
  noFill();
  strokeWeight(2);
  rect(50, 50, healthL, healthH, 20);

  text(healthR, 100, 200);
}
