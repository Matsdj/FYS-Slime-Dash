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
SoundFile damage;

float slow = 2500, mid = 6000;
boolean[] march = new boolean[4];
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
  damage = new SoundFile(this,"sounds/damage.mp3");
  Hoofdmenu.amp(volume);
}
void soundUpdate() {
  //marching geluiden worden in de tutorial uitgezet
  if (room =="game2") {
    march[0]=false;
    march[1]=false;
    march[2]=false;
    march[3]=false;
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
  if (inputs.hasValue(DOWN)==true && main.highlight==main.select1 && room=="mainM") {
    Ding.play();
  }
  if (inputs.hasValue(UP)==true && main.highlight==main.select2 && room=="mainM") {
    Ding.play();
  }
  if (inputs.hasValue(DOWN)==true && dif.highlight==dif.select1 && room=="difficulty") {
    Ding.play();
  }
  if (inputs.hasValue(UP)==true && dif.highlight==dif.select2 && room=="difficulty") {
    Ding.play();
  }
  if (room =="game") {
    //march geluid bij startup en wanneer de horde groter wordt
    if (time ==0 &&hordeMarch.isPlaying() == false&&march[0] ==true) {
      hordeMarch.rate(2);
      hordeMarch.play();
      march[0] =false;
    } else if (time ==slow/2 &&hordeMarch.isPlaying() == false&&march[1] ==true) {
      hordeMarch.rate(1.8);
      hordeMarch.play();
      march[1] =false;
    } else if (time ==slow &&hordeMarch.isPlaying() == false&&march[2] ==true) {
      hordeMarch.rate(1.5);
      hordeMarch.play();
      march[2] =false;
    } else if (time ==mid &&hordeMarch.isPlaying() == false&&march[3] ==true) {
      hordeMarch.rate(1);
      hordeMarch.play();
      march[3] =false;
    }
  }
}
