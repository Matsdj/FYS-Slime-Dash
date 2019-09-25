//healthbar
int hpLength, hpHeight;

  void HUDsettings() {
  hpLength = 250;
  hpHeight = 40;
}

void HealthBar() {
  strokeWeight(2);
  fill(#FF0000);
  rect(50, 50, hpLength, hpHeight, 20);
}
