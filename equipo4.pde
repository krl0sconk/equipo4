int level = 0;
int estado = 0;
int score = 0;
int vidas;
HitboxPlayer hitboxPersonaje;
float HITBOX_W = 10.0;
float HITBOX_H = 10.0;
float HITBOX_OFFSET_X = -5.0;
float HITBOX_OFFSET_Y = height/2;
float invulnerableTime = 0;
float invulnerableDuration = 1.0; 

PImage CoinIcon, HeartIcon;
float deltaTime = 0;
int lastFrameTime = 0;
float targetFPS = 60.0;

int PHASE_NORMAL = 0;
int PHASE_BOSS = 1;
int gamePhase = PHASE_NORMAL;
float bossPhaseTime = 30.0;
float gameTime = 0;
boolean bossDefeatedFlag = false;

float bossFightTimeLimit = 30.0;
float bossFightTime = 0;


void setup() {
  size(1280, 720, P3D);
  CoinIcon = loadImage("DiamondIcon.png");
  HeartIcon = loadImage("HeartIcon.png");
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
  vidas = vidasIniciales;
  
  lastFrameTime = millis();
}

void draw() {
  
  int currentTime = millis();
  deltaTime = (currentTime - lastFrameTime) / 1000.0;
  lastFrameTime = currentTime;

  if (deltaTime > 0.1) deltaTime = 0.1;

  if (estado == 0) {
    mostrarMenu();
  } else if (estado == 1) {
    directionalLight(255, 255, 255, 1, 1, -1);
    switch (level) {
      case 2:
        drawWater();
        drawPlatform(level);
         hint(DISABLE_DEPTH_TEST);
        image(CoinIcon, 30, 30, 60, 60);
        image(HeartIcon, 20,100, 25, 25);
        hint(ENABLE_DEPTH_TEST);
        break;
      default:
        drawTerrain(level);
        drawPlatform(level);
         hint(DISABLE_DEPTH_TEST);
        image(CoinIcon, 30, 30, 60, 60);
        image(HeartIcon, 20,100, 25, 25);
        hint(ENABLE_DEPTH_TEST);

        break;
    }

    if (gamePhase == PHASE_NORMAL) {
      
      gameTime += deltaTime;
      if (gameTime >= bossPhaseTime) {
        transitionToBossPhase();
      }
    } else if (gamePhase == PHASE_BOSS) {
      bossFightTime += deltaTime;
      if (bossFightTime >= bossFightTimeLimit) {
        estado = 4;
      }
    }

    moverPersonaje();

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

  if (gamePhase == PHASE_NORMAL) {
  checkDiamondCollision();
  
  invulnerableTime -= deltaTime;
  if (invulnerableTime < 0) invulnerableTime = 0;
  
  if (invulnerableTime == 0 && checkObstacleCollision()) {
    vidas -= 1;
    invulnerableTime = invulnerableDuration;
    if (vidas <= 0) {
      estado = 4; // GAME OVER
    }
  }
}
    
    fill(255);
    textSize(24);
    text(": " + score, 60, 40);
    fill(255);
    textSize(16);
    text(" : " + vidas, 35, 110);

   
    if (gamePhase == PHASE_BOSS) {
      int timeRemaining = (int)(bossFightTimeLimit - bossFightTime);
      fill(255, 255, 0);
      textSize(28);
      textAlign(RIGHT, TOP);
      text("Time: " + timeRemaining + "s", width - 10, 30);
      textAlign(LEFT, BASELINE);
    } else {
      fill(255);
      textSize(16);
      int timeLeft = (int)(bossPhaseTime - gameTime);
      text("Boss in: " + timeLeft + "s", 10, 80);
    }

  } else if (estado == 2) {
    Tutorial();
  } else if (estado == 3) {
    Configuracion();
  } else if (estado == 4) {
  background(0);
  fill(255, 50, 50);
  textSize(72);
  textAlign(CENTER, CENTER);
  text("GAME OVER", width/2, height/2 - 100);
  fill(255);
  textSize(32);
  text("Puntuacion Final: " + score, width/2, height/2 - 20);

  float btnTryW = 200;
  float btnTryH = 60;
  float btnTryX = width/2 - btnTryW/2;
  float btnTryY = height/2 + 50;
  if (mouseX > btnTryX && mouseX < btnTryX + btnTryW &&
      mouseY > btnTryY && mouseY < btnTryY + btnTryH) {
    fill(100, 200, 100);
  } else {
    fill(50, 150, 50);
  }
  rect(btnTryX, btnTryY, btnTryW, btnTryH, 10);
  fill(255);
  textSize(28);
  text("TRY AGAIN", width/2, btnTryY + btnTryH/2 + 5);

  float btnMenuW = 280;
  float btnMenuH = 60;
  float btnMenuX = width/2 - btnMenuW/2;
  float btnMenuY = height/2 + 130;
  if (mouseX > btnMenuX && mouseX < btnMenuX + btnMenuW &&
      mouseY > btnMenuY && mouseY < btnMenuY + btnMenuH) {
    fill(100, 100, 200);
  } else {
    fill(50, 50, 150);
  }
  rect(btnMenuX, btnMenuY, btnMenuW, btnMenuH, 10);
  fill(255);
  textSize(24);
  text("MENU PRINCIPAL", width/2, btnMenuY + btnMenuH/2 + 5);
  textAlign(LEFT, BASELINE);
  } else if (estado == 5) {
    fill(0, 255, 0);
    textSize(64);
    textAlign(CENTER, CENTER);
    text("BOSS DEFEATED!", width/2, height/2);
    fill(255);
    textSize(32);
    text("Final Score: " + score, width/2, height/2 + 80);
    textAlign(LEFT, BASELINE);
  } else if (estado == 6){
      drawTerrain(1);
      drawPlatform(1);
      image(ret, 35, 35);
      rectMode(CENTER);
      moverPersonaje();
      drawPlayer(1);
      image(tabla, width/2-400, height/2-250);
      textAlign(CENTER, CENTER);
      textSize(24);

      fill(0);
      text("Puedes moverte con: ", width/2 - 392, height/2-300);
      text("1. A y D ", width/2 - 392, height/2-252);
      text("2. Las ´<-´ y ´->´ ", width/2 - 392, height/2 - 214);
      text("3. El mouse ", width/2 - 392, height/2-176);
  
  }
}

void mousePressed() {
  if (estado == 0) {
    if (mouseX > width/2 - 85 && mouseX < width/2 + 80 &&
        mouseY > 480 && mouseY < 530) {
      estado = 1;
      resetGame();
    }
    if (mouseX > width/2 - 20 && mouseX < width/2 + 20 &&
        mouseY > 532 && mouseY < 550) {
      estado = 2;
    }
    if (mouseX > width-60 && mouseX < width && mouseY < 60) {
      estado = 3;
    }
  } else if (estado == 2) {
    if (mouseX < 70 && mouseY < 70) {
      estado = 0;
    }
    
      if (mouseX > width/2 - 24 && mouseX < width/2 +32 && mouseY > height/2 + 48  && mouseY < height/2 + 100 ) {
      estado = 6;
    }
  } else if (estado == 3) {
    if (mouseX < 70 && mouseY < 70) {
      estado = 0;
    } 
      //Funciones boton volumen
    if ( mouseX > width/2 - btnVolumenW/2 && mouseX < width/2 + btnVolumenW/2 && mouseY > btnVolumenY - btnVolumenH/2 && mouseY < btnVolumenY + btnVolumenH/2){
        if (indiceVolumen < 2) {
              indiceVolumen += 1;
        } else {
            indiceVolumen = 0;
        }
    }
    
    //funciones boton Vida
     if ( mouseX > width/2 - btnVolumenW/2 && mouseX < width/2 + btnVolumenW/2 && mouseY > btnVidasY - btnVidasH/2 && mouseY < btnVidasY + btnVidasH/2){
        if (indiceVidas < 2) {
          indiceVidas += 1;
        } else {
          indiceVidas = 0;
        }
    }
    //funcion boton guardar y volver
    if (mouseX > width/2 - btnVolumenW/2 && mouseX < width/2 + btnVolumenW/2 &&  mouseY >btnGuardarY - btnGuardarH/2 && mouseY < btnGuardarY + btnGuardarH/2){
        
      estado = 0;
        
    }
   
    
  } else if (estado == 4) {
    float btnTryW = 200;
    float btnTryH = 60;
    float btnTryX = width/2 - btnTryW/2;
    float btnTryY = height/2 + 50;

    if (mouseX > btnTryX && mouseX < btnTryX + btnTryW &&
        mouseY > btnTryY && mouseY < btnTryY + btnTryH) {
      estado = 1;
      resetGame();
    }

    float btnMenuW = 220;
    float btnMenuH = 60;
    float btnMenuX = width/2 - btnMenuW/2;
    float btnMenuY = height/2 + 130;

    if (mouseX > btnMenuX && mouseX < btnMenuX + btnMenuW &&
        mouseY > btnMenuY && mouseY < btnMenuY + btnMenuH) {
      estado = 0;
      resetGame();
    }
  } else if(estado == 5){
      if (mouseX >= 0  && mouseY >= 0){
      estado = 0;}
    } else if (estado == 6){
        if (mouseX < 70 && mouseY < 70) {
      estado = 0;
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
  estado = 5;
  score += 100;
  if (level < 3) {
    level +=1;
  } else {
    level = 1;
  }
}

void resetGame() {
  gamePhase = PHASE_NORMAL;
  gameTime = 0;
  bossFightTime = 0;
  score = 0;
  vidas = vidasIniciales;
  bossDefeatedFlag = false;
  resetBoss();
  resumeSpawner();
  clearExistingObjects();
  clearAllProjectiles();
}
