PShape diamondModel;
PImage diamondTexture;

ArrayList<Float> diamondX = new ArrayList<Float>();
ArrayList<Float> diamondY = new ArrayList<Float>();
ArrayList<Float> diamondRotation = new ArrayList<Float>();

void setupDiamonds() {
  diamondTexture = loadImage("diamond.png");
  diamondModel = loadShape("diamond.obj");
  diamondModel.setTexture(diamondTexture);
  
  diamondX = new ArrayList<Float>();
  diamondY = new ArrayList<Float>();
  diamondRotation = new ArrayList<Float>();
}

void updateDiamonds() {
  for (int i = diamondX.size() - 1; i >= 0; i--) {
    diamondY.set(i, diamondY.get(i) + 3);
    float newRotation = diamondRotation.get(i) + 0.05;
    diamondRotation.set(i, newRotation);
    
    // Eliminar 
    if (diamondY.get(i) > 700) {
      diamondX.remove(i);
      diamondY.remove(i);
      diamondRotation.remove(i);
    }
  }
}

void drawDiamonds() {
  for (int i = 0; i < diamondX.size(); i++) {
    pushMatrix();
    translate(width / 2, height / 2);
    rotateX(PI / 3);
    translate(diamondX.get(i), diamondY.get(i), 120);
    rotateX(PI / 2);
    rotateY(diamondRotation.get(i));
    scale(50);
    shape(diamondModel);
    popMatrix();
  }
}

void spawnDiamond(float xPos) {
  diamondX.add(xPos);
  diamondY.add(-400.0);
  diamondRotation.add(0.0);
}
