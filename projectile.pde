ArrayList<Float> projectileX = new ArrayList<Float>();
ArrayList<Float> projectileY = new ArrayList<Float>();
ArrayList<Float> projectileZ = new ArrayList<Float>();

float projectileSpeed = 900.0; // Pixels por segundo
float projectileSize = 10;
float shootCooldown = 0;
float cooldownTime = 0.25; // Segundos entre disparos

void setupProjectiles() {
  projectileX = new ArrayList<Float>();
  projectileY = new ArrayList<Float>();
  projectileZ = new ArrayList<Float>();
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

    fill(255, 255, 0);
    stroke(255, 200, 0);
    strokeWeight(2);
    sphere(projectileSize);

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
  if (shootCooldown <= 0) return;

  pushStyle();
  hint(DISABLE_DEPTH_TEST);

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

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(12);
  if (shootCooldown > 0) {
    text("RELOADING", width / 2, barY - 15);
  } else {
    text("READY TO FIRE", width / 2, barY - 15);
  }

  hint(ENABLE_DEPTH_TEST);
  popStyle();
}
