PImage fondo[] = new PImage[4];
PFont font;
PImage lvlSB ;
PImage title, setw, ret, chr, tabla;
String nivelVolumen = "MEDIO";
String[] nivelesVolumen = {"BAJO", "MEDIO", "ALTO"};
float[] moderacionVolumen = {0.1 , 0.5, 0.8};
int indiceVolumen = 0 ;  // MEDIO
String volumen;

// Opciones de vidas
int[] opcionesVidas = {1, 3, 5};
int indiceVidas; // 3 vidas
int vidasIniciales = opcionesVidas[1];

int  btnVolumenY = 250, btnVolumenW = 280, btnVolumenH = 50;
int  btnVidasY = 330, btnVidasW = 280, btnVidasH = 50;
int  btnGuardarY = 410, btnGuardarW = 280, btnGuardarH = 50;


void setupmenu() {
 
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
  lvlSB = loadImage("LvlSelectorBackground.png");
  font = createFont("minecraft_font.ttf", 16);
  indiceVolumen = 1;
  indiceVidas = 1;
  textFont(font, 16);
  for (int i = 1; i <= 3; i++) {
    fondo[i] = loadImage("image"+i+".png");
    fondo[i].resize(width, height);
  }
}

void mostrarMenu() {
  
  reproducirMusica(musicaMenu);
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
  background(fondo[level]);
  textAlign(CENTER);
  fill(255);
  volumen =  nivelesVolumen[indiceVolumen];
  vidasIniciales = opcionesVidas[indiceVidas];
  // --- Botones ---
  image(ret, 35, 35);
  noStroke();
  fill(100);
  rect(width/2 - btnVolumenW/2, btnVolumenY, btnVolumenW, btnVolumenH, 10);
  rect(width/2 - btnVidasW/2, btnVidasY, btnVidasW, btnVidasH, 10);
  
  // Botón de guardar (verde)
  fill(0, 255, 100);
  rect(width/2 - btnGuardarW/2, btnGuardarY, btnGuardarW, btnGuardarH, 10);
  fill(255);
  text("GUARDAR Y VOLVER", width/2, btnGuardarY + 32);
  
  textSize(16);
  fill(200);
  text("Haz clic en los botones para cambiar las opciones", width/2, height - 50);
   textSize(40);
  text("Configuracion", width/2, 150);
  
  textSize(24);
  text("Volumen: " + volumen, width/2 , btnVolumenY + 30);
  text("Vidas iniciales: " + vidasIniciales, width/2 , btnVidasY + 30);
  
}

void Seleccion(){
  reproducirMusica(musicaSeleccionarNivel);
  background(lvlSB);
  image(ret, 35, 35);
  textSize(28);
  textAlign(CENTER);
  fill(255);
  text("Lvl 1.", 230, 505);
  if (prog >= 2){
    fill(255);
    text("Lvl 2.", 650, 505);
  } else {
    fill(255, 0, 0);
    text("???", 650, 505);
  }
  if (prog >=3){
    fill(255);
    text("Lvl 3.", 1055, 505);
  } else {
    fill(255, 0, 0);
    text("???", 1055, 505);
  }
}
