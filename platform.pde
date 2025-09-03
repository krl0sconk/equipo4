// Variables de la plataforma
PImage plankstxt;
float offsetY = 0;

void drawPlatform() {
  pushMatrix();
  translate(width / 2, height / 2);
  rotateX(PI / 3);
  translate(0, -150, 80);
  beginShape();
  texture(plankstxt);
  textureWrap(REPEAT); 
 
  offsetY += 0.1;
  vertex(-75, -300, 0 , 0 - offsetY);       // Vértice superior izquierdo
  vertex(75, -300, 6, 0 - offsetY);         // Vértice superior derecho
  vertex(75, 500, 6 , 6 - offsetY);         // Vértice inferior derecho
  vertex(-75, 500, 0 , 6 - offsetY);         // Vértice inferior izquierdo
  
  endShape();
  popMatrix();
}
