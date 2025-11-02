PImage watertxt;
PImage waterBgTxt; // Separate variable for resized background

void setupWater() {
  watertxt = loadImage("water.png");
  // Create resized copy of sky background for water level
  waterBgTxt = loadImage("sky.png");
  waterBgTxt.resize(width, height); // Resize to match screen size
}

void drawWater() {
  background(waterBgTxt);
  movement -= 0.6 * deltaTime;
  float yoffset = movement;

  for (int y = 0; y < rows; y++) {
    float xoffset = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoffset, yoffset), 0, 1, -70, 70);
      xoffset += 0.05;
    }
    yoffset += 0.1;
  }

  noStroke();
  noLights();
  fill(0, 255, 100);

  pushMatrix();
  translate(width/2, height/2);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    texture(watertxt);
    for (int x = 0; x < cols; x++) {
      vertex(x*scale, y*scale, terrain[x][y], x % 2, y % 2);
      vertex(x*scale, (y+1)*scale, terrain[x][y+1], x % 2, (y+1) % 2);
    }
    endShape();
  }
  popMatrix();
}
