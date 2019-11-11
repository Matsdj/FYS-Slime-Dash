//Laurens
import ddf.minim.*;
Minim minim;
AudioPlayer Hoofdmenu;

void soundSetup() {
  sound = new StartMuziek(this);
}

StartMuziek sound;
class StartMuziek { 
  float volume = -5;



  StartMuziek(PApplet boop) {
    minim = new Minim(boop);
    Hoofdmenu = minim.loadFile("sounds/main menu.mp3");
    Hoofdmenu.setGain(volume);
    Hoofdmenu.loop();
  }

  void draw() {
    if (room == "mainM") {
      Hoofdmenu.play();
    } else 
    Hoofdmenu.pause();
  }
}
