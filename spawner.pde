
// Variables del spawner
int lastSpawnTime = 0;
int spawnInterval = 80;
int minSpawnInterval = 60;
int maxSpawnInterval = 120;

// Probabilidades
float diamondProbability = 0.6; 
float obstacleProbability = 0.4; 

// Posiciones X posibles
float[] lanePositions = {-90, -30, 30, 90};

// Variables para spawning de diamantes en fila
boolean spawningDiamondTrail = false;
int diamondTrailCount = 0;
int maxDiamondsInTrail = 5;
int diamondTrailInterval = 15;
int lastDiamondTrailSpawn = 0;
float diamondTrailLane = 0;

void setupSpawner() {
  lastSpawnTime = frameCount;
}

void updateSpawner() {
  if (spawningDiamondTrail) {
    updateDiamondTrail();
    return;
  }
  
  // Verificar si es tiempo de spawnear un nuevo objeto
  if (frameCount - lastSpawnTime >= spawnInterval) {
    spawnRandomObject();
    lastSpawnTime = frameCount;
    spawnInterval = int(random(minSpawnInterval, maxSpawnInterval));
  }
}

void spawnRandomObject() {
  float rand = random(1);
  
  if (rand < diamondProbability) {
    spawnDiamondPattern();
  } else {
    spawnRandomObstacle();
  }
}

void spawnDiamondPattern() {
  float patternType = random(1);
  
  if (patternType < 0.4) {
    //Fila de diamantes en un carril
    startDiamondTrail();
  } else if (patternType < 0.7) {
    //Diamantes en línea horizontal
    spawnHorizontalDiamonds();
  } else {
    //Diamante individual
    spawnSingleDiamond();
  }
}

void startDiamondTrail() {
  spawningDiamondTrail = true;
  diamondTrailCount = 0;
  lastDiamondTrailSpawn = frameCount;
  diamondTrailLane = getRandomLane();
}

void updateDiamondTrail() {
  if (frameCount - lastDiamondTrailSpawn >= diamondTrailInterval) {
    spawnDiamond(diamondTrailLane);
    diamondTrailCount++;
    lastDiamondTrailSpawn = frameCount;
    
    if (diamondTrailCount >= maxDiamondsInTrail) {
      spawningDiamondTrail = false;
    }
  }
}

void spawnHorizontalDiamonds() {
  int numDiamonds = int(random(2, 4));
  ArrayList<Integer> usedLanes = new ArrayList<Integer>();
  
  for (int i = 0; i < numDiamonds; i++) {
    int laneIndex = int(random(lanePositions.length));
    
    while (usedLanes.contains(laneIndex) && usedLanes.size() < lanePositions.length) {
      laneIndex = int(random(lanePositions.length));
    }
    
    usedLanes.add(laneIndex);
    spawnDiamond(lanePositions[laneIndex]);
  }
}

void spawnSingleDiamond() {
  float lane = getRandomLane();
  spawnDiamond(lane);
}

void spawnRandomObstacle() {
  float lane = getRandomLane();
  spawnObstacle(lane);
}

float getRandomLane() {
  int index = int(random(lanePositions.length));
  return lanePositions[index];
}

void increaseDifficulty() {
  if (minSpawnInterval > 30) {
    minSpawnInterval--;
    maxSpawnInterval--;
  }
}

// Debug (opcional)
void displaySpawnerDebug() {
  fill(255);
  textSize(14);
  text("Diamonds: " + diamondX.size(), 10, 20);
  text("Obstacles: " + obstacleX.size(), 10, 40);
  text("Next spawn: " + (spawnInterval - (frameCount - lastSpawnTime)), 10, 60);
  text("Obstacle types: " + obstacleNames.length, 10, 80);
  
  if (spawningDiamondTrail) {
    text("Diamond trail: " + diamondTrailCount + "/" + maxDiamondsInTrail, 10, 100);
  }
}
