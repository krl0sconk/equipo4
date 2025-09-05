PImage skytxt;
void setup() {
  size(1280, 720, P3D);
  watertxt = loadImage("water.png");
  plankstxt = loadImage("planks.png");
  skytxt = loadImage("sky.png");
  textureMode(NORMAL);
  noSmooth();
}

void draw() {
 
  background(skytxt);
  directionalLight(255, 255, 255, 1, 1, -1);
  drawTerrain();
  drawPlatform();
}
