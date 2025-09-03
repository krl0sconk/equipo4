//Variables del terreno
int cols,rows;
int scale = 20;
int w=1200,h=1200;
float[][] terrain;
float movement = 0;
PImage grasstxt;

void setup() {
  size(600, 600, P3D);
  cols = w /scale;
  rows = h/ scale;
  terrain = new float[cols][rows];
  grasstxt = loadImage("grass.jpg");
  textureMode(NORMAL);
  noSmooth();
}

void draw() {
 
  background(149,194,255);
  directionalLight(255, 255, 255, 1, 1, -1);
  drawTerrain();
  drawPlatform();
}


void drawTerrain(){
  movement -= 0.07; 
  float yoffset = movement;
  
  // GENERACIÓN DEL TERRENO  

  for(int y = 0; y < rows; y++){
    float xoffset = 0;
    for(int x = 0; x < cols; x++){
      float mappedNoise = map(noise(xoffset, yoffset), 0, 1, -5, 5);
      terrain[x][y] = int(mappedNoise) * scale;
      xoffset += 0.3;
    }
    yoffset += 0.2;
  }
  
  pushMatrix(); 
  
  translate(width/2, height/2);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  translate(0, -movement % scale, 0);
  noStroke();
  
  // Bucle para dibujar COLUMNAS de cubos
  for(int y = 0; y < rows; y++){
    for(int x = 0; x < cols; x++){
      
      float currentHeight = terrain[x][y];
      int baseHeight = -8 * scale; 
      
      stroke(0);
      fill(0,150,100);

      for (float z = baseHeight; z <= currentHeight; z += scale) {
        pushMatrix();
        translate(x * scale, y * scale, z);
        texture(grasstxt);
        box(scale);
        popMatrix();
      }
    }
  }
  
  popMatrix();
}
void drawPlatform(){
 
  pushMatrix();
  translate(width/2, height/2);
  rotateX(PI/3);
  translate(0, 0, 80); 
  rectMode(CENTER); 
  fill(255); 
  noStroke(); 
  rect(0, 200, 150, 800);    
  popMatrix();
}
