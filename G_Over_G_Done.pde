void gameOver(){
  reproducirMusica(Gover);
  background(0);
  fill(255, 50, 50);
  textSize(72);
  textAlign(CENTER, CENTER);
  hint(DISABLE_DEPTH_TEST);
  text("GAME OVER", width/2, height/2 - 100);
  fill(255);
  textSize(32);
  text("Puntuacion Final: " + score, width/2, height/2 - 20);
  hint(ENABLE_DEPTH_TEST);
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
}

void gameDone(){
    reproducirMusica(musicaBossDone);
     hint(DISABLE_DEPTH_TEST);
    fill(0, 255, 0);
    textSize(64);
    textAlign(CENTER, CENTER);
    text("BOSS DEFEATED!", width/2, height/2);
    fill(255);
    textSize(32);
    text("Final Score: " + score, width/2, height/2 + 80);
    textAlign(LEFT, BASELINE);
    hint(ENABLE_DEPTH_TEST);
}

void TutoF(){
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
