int level = 0;

void setup() {
  size(1280, 720, P3D);
  setupTerrain();
  setupPlatform();
  setupWater();
  setupPlayer();
  setupDiamonds();    
  setupObstacles();  
  setupSpawner();
  textureMode(NORMAL);
  noSmooth();
  level = 0;
}

void draw() {

  switch (level) {
  case 0:
    drawWater();
    directionalLight(255, 255, 255, 1, 1, -1);
    break;
  default:
    directionalLight(255, 255, 255, 1, 1, -1);
    drawTerrain(level);
    break;
  }
  moverPersonaje();
  drawPlatform(level);
  updateSpawner();   
  updateDiamonds();   
  updateObstacles();  
  drawDiamonds();     
  drawObstacles();
  drawPlayer(1);
}
