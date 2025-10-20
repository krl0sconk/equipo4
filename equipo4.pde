int level = 0;
int estado = 0;
int score = 0;
HitboxPlayer hitboxPersonaje;
float HITBOX_W = 10.0;
float HITBOX_H = 10.0;
float HITBOX_OFFSET_X = -5.0; // Tus offsets de alineación
float HITBOX_OFFSET_Y = height/2;


void setup() {
  size(1280, 720, P3D);
  setupmenu();
  setupTerrain();
  setupPlatform();
  setupWater();
  setupPlayer();
  setupDiamonds();    
  setupObstacles();  
  setupSpawner();
  hitboxPersonaje = new HitboxPlayer(personajeX, height /2, HITBOX_W, HITBOX_H, HITBOX_OFFSET_X, HITBOX_OFFSET_Y);
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
  case 2:
    drawWater();
    drawPlatform(level);
    break;
  default:
    drawTerrain(level);
    drawPlatform(level);
    break;
  }
  moverPersonaje();
  
  updateSpawner();
  updateDiamonds();
  updateObstacles();
  drawDiamonds();
  drawObstacles();
  drawPlayer(1);
  
  hitboxPersonaje.actualizar(personajeX, 600);
  checkDiamondCollision();
  if (checkObstacleCollision()) {
      println("GAME OVER: Colisión con Obstáculo.");
      estado = 99; // Cambia al estado de Game Over
    }
    fill(255);
    textSize(24);
    text("Puntuación: " + score, 10, 30);
  } else if (estado == 2) {
    Tutorial();
  } else if (estado == 3){
    Configuracion();
  }else if (estado == 99) { // Estado GAME OVER
    fill(255, 0, 0);
    textSize(64);
    textAlign(CENTER, CENTER);
    text("GAME OVER", width/2, height/2);
    textAlign(LEFT, BASELINE);
  }
  
  
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

void checkDiamondCollision() {
  float diamondHitboxW = 50.0;
  float diamondHitboxH = 50.0;
  for (int i = diamondX.size() - 1; i >= 0; i--) {
    float diamanteX_Proyectado = diamondX.get(i) + width / 2;
    float diamanteY_Proyectado = diamondY.get(i) + height / 2;
    float obsX = diamanteX_Proyectado - diamondHitboxW / 2;
    float obsY = diamanteY_Proyectado - diamondHitboxH / 2;
    if (hitboxPersonaje.colisionaCon(obsX, obsY, diamondHitboxW, diamondHitboxH)) {
      score += 1;
      diamondX.remove(i);
      diamondY.remove(i);
      diamondRotation.remove(i);
    }
  }
}
boolean checkObstacleCollision() {
  float obstacleHitboxW = 70.0;
  float obstacleHitboxH = 70.0;
  for (int i = obstacleX.size() - 1; i >= 0; i--) {
    float obstacleX_Proyectado = obstacleX.get(i) + width / 2;
    float obstacleY_Proyectado = obstacleY.get(i) + height / 2;
    float obsX = obstacleX_Proyectado - obstacleHitboxW / 2;
    float obsY = obstacleY_Proyectado - obstacleHitboxH / 2;
    if (hitboxPersonaje.colisionaCon(obsX, obsY, obstacleHitboxW, obstacleHitboxH)) {
      return true;
    }
  }
  return false;
}
