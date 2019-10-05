Interfaces interfaces = new Interfaces();
class Interfaces {

  int healthMain, healthL, healthH;
  float healthR;

  Interfaces() {
    //healthbar
    healthL = 250;
    healthH = 40;
    healthR = 20;
    /*als je jou object of enemy damage wil laten gebruik je healthMain*/
    healthMain = 100;
  }

  void update() {
    //healthbar
    /*zorgt ervoor dat de healthbar altijd de juiste ronding heeft*/
    noStroke();
    if (healthMain >= 95) {
      healthR= 20-((float(20)*(100-healthMain)/5));
    } else {
      healthR = 0;
    }
  }
  void draw() {
    //healthbar

    /*healthbar backdrop*/
    noStroke();
    fill(255, 255, 0);
    rect(50, 50, healthL, healthH, 20);
    /*actual health indicator*/
    noStroke();
    fill(255, 0, 0);
    rect(50, 50, healthL*(float(healthMain)/100), healthH, 20, healthR, healthR, 20);
    /*static border*/
    stroke(0);
    noFill();
    strokeWeight(2);
    rect(50, 50, healthL, healthH, 20);
  }
}
