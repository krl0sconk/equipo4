boolean bossVisible = true;
boolean bossInCombat = false;
float bossX = 0;
float bossY = -800;
float bossTargetY = -200;
float bossZ = 120;
float bossSize = 100;
int bossHealth = 10;
int bossMaxHealth = 10;
float bossRotation = 0;
float bossRotationSpeed = 1.2;
float bossApproachSpeed = 200.0;

String[] bossNames = {"skeleton", "elderguardian", "dragon"};
int[] bossMaxFrames = {4, 5, 5};
PShape[][] bossModels;
PImage[] bossTextures;
int bossFrame = 0;
float bossAnimationTimer = 0;
float bossAnimationSpeed = 0.067;

color bossColor = color(255, 0, 0);

void setupBoss() {
  bossModels = new PShape[bossNames.length][];
  bossTextures = new PImage[bossNames.length];

  for (int i = 0; i < bossNames.length; i++) {
    String name = bossNames[i];
    int maxFrames = bossMaxFrames[i];

    bossTextures[i] = loadImage(name + ".png");

    bossModels[i] = new PShape[maxFrames];
    for (int frame = 0; frame < maxFrames; frame++) {
      bossModels[i][frame] = loadShape(name + frame + ".obj");
      bossModels[i][frame].setTexture(bossTextures[i]);
    }
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
  bossFrame = 0;
  bossAnimationTimer = 0;
}

void startBossCombat() {
  bossInCombat = true;
  bossY = -800;
  bossX = 0;
  bossHealth = bossMaxHealth;
}

void updateBoss() {
  if (!bossVisible) return;

  if (bossInCombat && bossY < bossTargetY) {
    bossY += bossApproachSpeed * deltaTime;
    if (bossY > bossTargetY) {
      bossY = bossTargetY;
    }
  }

  bossAnimationTimer += deltaTime;
  if (bossAnimationTimer >= bossAnimationSpeed) {
    int bossType = getBossTypeForLevel();
    int maxFrames = bossMaxFrames[bossType];
    bossFrame = (bossFrame + 1) % maxFrames;
    bossAnimationTimer = 0;
  }
}

int getBossTypeForLevel() {
  if (level == 1) return 0;
  else if (level == 2) return 1;
  else return 2;
}

void drawBoss() {
  if (!bossVisible) return;

  int bossType = getBossTypeForLevel();

  pushMatrix();
  translate(width / 2, height / 2);
  rotateX(PI / 3);
  translate(bossX, bossY, bossZ);

  rotateX(PI / 2);
  rotateY(PI / 2);

  if (bossType == 1) {
    rotateY(-PI / 2);
  }

  scale(80);
  shape(bossModels[bossType][bossFrame]);

  popMatrix();

  if (bossInCombat) {
    drawBossHealthBar();
  }
}


void drawBossHealthBar() {
  pushMatrix();
  pushStyle();

  hint(DISABLE_DEPTH_TEST);

  float barWidth = 300;
  float barHeight = 30;
  float barX = width / 2 - barWidth / 2;
  float barY = 10;

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
