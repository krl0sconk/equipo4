PImage plankstxt;
float offsetY = 0;
float offsetSpeed = 3.0; // Unidades por segundo
PImage purpur_blocktxt;

void setupPlatform() {
  plankstxt = loadImage("planks.png");
  purpur_blocktxt = loadImage("purpur-block.jpg");
}

void drawPlatform(int level) {
  pushMatrix();
  translate(width / 2, height / 2);
  rotateX(PI / 3);
  translate(0, -150, 80);
  beginShape();

  switch (level) {
    case 1:
      texture(plankstxt);
      break;
    case 3:
      texture(purpur_blocktxt);
      break;
    default:
      texture(plankstxt);
  }
  textureWrap(REPEAT);

  offsetY += offsetSpeed * deltaTime;
  vertex(-120, -400, 0, 0 - offsetY);
  vertex(120, -400, 6, 0 - offsetY);
  vertex(120, 900, 6, 6 - offsetY);
  vertex(-120, 900, 0, 6 - offsetY);

  endShape();
  popMatrix();
}
