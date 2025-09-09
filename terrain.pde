//Variables del terreno
int scale = 30;
int w=2400,h=1200;
int cols = w /scale;
int rows = h/ scale;
float[][] terrain  = new float[cols][rows];
float movement = 0;
PImage grasstxt;
PImage endskytxt;
PImage skytxt;
PImage endtxt;
PImage terraintxt;

void setupTerrain(){
    grasstxt = loadImage("grass.png");
    skytxt = loadImage("sky.png");
    endskytxt = loadImage("end.png");
    endtxt = loadImage("end-stone.jpg");
}

void drawTerrain(int level) {
  switch (level){
    case 1:
     background(skytxt);
     terraintxt = grasstxt;
     break;
    case 2:
     background(endskytxt);
     terraintxt = endtxt;
     break;
  }
  movement -= 0.05; 
  float yoffset = movement;

  // GENERACIÓN DEL TERRENO 
  for (int y = 0; y < rows; y++) {
    float xoffset = 0;
    for (int x = 0; x < cols; x++) {
      float mappedNoise = map(noise(xoffset, yoffset), 0, 1, -5, 5);
      terrain[x][y] = int(mappedNoise) * scale; 
      xoffset += 0.05;
    }
    yoffset += 0.05;
  }

  pushMatrix();

  translate(width / 2, height / 2); 
  rotateX(PI / 3); 
  translate(-w / 2, -h / 2); 
  translate(0, -movement % scale, -25); 
  noStroke(); 

  // DIBUJADO DE CUBOS 
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      float currentHeight = terrain[x][y];
      
      pushMatrix();
      translate(x * scale, y * scale, currentHeight); 
      drawTexturedCube(scale, terraintxt); 
      popMatrix();
    }
  }

  popMatrix();
}

// FUNCIÓN PARA DIBUJAR UN CUBO TEXTURIZADO 
void drawTexturedCube(float s, PImage txt) {
  float hs = s / 2; 
  // Cara frontal
  beginShape(QUADS);
  texture(txt);
  vertex(-hs, -hs, hs, 0, 0);
  vertex(hs, -hs, hs, 1, 0);
  vertex(hs, hs, hs, 1, 1);
  vertex(-hs, hs, hs, 0, 1);
  endShape();

  // Cara trasera
  beginShape(QUADS);
  texture(txt);
  vertex(hs, -hs, -hs, 0, 0);
  vertex(-hs, -hs, -hs, 1, 0);
  vertex(-hs, hs, -hs, 1, 1);
  vertex(hs, hs, -hs, 0, 1);
  endShape();

  // Cara izquierda
  beginShape(QUADS);
  texture(txt);
  vertex(-hs, -hs, -hs, 0, 0);
  vertex(-hs, -hs, hs, 1, 0);
  vertex(-hs, hs, hs, 1, 1);
  vertex(-hs, hs, -hs, 0, 1);
  endShape();
  
  // Cara derecha
  beginShape(QUADS);
  texture(txt);
  vertex(hs, -hs, hs, 0, 0);
  vertex(hs, -hs, -hs, 1, 0);
  vertex(hs, hs, -hs, 1, 1);
  vertex(hs, hs, hs, 0, 1);
  endShape();

  // Cara superior
  beginShape(QUADS);
  texture(txt);
  vertex(-hs, -hs, -hs, 0, 0);
  vertex(hs, -hs, -hs, 1, 0);
  vertex(hs, -hs, hs, 1, 1);
  vertex(-hs, -hs, hs, 0, 1);
  endShape();

  // Cara inferior
  beginShape(QUADS);
  texture(txt);
  vertex(-hs, hs, hs, 0, 0);
  vertex(hs, hs, hs, 1, 0);
  vertex(hs, hs, -hs, 1, 1);
  vertex(-hs, hs, -hs, 0, 1);
  endShape();
}
