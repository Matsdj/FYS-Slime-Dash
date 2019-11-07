
import ddf.minim.*;
Minim minim;
AudioPlayer Rec;

void soundSetup() {
  sound = new StartMuziek(this);
}

StartMuziek sound;
class StartMuziek { 




  StartMuziek(PApplet boop) {
    minim = new Minim(boop);
    Rec = minim.loadFile("main menu.mp3");
  }

  void draw() {
    if (room == "mainM") {
      Rec.play();
    } else 
    Rec.pause();
  }
}
