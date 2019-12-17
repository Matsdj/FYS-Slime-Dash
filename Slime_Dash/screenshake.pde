float xshake =0;
boolean shake = false;
boolean shakeLR = true;
boolean shakeUP = false;
int shakePower=0;
int shakePowerAdd=1;
int shakePowerMax=2;
int maxShake = 0;
int maxShakeSet = 256*4;
int shaketimer = 0;
//Ticks Per Time
int shaketimerTPT =1;
int shakeAmount =0;
int totalShakes =6;

void matsShake() {
  if (inputs.hasValue(68) == true) {
    xshake = globalScale;
  }
  if (!shake)
    xshake *= -0.8;
}
