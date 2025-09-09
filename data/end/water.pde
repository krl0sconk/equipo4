  //Variables del agua
  PImage watertxt;


void drawWater(){
  movement -= 0.01;
  float yoffset = movement;
  //Bucle para generar los valores Z con el perlin noise y un offset 
  for(int y = 0; y < rows; y++){
    float xoffset = 0;
    for(int x = 0; x < cols; x++){
      terrain[x][y] = map(noise(xoffset,yoffset),0,1,-70,70);
      xoffset += 0.05;
    }
    yoffset += 0.1;
  }
  //Bucle para crear cada vertice (triangle strip)
  noStroke();
  noLights();
  fill(0,255,100);
  
  pushMatrix();
  translate(width/2,height/2);
  rotateX(PI/3);
  translate(-w/2,-h/2);
  for(int y = 0; y < rows-1; y++){
    beginShape(TRIANGLE_STRIP);
    texture(watertxt);
    for(int x = 0; x < cols; x++){
    vertex(x*scale, y*scale, terrain[x][y], x % 2, y % 2);
    vertex(x*scale, (y+1)*scale, terrain[x][y+1], x % 2, (y+1) % 2);
    }
    endShape();
  }
  popMatrix();
}
