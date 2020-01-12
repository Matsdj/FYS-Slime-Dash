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
SoundFile meleeDeath;
SoundFile meleeDmg;
SoundFile Electric;
SoundFile doorDown;
SoundFile Thud;
SoundFile wallArrow;
SoundFile arrowHit;
SoundFile arrowRelease;
SoundFile spikeDmg;
SoundFile miniMarch;
SoundFile slimeBurn;
final float TIME_SLOW = 2500, TIME_MID = 6000;
boolean[] march = new boolean[4];
void soundSetup() {
  //volume
  float volume = 1;
  //hier worden alle bestanden gelinkt aan de soundplayers
  SlimeJump = new SoundFile(this, "sounds/slimeJump.wav");
  Hoofdmenu = new SoundFile(this, "sounds/mainMenu.aiff");
  GameSlow = new SoundFile(this, "sounds/slowMuzi.aiff");
  GameMid = new SoundFile(this, "sounds/midMuzi.aiff");
  GameFast = new SoundFile(this, "sounds/FastMuzi.aiff");
  SpeedUp = new SoundFile(this, "sounds/speedUp.wav");
  Ding = new SoundFile(this, "sounds/ding.wav");
  Dede = new SoundFile(this, "sounds/dede.aiff");
  DashSlime = new SoundFile(this, "sounds/DashSlime.wav");
  hordeMarch = new SoundFile(this, "sounds/horde march.wav");
  damage = new SoundFile(this, "sounds/damage.mp3");
  meleeDeath = new SoundFile(this, "sounds/meleedeath.wav");
  meleeDmg = new SoundFile(this, "sounds/meleedamage.wav");
  Electric = new SoundFile(this, "sounds/electric.wav");
  doorDown = new SoundFile(this, "sounds/doorDown.mp3");
  Thud = new SoundFile(this, "sounds/Thud.mp3");
  wallArrow = new SoundFile(this, "sounds/wallArrow.wav");
  arrowHit = new SoundFile(this, "sounds/arrowhit.wav");
  arrowRelease = new SoundFile(this, "sounds/arrowRelease.mp3");
  spikeDmg = new SoundFile(this, "sounds/spikeDmg.mp3");
  miniMarch = new SoundFile(this, "sounds/miniMarch.mp3");
  slimeBurn = new SoundFile(this,"sounds/slimeBurn.mp3");
  Hoofdmenu.amp(volume);
  damage.amp(.5);
  march[0]=true;
  march[1]=true;
  march[2]=true;
  march[3]=true;
  miniMarch.amp(.6);
  miniMarch.rate(.7);
   slimeBurn.amp(.5);
}
void soundUpdate() {
  if (room == "game" && miniMarch.isPlaying()==false) {
    miniMarch.play();
  }
  if (speedModifier !=1) {
    GameSlow.rate(constrain(speedModifier*3, 0.5, 1));
    GameMid.rate(constrain(speedModifier*3, 0.5, 1));
    GameFast.rate(constrain(speedModifier*3, 0.5, 1));
  }
  //marching geluiden worden in de tutorial uitgezet
  if (room =="game2") {
    march[0]=false;
    march[1]=false;
    march[2]=false;
    march[3]=false;
  } else {
    march[0]=true;
    march[1]=true;
    march[2]=true;
    march[3]=true;
  }
  //hoofdmenu muziek
  if (Hoofdmenu.isPlaying() == false) {
    if (room == "mainM" || room == "start" || room == "login" || room == "password") {
      Hoofdmenu.play();
      GameSlow.stop();
      GameMid.stop();
      GameFast.stop();
      SpeedUp.stop();
      Dede.stop();
      miniMarch.stop();
    }
  } else if ((room =="game"||room == "game2")) {
    Hoofdmenu.pause();
  }
  //muziek wanneer time onder 'TIME_SLOW' zit
  if (GameSlow.isPlaying() == false) {
    if ((room =="game"||room == "game2")&&time<=TIME_SLOW) {
      GameSlow.play();
    }
  }
  //muziek wanneer time onder 'TIME_MID' en boven 'TIME_SLOW' zit
  if (GameMid.isPlaying() == false) {
    if ((room =="game"||room == "game2") && time>=TIME_SLOW && time<=TIME_MID) {
      GameSlow.stop();
      GameMid.play();
      GameMid.loop();
      miniMarch.rate(1);
    }
  }
  //muziek wanneer time boven 'TIME_MID' zit
  if (GameFast.isPlaying() == false) {
    if ((room =="game"||room == "game2") && time>=TIME_MID) {
      GameMid.stop();
      SpeedUp.stop();
      GameFast.play();
      GameFast.loop();
      miniMarch.rate(1.2);
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
  if (room =="game") {
    //march geluid bij startup en wanneer de horde groter wordt
    if (time ==0 &&hordeMarch.isPlaying() == false&&march[0] ==true) {
      hordeMarch.rate(2);
      hordeMarch.play();
      march[0] =false;
    }  
    if (time ==TIME_SLOW/2 &&hordeMarch.isPlaying() == false&&march[1] ==true) {
      hordeMarch.rate(1.8);
      hordeMarch.play();
      march[1] =false;
    }  
    if (time ==TIME_SLOW &&hordeMarch.isPlaying() == false&&march[2] ==true) {
      hordeMarch.rate(1.5);
      hordeMarch.play();
      march[2] =false;
    }  
    if (time ==TIME_MID &&hordeMarch.isPlaying() == false&&march[3] ==true) {
      hordeMarch.rate(1);
      hordeMarch.play();
      march[3] =false;
    }
  }
  if (room == "pause" || room == "pause2") {
    if (miniMarch.isPlaying() ==true) {
      miniMarch.pause();
    }
  }
}
