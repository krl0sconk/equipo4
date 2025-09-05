//Variables del terreno
int scale = 25;
int w=2400,h=1200;
int cols = w /scale;
int rows = h/ scale;
float[][] terrain  = new float[cols][rows];
float movement = 0;
PImage grasstxt;

void drawTerrain() {
  movement -= 0.03; // Controla la velocidad de desplazamiento del terreno
  float yoffset = movement;

  // GENERACIÓN DEL TERRENO (solo la altura de la superficie)
  for (int y = 0; y < rows; y++) {
    float xoffset = 0;
    for (int x = 0; x < cols; x++) {
      float mappedNoise = map(noise(xoffset, yoffset), 0, 1, -5, 5);
      terrain[x][y] = int(mappedNoise) * scale; // Altura del cubo superior
      xoffset += 0.05;
    }
    yoffset += 0.05;
  }

  pushMatrix();

  translate(width / 2, height / 2); // Centra el terreno en la pantalla
  rotateX(PI / 3); // Rota para una vista isométrica
  translate(-w / 2, -h / 2); // Vuelve a traducir para que el origen del terreno sea la esquina superior izquierda
  translate(0, -movement % scale, 0); // Desplazamiento para el efecto de movimiento continuo

  noStroke(); 

  // DIBUJADO DE CUBOS (solo la capa superior)
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      float currentHeight = terrain[x][y];
      
      pushMatrix();
      translate(x * scale, y * scale, currentHeight); // Posiciona el cubo en la altura generada
      
      if (grasstxt != null) {
        drawTexturedCube(scale, grasstxt); // Dibuja el cubo texturizado si hay textura
      } else {
        fill(0, 200, 0); // Si no hay textura, usa un color verde
        box(scale); // Dibuja un cubo simple
      }
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
