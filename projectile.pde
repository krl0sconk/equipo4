ArrayList<Float> projectileX = new ArrayList<Float>();
ArrayList<Float> projectileY = new ArrayList<Float>();
ArrayList<Float> projectileZ = new ArrayList<Float>();

float projectileSpeed = 900.0;
float projectileSize = 20;
float shootCooldown = 0;
float cooldownTime = 0.25;

PShape arrowModel;
PImage arrowTexture;

void setupProjectiles() {
  projectileX = new ArrayList<Float>();
  projectileY = new ArrayList<Float>();
  projectileZ = new ArrayList<Float>();

  arrowTexture = loadImage("Arrow.png");
  arrowModel = loadShape("Arrow.obj");
  arrowModel.setTexture(arrowTexture);
}

void updateProjectiles() {
  if (shootCooldown > 0) {
    shootCooldown -= deltaTime;
    if (shootCooldown < 0) shootCooldown = 0;
  }

  for (int i = projectileX.size() - 1; i >= 0; i--) {
    projectileY.set(i, projectileY.get(i) - projectileSpeed * deltaTime);

    if (projectileY.get(i) < -1000) {
      projectileX.remove(i);
      projectileY.remove(i);
      projectileZ.remove(i);
      continue;
    }

    if (bossInCombat) {
      if (checkProjectileBossCollision(i)) {
        bossTakeDamage(1);
        projectileX.remove(i);
        projectileY.remove(i);
        projectileZ.remove(i);
      }
    }
  }
}

void drawProjectiles() {
  for (int i = 0; i < projectileX.size(); i++) {
    pushMatrix();
    translate(width / 2, height / 2);
    rotateX(PI / 3);
    translate(projectileX.get(i), projectileY.get(i), projectileZ.get(i));

    rotateX(PI / 2);
    rotateY(PI / 2);
    scale(1);
    shape(arrowModel);

    popMatrix();
  }
}

void shootProjectile() {
  if (shootCooldown > 0) return;

  float worldX = personajeX - width / 2;
  float worldY = 100;
  float worldZ = 120;

  projectileX.add(worldX);
  projectileY.add(worldY);
  projectileZ.add(worldZ);

  shootCooldown = cooldownTime;
}

boolean checkProjectileBossCollision(int projectileIndex) {
  float px = projectileX.get(projectileIndex);
  float py = projectileY.get(projectileIndex);
  float pz = projectileZ.get(projectileIndex);

  float distance = dist(px, py, pz, bossX, bossY, bossZ);
  float collisionDistance = projectileSize + bossSize / 2;

  return distance < collisionDistance;
}

void clearAllProjectiles() {
  projectileX.clear();
  projectileY.clear();
  projectileZ.clear();
  shootCooldown = 0;
}

void drawShootCooldown() {
  pushStyle();
  hint(DISABLE_DEPTH_TEST);

  // Draw shoot button for touch controls
  float buttonSize = min(width, height) * 0.15; // 15% of smaller dimension
  float buttonX = width - buttonSize - 30;
  float buttonY = height - buttonSize - 30;

  // Button background
  if (shootCooldown > 0) {
    fill(100, 100, 100, 150); // Gray when cooling down
  } else {
    fill(255, 100, 100, 200); // Red when ready
  }
  stroke(255);
  strokeWeight(3);
  ellipse(buttonX, buttonY, buttonSize, buttonSize);

  // Button label
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(buttonSize * 0.3);
  text("FIRE", buttonX, buttonY);

  // Cooldown bar (if cooling down)
  if (shootCooldown > 0) {
    float barWidth = 100;
    float barHeight = 10;
    float barX = width / 2 - barWidth / 2;
    float barY = height - 50;

    fill(50);
    noStroke();
    rect(barX, barY, barWidth, barHeight);

    float cooldownPercent = 1.0 - (shootCooldown / cooldownTime);
    fill(0, 255, 0);
    rect(barX, barY, barWidth * cooldownPercent, barHeight);
  }

  hint(ENABLE_DEPTH_TEST);
  popStyle();
}

// Check if touch is on shoot button
boolean isTouchOnShootButton(float touchX, float touchY) {
  float buttonSize = min(width, height) * 0.15;
  float buttonX = width - buttonSize - 30;
  float buttonY = height - buttonSize - 30;

  float distance = dist(touchX, touchY, buttonX, buttonY);
  return distance < buttonSize / 2;
}
