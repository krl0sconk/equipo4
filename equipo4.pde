int level = 0;
int estado = 0;

HitboxPlayer hitboxPersonaje;

void setup() {
  size(1280, 720, P3D);
  setupmenu();
  setupTerrain();
  setupPlatform();
  setupWater();
  setupPlayer();
  hitboxPersonaje = new HitboxPlayer(personajeX, height / 2, 50, 100, -25, -50); // depende el modelo
  textureMode(NORMAL);
  noSmooth();
  level = 1;
}

void draw() {
 if (estado == 0) {
    mostrarMenu();
  } else if (estado == 1) {
    directionalLight(255, 255, 255, 1, 1, -1);
    switch (level) {
  case 0:
    drawWater();
    break;
  default:
    drawTerrain(level);
    break;
  }
    moverPersonaje();
  drawPlatform(level);
  drawPlayer(1);
  } else if (estado == 2) {
    Tutorial();
  } else if (estado == 3){
    Configuracion();
  }
  
  hitboxPersonaje.actualizar(personajeX, height / 2);
  
}

void mousePressed() {
  if (estado == 0) {
    // Botón Jugar
    if (mouseX > width/2 - 85 && mouseX < width/2 + 80 &&
      mouseY> 480 && mouseY < 530) {
      estado = 1;
    }
    if (mouseX > width/2 - 10 && mouseX < width/2 + 10 &&
      mouseY> 532 && mouseY < 550) {
      estado = 2;
    }
    if(mouseX > width-60 && mouseX < width && mouseY <60){
        estado = 3;
    
    }
    
  } else if (estado == 2){
  if (mouseX < 70 && mouseY < 70){
      estado = 0;
    }
  }else if (estado == 3){
    if (mouseX < 70 && mouseY <70){
      estado = 0;
    }
    
  }
}

void mouseDragged(){
  if (estado == 3){
    if (mouseX > width/2 - 160 && mouseX < width/2 +160 && mouseY > height/2 -95  && mouseY < height/2 -55){
      BallX = mouseX;
    }
  }
}
