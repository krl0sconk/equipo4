// Boss system variables
boolean bossVisible = true; // Boss is always visible on horizon
boolean bossInCombat = false; // Boss is in combat phase
float bossX = 0;
float bossY = -800; // Far horizon (stays fixed)
float bossZ = 120;
float bossSize = 100;
int bossHealth = 10;
int bossMaxHealth = 10;
float bossRotation = 0;
float bossRotationSpeed = 0.02;

// Boss visual properties
color bossColor = color(255, 0, 0);
PImage bossTexture;

void setupBoss() {
  // Try to load a texture, fallback to solid color if not available
  try {
    bossTexture = loadImage("creeper.png"); // Reuse existing texture
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
  bossY = -800; // Keep at horizon
  bossX = 0;
  bossHealth = bossMaxHealth;
  println("Boss combat started!");
}

void updateBoss() {
  if (!bossVisible) return;

  // Only rotate boss for visual effect (stays at horizon)
  bossRotation += bossRotationSpeed;

  // Boss stays at Y = -800, no movement toward player
}

void drawBoss() {
  if (!bossVisible) return;

  pushMatrix();
  translate(width / 2, height / 2);
  rotateX(PI / 3);
  translate(bossX, bossY, bossZ);

  // Rotate boss
  rotateY(bossRotation);
  rotateX(bossRotation * 0.5);

  // Draw boss cube
  if (bossTexture != null) {
    fill(255);
    stroke(255, 0, 0);
    strokeWeight(2);
    drawTexturedBossCube(bossSize);
  } else {
    // Fallback: solid color cube
    fill(bossColor);
    stroke(255, 0, 0);
    strokeWeight(2);
    box(bossSize);
  }

  popMatrix();

  // Draw health bar only during combat
  if (bossInCombat) {
    drawBossHealthBar();
  }
}

void drawTexturedBossCube(float s) {
  float hs = s / 2;

  // Front face
  beginShape(QUADS);
  texture(bossTexture);
  vertex(-hs, -hs, hs, 0, 0);
  vertex(hs, -hs, hs, 1, 0);
  vertex(hs, hs, hs, 1, 1);
  vertex(-hs, hs, hs, 0, 1);
  endShape();

  // Back face
  beginShape(QUADS);
  texture(bossTexture);
  vertex(hs, -hs, -hs, 0, 0);
  vertex(-hs, -hs, -hs, 1, 0);
  vertex(-hs, hs, -hs, 1, 1);
  vertex(hs, hs, -hs, 0, 1);
  endShape();

  // Left face
  beginShape(QUADS);
  texture(bossTexture);
  vertex(-hs, -hs, -hs, 0, 0);
  vertex(-hs, -hs, hs, 1, 0);
  vertex(-hs, hs, hs, 1, 1);
  vertex(-hs, hs, -hs, 0, 1);
  endShape();

  // Right face
  beginShape(QUADS);
  texture(bossTexture);
  vertex(hs, -hs, hs, 0, 0);
  vertex(hs, -hs, -hs, 1, 0);
  vertex(hs, hs, -hs, 1, 1);
  vertex(hs, hs, hs, 0, 1);
  endShape();

  // Top face
  beginShape(QUADS);
  texture(bossTexture);
  vertex(-hs, -hs, -hs, 0, 0);
  vertex(hs, -hs, -hs, 1, 0);
  vertex(hs, -hs, hs, 1, 1);
  vertex(-hs, -hs, hs, 0, 1);
  endShape();

  // Bottom face
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

  // Reset to 2D drawing
  hint(DISABLE_DEPTH_TEST);

  float barWidth = 300;
  float barHeight = 30;
  float barX = width / 2 - barWidth / 2;
  float barY = 50;

  // Background
  fill(50);
  stroke(255);
  strokeWeight(2);
  rect(barX, barY, barWidth, barHeight);

  // Health fill
  float healthPercent = (float)bossHealth / bossMaxHealth;
  fill(255, 0, 0);
  noStroke();
  rect(barX, barY, barWidth * healthPercent, barHeight);

  // Text
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
  println("Boss hit! Health: " + bossHealth + "/" + bossMaxHealth);

  if (bossHealth <= 0) {
    bossDefeated();
  }
}

void bossDefeated() {
  println("Boss defeated!");
  bossInCombat = false;
  // Will be handled in main game logic
}

boolean isBossInCombat() {
  return bossInCombat;
}

boolean isBossDefeated() {
  return bossInCombat == false && bossHealth <= 0;
}
