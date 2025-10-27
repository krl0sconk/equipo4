PShape[] steve = new PShape[4];
PImage stevetxt;
int currentFrame = 0;
float animationTimer = 0;
float animationSpeed = 0.117;

float personajeX = 640;
float velocidad = 300.0;
float limiteIzq = 540;
float limiteDer = 740;

boolean moverDerecha = false;
boolean moverIzquierda = false;

void setupPlayer() {
  PGraphicsOpenGL pg = (PGraphicsOpenGL) g;
  pg.textureSampling(2);
  hint(DISABLE_TEXTURE_MIPMAPS);
  stevetxt = loadImage("steve.png");
  for (int i = 0; i <= 3; i++) {
    steve[i] = loadShape("steve" + i + ".obj");
    steve[i].setTexture(stevetxt);
  }
}

void keyPressed() {
  if (keyCode == RIGHT || key == 'D' || key == 'd') {
    moverDerecha = true;
  } else if (keyCode == LEFT || key == 'A' || key == 'a') {
    moverIzquierda = true;
  } else if (key == ' ' && gamePhase == PHASE_BOSS) {
    shootProjectile();
  }
}

void keyReleased() {
  if (keyCode == RIGHT || key == 'D' || key == 'd') {
    moverDerecha = false;
  } else if (keyCode == LEFT || key == 'A' || key == 'a') {
    moverIzquierda = false;
  }
}

void moverPersonaje() {
  if (moverDerecha) {
    personajeX += velocidad * deltaTime;
  }
  if (moverIzquierda) {
    personajeX -= velocidad * deltaTime;
  }

  if (mousePressed) {
    float distancia = mouseX - personajeX;
    personajeX += distancia * 0.1;
  }

  personajeX = constrain(personajeX, limiteIzq, limiteDer);
}

void drawPlayer(int state) {
  if (state != 0) {
    animationTimer += deltaTime;
    if (animationTimer >= animationSpeed) {
      currentFrame = (currentFrame + 1) % steve.length;
      animationTimer = 0;
    }
  }

  pushMatrix();
  translate(personajeX, height / 2);
  rotateZ(PI);
  rotateY(PI/2);
  rotateZ(PI/6);
  translate(-250, 70, 0);
  scale(50);
  shape(steve[currentFrame]);
  popMatrix();
}
