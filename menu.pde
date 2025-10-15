PImage fondo[] = new PImage[4];
PFont font;
PImage title, setw,ret, chr,tabla;
int BallX ;
void mostrarMenu() {
  //Texto de menu principal
  background(fondo[level]);
  //Titulo
  title.resize(500, 500);
  imageMode(CENTER);
  image(title, width/2, height/2 - 50);
  //Boton Configuraciones
  setw.resize(60, 60);
  image(setw, width-30, 30);

  // Botón Jugar
  textSize(48);
  textAlign(CENTER, CENTER);
  fill(255, 255, 255);
  text("Jugar", width/2, 500);
  //Boton Tutorial
  textSize(22);
  fill(255, 0, 0);
  text("Tutorial", width/2, 546);
}



void Tutorial(){
   background(0,0,255);
   ret.resize(70,70);
  image(ret, 35,35);
  rectMode(CENTER);
  fill(0,200,0);
  rect(width/2,height-20,width,50);
  chr.resize(100,140);
  image(chr, width-40, height-70);
  tabla.resize(350,250);
  image(tabla, width/2, height/2);
  textAlign(CENTER, CENTER);
  textSize(30);
  
  
  fill(0);
  text("Es hora de que ", width/2+ 8, height/2-80 );
  text("aprendas a jugar ", width/2+ 8, height/2-32 );
  text("este espectacular ", width/2+ 8, height/2 +16);
  text("juego. ", width/2+ 8, height/2+54 );
}

void Configuracion(){
  background(0);
  image(fondo[level],width/2,height/2);
  ret.resize(70,70);
  image(ret, 35,35);
  rectMode(CENTER);
  fill(100);
  rect(width/2, height/2 -75, 320,40);
  fill(150);
  rect(BallX, height/2-75, 20,40);
  
}

void setupmenu(){
  BallX = width/2 -160;
  title = loadImage("title.png");
  setw = loadImage("setwh.png");
  ret = loadImage("return.png");
  chr = loadImage("stve.png");
  tabla = loadImage("esc_md.jpg");
  font = createFont("minecraft_font.ttf", 16);
  textFont(font, 16);  
  for  (int i = 1; i <= 3; i++) {
    fondo [i] = loadImage("image"+i+".png");
    fondo[i].resize(1280, 720);
  }
}
