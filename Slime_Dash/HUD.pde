//healthbar
int healthL, healthH;

  void HUDsettings() {
  healthL = 250;
  healthH = 40;
}

void drawHealthBar() {
  strokeWeight(2);
  fill(#FF0000);
  rect(50, 50, healthL, healthH, 20);
}
