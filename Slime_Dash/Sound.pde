//Laurens
import processing.sound.*;
SoundFile Hoofdmenu;
SoundFile GameSlow;
SoundFile GameMid;
SoundFile SpeedUp;
SoundFile Ding;
SoundFile Dede;
//GameFast = new SoundFile(this, "sounds/");

void soundSetup() {
  float volume = 1;
  Hoofdmenu = new SoundFile(this, "sounds/main menu.wav");
  GameSlow = new SoundFile(this, "sounds/slowMuzi.wav");
  GameMid = new SoundFile(this, "sounds/midMuzi.wav");
  //GameFast = new SoundFile(this,"sounds/");
  SpeedUp = new SoundFile(this, "sounds/speedUp.wav");
  Ding = new SoundFile(this, "sounds/ding.wav");
  Dede = new SoundFile(this, "sounds/dede.wav");
  Hoofdmenu.amp(volume);
}
void soundUpdate() {
  if (Hoofdmenu.isPlaying() == false) {
    if (room == "mainM") {
      Hoofdmenu.play();
    }
  } else if (room == "game") {
    Hoofdmenu.pause();
  }
  if (GameSlow.isPlaying() == false) {
    if (room =="game"&&time<=2500) {
      GameSlow.play();
    }
  }
  if (GameMid.isPlaying() == false && SpeedUp.isPlaying() == false) {
    if (room =="game" && time>=2500) {
      GameSlow.stop();
      SpeedUp.play();
    }
    if (room =="game" && time>=2530) {
      SpeedUp.stop();
      GameMid.play();
      GameMid.loop();
    }
  }
  if (interfaces.death ==true) {
    Hoofdmenu.stop();
    GameSlow.stop();
    GameMid.stop();
    SpeedUp.stop();
    if (Dede.isPlaying()==false) {
      Dede.play();
    }
  }
  if (inputs.hasValue(DOWN)==true && main.blink==main.c1 && room=="mainM") {
    Ding.play();
  }
  if (inputs.hasValue(UP)==true && main.blink==main.c2 && room=="mainM") {
    Ding.play();
  }
}
