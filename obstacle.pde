String[] obstacleNames = {"creeper", "zombie"};

PShape[][] obstacleModels;
PImage[] obstacleTextures;

ArrayList<Float> obstacleX = new ArrayList<Float>();
ArrayList<Float> obstacleY = new ArrayList<Float>();
ArrayList<Integer> obstacleType = new ArrayList<Integer>();
ArrayList<Integer> obstacleFrame = new ArrayList<Integer>();
ArrayList<Float> obstacleAnimationTimer = new ArrayList<Float>();

float obstacleSpeed = 500.0; // Pixels por segundo
float obstacleAnimationSpeed = 0.067; // ~4 frames a 60fps

void setupObstacles() {
  obstacleModels = new PShape[obstacleNames.length][4];
  obstacleTextures = new PImage[obstacleNames.length];

  for (int i = 0; i < obstacleNames.length; i++) {
    String name = obstacleNames[i];

    obstacleTextures[i] = loadImage(name + ".png");

    for (int frame = 0; frame <= 3; frame++) {
      obstacleModels[i][frame] = loadShape(name + frame + ".obj");
      obstacleModels[i][frame].setTexture(obstacleTextures[i]);
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
    shape(obstacleModels[obstacleType.get(i)][ obstacleFrame.get(i)]);
    popMatrix();
  }
}

void spawnObstacle(float xPos) {
  int randomType = int(random(obstacleNames.length));
  obstacleX.add(xPos);
  obstacleY.add(-400.0);
  obstacleType.add(randomType);
  obstacleFrame.add(0);
  obstacleAnimationTimer.add(0.0);
}
