float shake =0, shakeResistance = 0.8;

void shakeUpdate() {
  shake *= -shakeResistance;
}
void shake(float shakeDiameter) {
  shake = shakeDiameter;
}
