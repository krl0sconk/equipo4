int level = 0;

void setup() {
  size(1280, 720, P3D);
  setupTerrain();
  setupPlatform();
  setupWater();
  setupPlayer();
  textureMode(NORMAL);
  noSmooth();
  level = 2;
}

void draw() {

  directionalLight(255, 255, 255, 1, 1, -1);
  switch (level) {
  case 0:
    drawWater();
    break;
  default:
    drawTerrain(level);
    break;
  }
  moverPersonaje();
  drawPlatform(level);
  drawPlayer(1);
}
