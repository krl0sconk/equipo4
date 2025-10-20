// Variables globales del juego
int level = 0;
int estado = 0;
int score = 0;
HitboxPlayer hitboxPersonaje;
float HITBOX_W = 10.0;
float HITBOX_H = 10.0;
float HITBOX_OFFSET_X = -5.0;
float HITBOX_OFFSET_Y = height/2;

// Sistema de deltaTime para independencia de framerate
float deltaTime = 0;
int lastFrameTime = 0;
float targetFPS = 60.0;

// Sistema de fases del juego
int PHASE_NORMAL = 0;
int PHASE_BOSS = 1;
int gamePhase = PHASE_NORMAL;
float bossPhaseTime = 30.0; // 30 segundos hasta fase de jefe
float gameTime = 0;
boolean bossDefeatedFlag = false;

// Límite de tiempo para derrotar al jefe
float bossFightTimeLimit = 30.0; // 30 segundos
float bossFightTime = 0;


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
  lastFrameTime = millis();
}

void draw() {
  // Calcular deltaTime
  int currentTime = millis();
  deltaTime = (currentTime - lastFrameTime) / 1000.0;
  lastFrameTime = currentTime;

  if (deltaTime > 0.1) deltaTime = 0.1; // Limitar saltos grandes

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

    // Actualizar temporizadores de fase
    if (gamePhase == PHASE_NORMAL) {
      gameTime += deltaTime;
      if (gameTime >= bossPhaseTime) {
        transitionToBossPhase();
      }
    } else if (gamePhase == PHASE_BOSS) {
      bossFightTime += deltaTime;
      if (bossFightTime >= bossFightTimeLimit) {
        estado = 99;
      }
    }

    moverPersonaje();

    // Actualizar sistemas según fase
    if (gamePhase == PHASE_NORMAL) {
      updateSpawner();
      updateDiamonds();
      updateObstacles();
    } else if (gamePhase == PHASE_BOSS) {
      updateProjectiles();

      if (!bossInCombat && !bossDefeatedFlag) {
        bossDefeatedFlag = true;
        onBossDefeated();
      }
    }

    updateBoss();

    drawDiamonds();
    drawObstacles();
    drawPlayer(1);
    drawBoss();

    if (gamePhase == PHASE_BOSS) {
      drawProjectiles();
      drawShootCooldown();
    }

    hitboxPersonaje.actualizar(personajeX, 600);

    // Colisiones solo en fase normal
    if (gamePhase == PHASE_NORMAL) {
      checkDiamondCollision();
      if (checkObstacleCollision()) {
        estado = 99;
      }
    }

    // UI
    fill(255);
    textSize(24);
    text("Puntuación: " + score, 10, 30);

    if (gamePhase == PHASE_BOSS) {
      fill(255, 0, 0);
      textSize(32);
      textAlign(CENTER, TOP);
      text("BOSS FIGHT!", width/2, 10);

      int timeRemaining = (int)(bossFightTimeLimit - bossFightTime);
      fill(255, 255, 0);
      textSize(28);
      text("Time: " + timeRemaining + "s", width/2, 100);
      textAlign(LEFT, BASELINE);
    } else {
      fill(255);
      textSize(16);
      int timeLeft = (int)(bossPhaseTime - gameTime);
      text("Boss in: " + timeLeft + "s", 10, 60);
    }

  } else if (estado == 2) {
    Tutorial();
  } else if (estado == 3) {
    Configuracion();
  } else if (estado == 99) {
    fill(255, 0, 0);
    textSize(64);
    textAlign(CENTER, CENTER);
    text("GAME OVER", width/2, height/2);
    textAlign(LEFT, BASELINE);
  } else if (estado == 100) {
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
    if (mouseX > width/2 - 85 && mouseX < width/2 + 80 &&
        mouseY > 480 && mouseY < 530) {
      estado = 1;
      resetGame();
    }
    if (mouseX > width/2 - 10 && mouseX < width/2 + 10 &&
        mouseY > 532 && mouseY < 550) {
      estado = 2;
    }
    if (mouseX > width-60 && mouseX < width && mouseY < 60) {
      estado = 3;
    }
  } else if (estado == 1 && gamePhase == PHASE_BOSS) {
    shootProjectile();
  } else if (estado == 2) {
    if (mouseX < 70 && mouseY < 70) {
      estado = 0;
    }
  } else if (estado == 3) {
    if (mouseX < 70 && mouseY < 70) {
      estado = 0;
    }
  }
}

void mouseDragged() {
  if (estado == 3) {
    if (mouseX > width/2 - 160 && mouseX < width/2 + 160 &&
        mouseY > height/2 - 95 && mouseY < height/2 - 55) {
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

void transitionToBossPhase() {
  gamePhase = PHASE_BOSS;
  bossFightTime = 0;
  pauseSpawner();
  clearExistingObjects();
  startBossCombat();
}

void clearExistingObjects() {
  diamondX.clear();
  diamondY.clear();
  diamondRotation.clear();
  obstacleX.clear();
  obstacleY.clear();
  obstacleType.clear();
  obstacleFrame.clear();
}

void onBossDefeated() {
  estado = 100;
  score += 100;
}

void resetGame() {
  gamePhase = PHASE_NORMAL;
  gameTime = 0;
  bossFightTime = 0;
  score = 0;
  bossDefeatedFlag = false;
  resetBoss();
  resumeSpawner();
  clearExistingObjects();
  clearAllProjectiles();
}
