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

void ShakeUpdate() {
  if (inputs.hasValue(83) == true) {
    shake = true;
  }



  if (shaketimer < shaketimerTPT)
  {
    shaketimer =shaketimer+1;
  }

  if (shake == true && shaketimer>=shaketimerTPT) {
    if (shakeLR==true) {
      xshake = xshake + shakePower;
    }
    if (shakeLR==false) {
      xshake = xshake - shakePower;
    }
    if (shakeLR==true) {
      xshake = xshake + shakePower;
      if (xshake>=maxShake) {
        shakeLR=false;
      }
      if (xshake<=-maxShake) {
        shakeLR=true;
      }
      if (shakePower > shakePowerMax) {
        shakeUP=false;
      }
      if (shakePower < -shakePowerMax) {
        shakeUP=true;
        shakeAmount++;
      }
      if (shakeUP==true) {
        shakePower += shakePowerAdd;
      }
      if (shakeUP==false) {
        shakePower -= shakePowerAdd;
      }
      if (shakeAmount>=totalShakes) {
        shake=false;
      }
      if (shake==false && maxShake<maxShakeSet) {
        shakeAmount=0;
        shakePower=0;
        maxShake = 0;
        shakeLR = true;
        shakeUP = false;
        xshake=0;
      }
    }
  }
  if (shaketimer >= shaketimerTPT)
  {
    shaketimer =0;
  }
}
