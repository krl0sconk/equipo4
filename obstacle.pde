String[][] levelObstacles = {
  {"creeper", "zombie"},  // Level 0
  {"creeper", "zombie", "spider"},  // Level 1
  {"creeper", "zombie"},  // Level 2
  {"endermite", "enderman"}   // Level 3 
};

PShape[][][] obstacleModels;  
PImage[][] obstacleTextures;  

ArrayList<Float> obstacleX = new ArrayList<Float>();
ArrayList<Float> obstacleY = new ArrayList<Float>();
ArrayList<Integer> obstacleType = new ArrayList<Integer>();
ArrayList<Integer> obstacleFrame = new ArrayList<Integer>();
ArrayList<Float> obstacleAnimationTimer = new ArrayList<Float>();

float obstacleSpeed = 500.0; // Pixels por segundo
float obstacleAnimationSpeed = 0.067; // ~4 frames a 60fps

void setupObstacles() {
  obstacleModels = new PShape[levelObstacles.length][][];
  obstacleTextures = new PImage[levelObstacles.length][];

  for (int lvl = 0; lvl < levelObstacles.length; lvl++) {
    String[] enemies = levelObstacles[lvl];

    if (enemies.length == 0) continue; 

    obstacleModels[lvl] = new PShape[enemies.length][4];
    obstacleTextures[lvl] = new PImage[enemies.length];

    for (int i = 0; i < enemies.length; i++) {
      String name = enemies[i];

      obstacleTextures[lvl][i] = loadImage(name + ".png");

      for (int frame = 0; frame <= 3; frame++) {
        obstacleModels[lvl][i][frame] = loadShape(name + frame + ".obj");
        obstacleModels[lvl][i][frame].setTexture(obstacleTextures[lvl][i]);
      }
    }
  }

  obstacleX = new ArrayList<Float>();
  obstacleY = new ArrayList<Float>();
  obstacleType = new ArrayList<Integer>();
  obstacleFrame = new ArrayList<Integer>();
  obstacleAnimationTimer = new ArrayList<Float>();
}

void updateObstacles() {
  for (int i = obstacleX.size() - 1; i >= 0; i--) {
    obstacleY.set(i, obstacleY.get(i) + obstacleSpeed * deltaTime);

    float timer = obstacleAnimationTimer.get(i) + deltaTime;
    obstacleAnimationTimer.set(i, timer);

    if (timer >= obstacleAnimationSpeed) {
      int currentFrame = obstacleFrame.get(i);
      int nextFrame = (currentFrame + 1) % 4;
      obstacleFrame.set(i, nextFrame);
      obstacleAnimationTimer.set(i, 0.0);
    }

    if (obstacleY.get(i) > 700) {
      obstacleX.remove(i);
      obstacleY.remove(i);
      obstacleType.remove(i);
      obstacleFrame.remove(i);
      obstacleAnimationTimer.remove(i);
    }
  }
}

void drawObstacles() {
  for (int i = 0; i < obstacleX.size(); i++) {
    pushMatrix();
    translate(width / 2, height / 2);
    rotateX(PI / 3);
    translate(obstacleX.get(i), obstacleY.get(i), 120);
    rotateX(PI / 2);
    rotateY(PI/2);
    scale(40);
    shape(obstacleModels[level][obstacleType.get(i)][obstacleFrame.get(i)]);
    popMatrix();
  }
}

void spawnObstacle(float xPos) {
  // Spawn obstacle based on current level
  int currentLevel = constrain(level, 1, levelObstacles.length - 1);
  int randomType = int(random(levelObstacles[currentLevel].length));

  obstacleX.add(xPos);
  obstacleY.add(-400.0);
  obstacleType.add(randomType);
  obstacleFrame.add(0);
  obstacleAnimationTimer.add(0.0);
}

int getObstacleTypeCount() {
  int currentLevel = constrain(level, 1, levelObstacles.length - 1);
  return levelObstacles[currentLevel].length;
}
