// Projectile system
ArrayList<Float> projectileX = new ArrayList<Float>();
ArrayList<Float> projectileY = new ArrayList<Float>();
ArrayList<Float> projectileZ = new ArrayList<Float>();

float projectileSpeed = 15;
float projectileSize = 10;
int shootCooldown = 0;
int cooldownTime = 15; // frames between shots

void setupProjectiles() {
  projectileX = new ArrayList<Float>();
  projectileY = new ArrayList<Float>();
  projectileZ = new ArrayList<Float>();
}

void updateProjectiles() {
  // Update cooldown
  if (shootCooldown > 0) {
    shootCooldown--;
  }

  // Move all projectiles away from player (negative Y direction in world space)
  for (int i = projectileX.size() - 1; i >= 0; i--) {
    projectileY.set(i, projectileY.get(i) - projectileSpeed);

    // Remove projectiles that went too far
    if (projectileY.get(i) < -1000) {
      projectileX.remove(i);
      projectileY.remove(i);
      projectileZ.remove(i);
      continue;
    }

    // Check collision with boss
    if (bossInCombat) {
      if (checkProjectileBossCollision(i)) {
        bossTakeDamage(1);
        // Remove projectile on hit
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

    // Draw projectile as glowing sphere/cube
    fill(255, 255, 0);
    stroke(255, 200, 0);
    strokeWeight(2);
    sphere(projectileSize);

    popMatrix();
  }
}

void shootProjectile() {
  if (shootCooldown > 0) {
    println("Cooldown active, cannot shoot yet!");
    return;
  }

  // Spawn projectile at player position
  // Convert player screen X to world X (offset from center)
  float worldX = personajeX - width / 2;
  float worldY = 100; // Slightly in front of player
  float worldZ = 120; // Same Z as boss

  projectileX.add(worldX);
  projectileY.add(worldY);
  projectileZ.add(worldZ);

  shootCooldown = cooldownTime;
  println("Projectile fired! Active projectiles: " + projectileX.size());
}

boolean checkProjectileBossCollision(int projectileIndex) {
  float px = projectileX.get(projectileIndex);
  float py = projectileY.get(projectileIndex);
  float pz = projectileZ.get(projectileIndex);

  // Simple 3D distance check
  float distance = dist(px, py, pz, bossX, bossY, bossZ);

  // Collision if distance is less than combined radii
  float collisionDistance = projectileSize + bossSize / 2;

  return distance < collisionDistance;
}

void clearAllProjectiles() {
  projectileX.clear();
  projectileY.clear();
  projectileZ.clear();
  shootCooldown = 0;
}

// Visual indicator for cooldown
void drawShootCooldown() {
  if (shootCooldown <= 0) return;

  pushStyle();
  hint(DISABLE_DEPTH_TEST);

  float barWidth = 100;
  float barHeight = 10;
  float barX = width / 2 - barWidth / 2;
  float barY = height - 50;

  // Background
  fill(50);
  noStroke();
  rect(barX, barY, barWidth, barHeight);

  // Cooldown fill
  float cooldownPercent = 1.0 - ((float)shootCooldown / cooldownTime);
  fill(0, 255, 0);
  rect(barX, barY, barWidth * cooldownPercent, barHeight);

  // Text
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
