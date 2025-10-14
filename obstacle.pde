// Lista de nombres de obstáculos 
String[] obstacleNames = {"creeper", "zombie"}; 

// Modelos
PShape[][] obstacleModels;
PImage[] obstacleTextures;

// Listas de obstáculos activos en el juego
ArrayList<Float> obstacleX = new ArrayList<Float>();
ArrayList<Float> obstacleY = new ArrayList<Float>();
ArrayList<Integer> obstacleType = new ArrayList<Integer>(); 
ArrayList<Integer> obstacleFrame = new ArrayList<Integer>();

int obstacleAnimationSpeed = 7;

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
  
  println("Obstáculos cargados: " + obstacleNames.length);
}

void updateObstacles() {
  for (int i = obstacleX.size() - 1; i >= 0; i--) {
    obstacleY.set(i, obstacleY.get(i) + 3);
    
    if (frameCount % obstacleAnimationSpeed == 0) {
      int currentFrame = obstacleFrame.get(i);
      int nextFrame = (currentFrame + 1) % 4;
      obstacleFrame.set(i, nextFrame);
    }
    
    // Eliminar 
    if (obstacleY.get(i) > 700) {
      obstacleX.remove(i);
      obstacleY.remove(i);
      obstacleType.remove(i);
      obstacleFrame.remove(i);
    }
  }
}

void drawObstacles() {
  for (int i = 0; i < obstacleX.size(); i++) {
    pushMatrix();
    translate(width / 2, height / 2);
    rotateX(PI / 3);
    translate(obstacleX.get(i), obstacleY.get(i), 80);
    
    rotateZ(PI);
    rotateY(PI/2);
    rotateZ(PI/6);
    translate(-250, 90, 0);
    scale(45);
    shape(obstacleModels[obstacleType.get(i)][ obstacleFrame.get(i)]);
    popMatrix();
  }
}

// Spawnear obstáculo aleatorio
void spawnObstacle(float xPos) {
  int randomType = int(random(obstacleNames.length));
  obstacleX.add(xPos);
  obstacleY.add(-400.0);
  obstacleType.add(randomType); 
  obstacleFrame.add(0);
}
