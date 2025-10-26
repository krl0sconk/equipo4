PImage fondo[] = new PImage[4];
PFont font;
PImage title, setw, ret, chr, tabla;
int BallX;

void setupmenu() {
  BallX = width/2 - 160;
  title = loadImage("title.png");
  title.resize(500, 500);
  setw = loadImage("setwh.png");
  setw.resize(60, 60);
  ret = loadImage("return.png");
  ret.resize(70, 70);
  chr = loadImage("stve.png");
  chr.resize(100, 140);
  tabla = loadImage("esc_md.jpg");
  tabla.resize(350, 250);
  font = createFont("minecraft_font.ttf", 16);
  textFont(font, 16);
  for (int i = 1; i <= 3; i++) {
    fondo[i] = loadImage("image"+i+".png");
    fondo[i].resize(width, height);
  }
}

void mostrarMenu() {
  background(fondo[level]);
  imageMode(CENTER);
  image(title, width/2, height/2 - 50);
  image(setw, width-30, 30);

  textSize(48);
  textAlign(CENTER, CENTER);
  fill(255, 255, 255);
  text("Jugar", width/2, 500);
  textSize(22);
  fill(255, 0, 0);
  text("Tutorial", width/2, 546);
}

void Tutorial() {
  background(0, 0, 255);
  image(ret, 35, 35);
  rectMode(CENTER);
  fill(0, 200, 0);
  rect(width/2, height-20, width, 50);
  image(chr, width-40, height-70);
  image(tabla, width/2, height/2);
  textAlign(CENTER, CENTER);
  textSize(30);

  fill(0);
  text("Es hora de que ", width/2 + 8, height/2-100);
  text("aprendas a jugar ", width/2 + 8, height/2-52);
  text("este espectacular ", width/2 + 8, height/2 - 4);
  text("juego. ", width/2 + 8, height/2+34);
  fill(0,0,200);
  textSize(24);
  
  
  text("click aqui para ", width/2 + 8, height/2 + 64);

  text("empezar el tutorial", width/2+8, height/2 + 94);
 
  
}

void Configuracion() {
  background(0);
  image(fondo[level], width/2, height/2);
  image(ret, 35, 35);
  rectMode(CENTER);
  fill(100);
  rect(width/2, height/2 - 75, 320, 40);
  fill(150);
  rect(BallX, height/2-75, 20, 40);
}
