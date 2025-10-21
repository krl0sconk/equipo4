float spawnTimer = 0;
float spawnInterval = 0.3; // Segundos
float minSpawnInterval = 0.2;
float maxSpawnInterval = 0.5;

boolean spawnerPaused = false;

float diamondProbability = 0.5;
float obstacleProbability = 0.5;

float[] lanePositions = {-80, -25, 30, 80};

boolean spawningDiamondTrail = false;
int diamondTrailCount = 0;
int maxDiamondsInTrail = 3;
float diamondTrailInterval = 0.25; // Segundos
float diamondTrailTimer = 0;
float diamondTrailLane = 0;

void setupSpawner() {
  spawnTimer = 0;
}

void updateSpawner() {
  if (spawnerPaused) {
    return;
  }

  if (spawningDiamondTrail) {
    updateDiamondTrail();
    return;
  }

  spawnTimer += deltaTime;
  if (spawnTimer >= spawnInterval) {
    spawnRandomObject();
    spawnTimer = 0;
    spawnInterval = random(minSpawnInterval, maxSpawnInterval);
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
  diamondTrailTimer = 0;
  diamondTrailLane = getRandomLane();
}

void updateDiamondTrail() {
  diamondTrailTimer += deltaTime;
  if (diamondTrailTimer >= diamondTrailInterval) {
    spawnDiamond(diamondTrailLane);
    diamondTrailCount++;
    diamondTrailTimer = 0;

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
  if (minSpawnInterval > 0.5) {
    minSpawnInterval -= 0.017; // ~1 frame
    maxSpawnInterval -= 0.017;
  }
}

void pauseSpawner() {
  spawnerPaused = true;
  spawningDiamondTrail = false;
}

void resumeSpawner() {
  spawnerPaused = false;
  spawnTimer = 0;
}
