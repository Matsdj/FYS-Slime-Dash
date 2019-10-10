//collin
class Spike {
  float x, y, size;
  color c = color(255);
  Spike(float ix, float iy) {
    x = ix;
    y = iy;
    size = globalScale;
  }
  void draw() {
    fill(c);
    rect(x, y, size, size);
  }
}
//Lijst met blocks
ArrayList<Spike> spikes = new ArrayList();
boolean spikeCollision(float x, float y, float size) {
  boolean Collision = false;
  for (int spikeNumber = 0; spikeNumber < spikes.size(); spikeNumber++) {
    if (blocks.get(spikeNumber).x < x+size && spikes.get(spikeNumber).x+size > x && spikes.get(spikeNumber).y < y+size && spikes.get(spikeNumber).y+size > y) {
      Collision = true;
    }
  }
  return Collision;
}
//block draw
void spikeUpdate() {
  //loopt door de lijst en tekent elke block
  for (int n = 0; n<spikes.size(); n++) {
    Spike spike = spikes.get(n);
  }
}
//block draw
void spikeDraw() {
  //loopt door de lijst en tekent elke block
  for (int n = 0; n<spikes.size(); n++) {
    Spike spike = spikes.get(n);
    spike.draw();
    fill(255, 0, 0);
    rect(spike.x, spike.y, globalScale, globalScale);
  }
}
