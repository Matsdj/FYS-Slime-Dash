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
float slow = 2500, mid = 6000;


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
  Hoofdmenu.amp(volume);
}
void soundUpdate() {
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
  } else if (room == "game") {
    Hoofdmenu.pause();
  }
  //muziek wanneer time onder 'slow' zit
  if (GameSlow.isPlaying() == false) {
    if (room =="game"&&time<=slow) {
      GameSlow.play();
    }
  }
  //muziek wanneer time onder 'mid' en boven 'slow' zit
  if (GameMid.isPlaying() == false) {
    if (room =="game" && time>=slow && time<=mid) {
      GameSlow.stop();
      GameMid.play();
      GameMid.loop();
    }
  }
  //muziek wanneer time boven 'mid' zit
  if (GameFast.isPlaying() == false) {
    if (room =="game" && time>=mid) {
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
}
