boolean bossVisible = true;
boolean bossInCombat = false;
float bossX = 0;
float bossY = -800;
float bossZ = 120;
float bossSize = 100;
int bossHealth = 10;
int bossMaxHealth = 10;
float bossRotation = 0;
float bossRotationSpeed = 1.2; // Radianes por segundo

color bossColor = color(255, 0, 0);
PImage bossTexture;

void setupBoss() {
  try {
    bossTexture = loadImage("creeper.png");
  } catch (Exception e) {
    bossTexture = null;
  }
  resetBoss();
}

void resetBoss() {
  bossVisible = true;
  bossInCombat = false;
  bossX = 0;
  bossY = -800;
  bossHealth = bossMaxHealth;
  bossRotation = 0;
}

void startBossCombat() {
  bossInCombat = true;
  bossY = -800;
  bossX = 0;
  bossHealth = bossMaxHealth;
}

void updateBoss() {
  if (!bossVisible) return;
  bossRotation += bossRotationSpeed * deltaTime;
}

void drawBoss() {
  if (!bossVisible) return;

  pushMatrix();
  translate(width / 2, height / 2);
  rotateX(PI / 3);
  translate(bossX, bossY, bossZ);

  rotateY(bossRotation);
  rotateX(bossRotation * 0.5);

  if (bossTexture != null) {
    fill(255);
    stroke(255, 0, 0);
    strokeWeight(2);
    drawTexturedBossCube(bossSize);
  } else {
    fill(bossColor);
    stroke(255, 0, 0);
    strokeWeight(2);
    box(bossSize);
  }

  popMatrix();

  if (bossInCombat) {
    drawBossHealthBar();
  }
}

void drawTexturedBossCube(float s) {
  float hs = s / 2;

  beginShape(QUADS);
  texture(bossTexture);
  vertex(-hs, -hs, hs, 0, 0);
  vertex(hs, -hs, hs, 1, 0);
  vertex(hs, hs, hs, 1, 1);
  vertex(-hs, hs, hs, 0, 1);
  endShape();

  beginShape(QUADS);
  texture(bossTexture);
  vertex(hs, -hs, -hs, 0, 0);
  vertex(-hs, -hs, -hs, 1, 0);
  vertex(-hs, hs, -hs, 1, 1);
  vertex(hs, hs, -hs, 0, 1);
  endShape();

  beginShape(QUADS);
  texture(bossTexture);
  vertex(-hs, -hs, -hs, 0, 0);
  vertex(-hs, -hs, hs, 1, 0);
  vertex(-hs, hs, hs, 1, 1);
  vertex(-hs, hs, -hs, 0, 1);
  endShape();

  beginShape(QUADS);
  texture(bossTexture);
  vertex(hs, -hs, hs, 0, 0);
  vertex(hs, -hs, -hs, 1, 0);
  vertex(hs, hs, -hs, 1, 1);
  vertex(hs, hs, hs, 0, 1);
  endShape();

  beginShape(QUADS);
  texture(bossTexture);
  vertex(-hs, -hs, -hs, 0, 0);
  vertex(hs, -hs, -hs, 1, 0);
  vertex(hs, -hs, hs, 1, 1);
  vertex(-hs, -hs, hs, 0, 1);
  endShape();

  beginShape(QUADS);
  texture(bossTexture);
  vertex(-hs, hs, hs, 0, 0);
  vertex(hs, hs, hs, 1, 0);
  vertex(hs, hs, -hs, 1, 1);
  vertex(-hs, hs, -hs, 0, 1);
  endShape();
}

void drawBossHealthBar() {
  pushMatrix();
  pushStyle();

  hint(DISABLE_DEPTH_TEST);

  float barWidth = 300;
  float barHeight = 30;
  float barX = width / 2 - barWidth / 2;
  float barY = 50;

  fill(50);
  stroke(255);
  strokeWeight(2);
  rect(barX, barY, barWidth, barHeight);

  float healthPercent = (float)bossHealth / bossMaxHealth;
  fill(255, 0, 0);
  noStroke();
  rect(barX, barY, barWidth * healthPercent, barHeight);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(20);
  text("BOSS: " + bossHealth + "/" + bossMaxHealth, width / 2, barY + barHeight / 2);

  hint(ENABLE_DEPTH_TEST);

  popStyle();
  popMatrix();
}

void bossTakeDamage(int damage) {
  if (!bossInCombat) return;

  bossHealth -= damage;

  if (bossHealth <= 0) {
    bossDefeated();
  }
}

void bossDefeated() {
  bossInCombat = false;
}

boolean isBossInCombat() {
  return bossInCombat;
}

boolean isBossDefeated() {
  return bossInCombat == false && bossHealth <= 0;
}
