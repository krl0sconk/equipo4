  //Variables del terreno
  int scale = 20;
  int w=1200,h=1200;
  int cols = w /scale;
  int rows = h/ scale;
  float[][] terrain = new float[cols][rows];;
  float movement = 0;


void drawTerrain(){
  movement -= 0.01;
  float yoffset = movement;
  //Bucle para generar los valores Z con el perlin noise y un offset 
  for(int y = 0; y < rows; y++){
    float xoffset = 0;
    for(int x = 0; x < cols; x++){
      terrain[x][y] = map(noise(xoffset,yoffset),0,1,-70,70);
      xoffset += 0.3;
    }
    yoffset += 0.2;
  }
  //Bucle para crear cada vertice (triangle strip)
  stroke(0,200,100);
  fill(0,255,100);
  translate(width/2,height/2);
  rotateX(PI/3);
  translate(-w/2,-h/2);
  for(int y = 0; y < rows-1; y++){
    beginShape(TRIANGLE_STRIP);
    for(int x = 0; x < cols; x++){
    vertex(x*scale, y*scale, terrain[x][y]);
    vertex(x*scale, (y+1)*scale, terrain[x][y+1]);
    }
    endShape();
  }
  rotateX(-PI/3);
}
