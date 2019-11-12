//Laurens
import processing.sound.*;
SoundFile Hoofdmenu;
//GameSlow = new SoundFile(this, "sounds/"),
//GameMid = new SoundFile(this, "sounds/"),
//GameFast = new SoundFile(this, "sounds/");

void soundSetup() {
  float volume = 1;
  Hoofdmenu = new SoundFile(this, "sounds/main menu.wav");
  Hoofdmenu.amp(volume);
}
void soundUpdate() {
  if (Hoofdmenu.isPlaying() == false) {
    if (room == "mainM") {
      Hoofdmenu.play();
    }
  } else {
    Hoofdmenu.pause();
  }

  // if (room =="game"&&time<=3000){
  //   GameSlow.play();
  //}
  // if (room =="game"&&time>=3000){
  //   GameMid.play();
  //}
}
