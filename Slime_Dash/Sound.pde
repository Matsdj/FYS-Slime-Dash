
import ddf.minim.*;
Minim minim;
AudioPlayer Rec;

void soundSetup() {
  sound = new StartMuziek(this);
}

StartMuziek sound;
class StartMuziek { 
float volume = -5;



  StartMuziek(PApplet boop) {
    minim = new Minim(boop);
    Rec = minim.loadFile("sounds/main menu.mp3");
Rec.setGain(volume);
  }

  void draw() {
    if (room == "mainM") {
      Rec.play();
    } else 
    Rec.pause();
  }
}
