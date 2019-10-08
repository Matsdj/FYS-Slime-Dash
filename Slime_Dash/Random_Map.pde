//Hier maak ik de tijdelijke objecten aan
//Deze objecten hebben dus alleen een uiterlijk ze doen nog niks
class TempBlock{
float x,y,hSize,vSize;
color c = color(255);
  void draw(){
    rect(x,y,hSize,vSize);
  }
}
class TempSpike{
float x,y,size;
color c = color(125);
}
//hier maak ik de lijsten aan
ArrayList tempBlocks = new ArrayList();
ArrayList tempSpikes = new ArrayList();

int afgelegdeAfstand = 0;
void mapSetup(){
}
void mapGenerate(){
  afgelegdeAfstand = floor(player.x/globalScale);
}
