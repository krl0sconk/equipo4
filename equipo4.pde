PImage skytxt;
int level = 0;

void setup() {
  grasstxt = loadImage("grass.png");
  size(1280, 720, P3D);
  watertxt = loadImage("water.png");
  plankstxt = loadImage("planks.png");
  skytxt = loadImage("sky.png");
  textureMode(NORMAL);
  noSmooth();
  
  level = 1;
}

void draw() {
 
  background(skytxt);
  directionalLight(255, 255, 255, 1, 1, -1);
  switch (level){
    case 0:
     drawWater();
     break;
    case 1:
     drawTerrain();
     break;
  }
  drawPlatform();
}
