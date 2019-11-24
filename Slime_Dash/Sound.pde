//Laurens
import processing.sound.*;
//hier worden alle soundplayers aangemaakt
SoundFile Hoofdmenu;
SoundFile GameSlow;
SoundFile GameMid;
SoundFile GameFast;
SoundFile SpeedUp;
SoundFile Ding;
SoundFile Dede;
SoundFile SlimeJump;
SoundFile DashSlime;
SoundFile hordeMarch;
float slow = 2500, mid = 6000;
boolean march0 =true;
boolean march1 =true;
boolean march2 =true;
boolean march3 =true;

void soundSetup() {
  //volume
  float volume = 1;
  //hier worden alle bestanden gelinkt aan de soundplayers
  SlimeJump = new SoundFile(this, "sounds/slimeJump.wav");
  Hoofdmenu = new SoundFile(this, "sounds/mainMenu.wav");
  GameSlow = new SoundFile(this, "sounds/slowMuzi.wav");
  GameMid = new SoundFile(this, "sounds/midMuzi.wav");
  GameFast = new SoundFile(this, "sounds/FastMuzi.wav");
  SpeedUp = new SoundFile(this, "sounds/speedUp.wav");
  Ding = new SoundFile(this, "sounds/ding.wav");
  Dede = new SoundFile(this, "sounds/dede.wav");
  DashSlime = new SoundFile(this, "sounds/DashSlime.wav");
  hordeMarch = new SoundFile(this, "sounds/horde march.wav");
  Hoofdmenu.amp(volume);
}
void soundUpdate() {
  if (room =="game2") {
    march0=false;
    march1=false;
    march2=false;
    march3=false;
  }
  //hoofdmenu muziek
  if (Hoofdmenu.isPlaying() == false) {
    if (room == "mainM") {
      Hoofdmenu.play();
      GameSlow.stop();
      GameMid.stop();
      GameFast.stop();
      SpeedUp.stop();
      Dede.stop();
    }
  } else if ((room =="game"||room == "game2")) {
    Hoofdmenu.pause();
  }
  //muziek wanneer time onder 'slow' zit
  if (GameSlow.isPlaying() == false) {
    if ((room =="game"||room == "game2")&&time<=slow) {
      GameSlow.play();
    }
  }
  //muziek wanneer time onder 'mid' en boven 'slow' zit
  if (GameMid.isPlaying() == false) {
    if ((room =="game"||room == "game2") && time>=slow && time<=mid) {
      GameSlow.stop();
      GameMid.play();
      GameMid.loop();
    }
  }
  //muziek wanneer time boven 'mid' zit
  if (GameFast.isPlaying() == false) {
    if ((room =="game"||room == "game2") && time>=mid) {
      GameMid.stop();
      SpeedUp.stop();
      GameFast.play();
      GameFast.loop();
    }
  }
  //death muziek
  if (interfaces.death ==true) {
    Hoofdmenu.stop();
    GameSlow.stop();
    GameMid.stop();
    GameFast.stop();
    SpeedUp.stop();
    if (Dede.isPlaying()==false) {
      Dede.play();
    }
  }
  //interface selectie geluiden
  if (inputs.hasValue(DOWN)==true && main.blink==main.c1 && room=="mainM") {
    Ding.play();
  }
  if (inputs.hasValue(UP)==true && main.blink==main.c2 && room=="mainM") {
    Ding.play();
  }
  if (inputs.hasValue(DOWN)==true && dif.blink==dif.c1 && room=="difficulty") {
    Ding.play();
  }
  if (inputs.hasValue(UP)==true && dif.blink==dif.c2 && room=="difficulty") {
    Ding.play();
  }
  if (room =="game") {
    if (time ==0 &&hordeMarch.isPlaying() == false&&march0 ==true) {
      hordeMarch.rate(2);
      hordeMarch.play();
      march0 =false;
    } else if (time ==slow/2 &&hordeMarch.isPlaying() == false&&march1 ==true) {
      hordeMarch.rate(1.8);
      hordeMarch.play();
      march1 =false;
    } else if (time ==slow &&hordeMarch.isPlaying() == false&&march2 ==true) {
      hordeMarch.rate(1.5);
      hordeMarch.play();
      march2 =false;
    } else if (time ==mid &&hordeMarch.isPlaying() == false&&march3 ==true) {
      hordeMarch.rate(1);
      hordeMarch.play();
      march3 =false;
    }
  }
}
