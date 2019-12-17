float shake =0, shakeResistance = 0.8;

void shakeUpdate() {
  float test = (1-shakeResistance)*(1-speedModifier);
  shake *= -shakeResistance+test;
}
void shake(float shakeDiameter) {
  shake = shakeDiameter;
}
