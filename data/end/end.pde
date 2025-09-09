PImage endtxt;
int level = 0;

void setup() {
  grasstxt = loadImage("end_stone.png");
  size(1280, 720, P3D);
  watertxt = loadImage("water.png");
  purpur_blocktxt = loadImage("purpur_block.png");
  endtxt = loadImage("end.png");
  textureMode(NORMAL);
  noSmooth();
  
  level = 1;
}

void draw() {
 
  background(endtxt);
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
