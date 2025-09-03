void setup() {
  size(600, 600, P3D);
  watertxt = loadImage("water.png");
  textureMode(NORMAL);
  noSmooth();
}

void draw() {
 
  background(149,194,255);
  directionalLight(255, 255, 255, 1, 1, -1);
  drawTerrain();
  drawPlatform();
}
