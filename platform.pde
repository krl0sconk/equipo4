// Variables de la plataforma
PImage plankstxt;
float offsetY = 0;
PImage purpur_blocktxt;

void setupPlatform(){
    plankstxt = loadImage("planks.png");
    purpur_blocktxt = loadImage("purpur-block.jpg");
}
void drawPlatform(int level) {
  pushMatrix();
  translate(width / 2, height / 2);
  rotateX(PI / 3);
  translate(0, -150, 80);
  beginShape();  
  switch (level){
    case 1:
     texture(plankstxt);
     break;
    case 2:
     texture(purpur_blocktxt);
     break;
    default:
     texture(plankstxt);
  }
  textureWrap(REPEAT); 

  offsetY += 0.03;
  vertex(-120, -400, 0 , 0 - offsetY);       // Vértice superior izquierdo
  vertex(120, -400, 6, 0 - offsetY);         // Vértice superior derecho
  vertex(120, 700, 6 , 6 - offsetY);         // Vértice inferior derecho
  vertex(-120, 700, 0 , 6 - offsetY);         // Vértice inferior izquierdo

  endShape();
  popMatrix();
}
