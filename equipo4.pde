int level = 0;
int estado = 0;
int score = 0;
HitboxPlayer hitboxPersonaje;
float HITBOX_W = 10.0;
float HITBOX_H = 10.0;
float HITBOX_OFFSET_X = -5.0; // Tus offsets de alineación
float HITBOX_OFFSET_Y = height/2;

// Game phase system
int PHASE_NORMAL = 0;
int PHASE_BOSS = 1;
int gamePhase = PHASE_NORMAL;
int bossPhaseTimer = 1800; // Time until boss phase starts (30 seconds at 60fps)
int gameTimer = 0;
boolean bossDefeatedFlag = false;

// Boss fight time limit
int bossFightTimeLimit = 1800; // 30 seconds at 60fps to defeat boss
int bossFightTimer = 0;


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
  setupBoss();
  setupProjectiles();
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

  // Update game timer and check phase transitions
  if (gamePhase == PHASE_NORMAL) {
    gameTimer++;
    if (gameTimer >= bossPhaseTimer) {
      transitionToBossPhase();
    }
  } else if (gamePhase == PHASE_BOSS) {
    bossFightTimer++;
    // Check if time ran out
    if (bossFightTimer >= bossFightTimeLimit) {
      println("TIME'S UP! Boss fight failed.");
      estado = 99; // Game over
    }
  }

  moverPersonaje();

  // Update systems based on phase
  if (gamePhase == PHASE_NORMAL) {
    updateSpawner();
    updateDiamonds();
    updateObstacles();
  } else if (gamePhase == PHASE_BOSS) {
    updateProjectiles();

    // Check if boss defeated
    if (!bossInCombat && !bossDefeatedFlag) {
      bossDefeatedFlag = true;
      onBossDefeated();
    }
  }

  // Always update boss (visible in both phases)
  updateBoss();

  // Draw objects
  drawDiamonds();
  drawObstacles();
  drawPlayer(1);

  // Always draw boss (visible on horizon)
  drawBoss();

  // Boss phase specific drawing
  if (gamePhase == PHASE_BOSS) {
    drawProjectiles();
    drawShootCooldown();
  }

  hitboxPersonaje.actualizar(personajeX, 600);

  // Collision checks (only in normal phase)
  if (gamePhase == PHASE_NORMAL) {
    checkDiamondCollision();
    if (checkObstacleCollision()) {
      println("GAME OVER: Colisión con Obstáculo.");
      estado = 99;
    }
  }

  // UI
  fill(255);
  textSize(24);
  text("Puntuación: " + score, 10, 30);

  // Phase indicator
  if (gamePhase == PHASE_BOSS) {
    fill(255, 0, 0);
    textSize(32);
    textAlign(CENTER, TOP);
    text("BOSS FIGHT!", width/2, 10);

    // Display time remaining
    int timeRemaining = (bossFightTimeLimit - bossFightTimer) / 60;
    fill(255, 255, 0);
    textSize(28);
    text("Time: " + timeRemaining + "s", width/2, 100);
    textAlign(LEFT, BASELINE);
  } else {
    fill(255);
    textSize(16);
    int timeLeft = (bossPhaseTimer - gameTimer) / 60;
    text("Boss in: " + timeLeft + "s", 10, 60);
  }

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
  } else if (estado == 100) { // VICTORY
    fill(0, 255, 0);
    textSize(64);
    textAlign(CENTER, CENTER);
    text("BOSS DEFEATED!", width/2, height/2);
    fill(255);
    textSize(32);
    text("Final Score: " + score, width/2, height/2 + 80);
    textAlign(LEFT, BASELINE);
  }


}

void mousePressed() {
  if (estado == 0) {
    // Botón Jugar
    if (mouseX > width/2 - 85 && mouseX < width/2 + 80 &&
      mouseY> 480 && mouseY < 530) {
      estado = 1;
      resetGame();
    }
    if (mouseX > width/2 - 10 && mouseX < width/2 + 10 &&
      mouseY> 532 && mouseY < 550) {
      estado = 2;
    }
    if(mouseX > width-60 && mouseX < width && mouseY <60){
        estado = 3;

    }

  } else if (estado == 1 && gamePhase == PHASE_BOSS) {
    // Shoot projectile when in boss phase
    shootProjectile();
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

// Phase transition functions
void transitionToBossPhase() {
  println("Transitioning to BOSS PHASE!");
  gamePhase = PHASE_BOSS;
  bossFightTimer = 0; // Reset boss fight timer
  pauseSpawner();
  clearExistingObjects();
  startBossCombat();
}

void clearExistingObjects() {
  // Clear all diamonds and obstacles
  diamondX.clear();
  diamondY.clear();
  diamondRotation.clear();
  obstacleX.clear();
  obstacleY.clear();
  obstacleType.clear();
  obstacleFrame.clear();
}

void onBossDefeated() {
  println("Boss has been defeated!");
  estado = 100; // Victory state
  score += 100; // Bonus points for defeating boss
}

void resetGame() {
  gamePhase = PHASE_NORMAL;
  gameTimer = 0;
  bossFightTimer = 0;
  score = 0;
  bossDefeatedFlag = false;
  resetBoss();
  resumeSpawner();
  clearExistingObjects();
  clearAllProjectiles();
}
