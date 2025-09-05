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

  offsetY += 0.03;
  vertex(-75, -400, 0 , 0 - offsetY);       // Vértice superior izquierdo
  vertex(75, -400, 6, 0 - offsetY);         // Vértice superior derecho
  vertex(75, 700, 6 , 6 - offsetY);         // Vértice inferior derecho
  vertex(-75, 700, 0 , 6 - offsetY);         // Vértice inferior izquierdo

  endShape();
  popMatrix();
}
