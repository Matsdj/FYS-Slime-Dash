//Laurens
import ddf.minim.*;
Minim minim;
AudioPlayer Hoofdmenu;
AudioPlayer GameSlow;
AudioPlayer GameMid;
AudioPlayer GameFast;

void soundSetup() {
  sound = new Muziek(this);
}

Muziek sound;
class Muziek { 
  float volume = -5;



  Muziek(PApplet boop) {
    minim = new Minim(boop);
    Hoofdmenu = minim.loadFile("sounds/main menu.mp3");
    Hoofdmenu.setGain(volume);
    Hoofdmenu.loop();

    // GameSlow = minim.loadFile("");
    // GameMid = minim.loadFile("");
    // GameFast = minim.loadFile("");
  }

  void draw() {
    if (room == "mainM") {
      Hoofdmenu.play();
    } else 
    Hoofdmenu.pause();

    // if (room =="game"&&time<=3000){
    //   GameSlow.play();
    //}
        // if (room =="game"&&time>=3000){
    //   GameMid.play();
    //}
  }
}
