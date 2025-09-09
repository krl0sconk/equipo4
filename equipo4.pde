int level = 0;

void setup() {
  size(1280, 720, P3D);
  setupTerrain();
  setupPlatform();
  setupWater();
  textureMode(NORMAL);
  noSmooth();
  level = 2;
}

void draw() {

  directionalLight(255, 255, 255, 1, 1, 0);

  switch (level) {
  case 0:
    drawWater();
    break;
  default:
    drawTerrain(level);
    break;
  }
  drawPlatform(level);
}
