PShape[] steve = new PShape[4];
PImage stevetxt;
int currentFrame = 0;
int animationSpeed = 7;
int stevestate = 0;

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
float personajeX = 640;
float velocidad = 5;
float limiteIzq = 540;
float limiteDer = 740;
void moverPersonaje() {
  if (keyPressed) {
    if (keyCode == RIGHT || key == 'd') {
      personajeX += velocidad;
    } else if (keyCode == LEFT || key == 'a') {
      personajeX -= velocidad;
    }
  }

  if (mousePressed) {
    if (mouseX > personajeX) {
      personajeX += velocidad;
    } else if (mouseX < personajeX) {
      personajeX -= velocidad;
    }
  }

  personajeX = constrain(personajeX, limiteIzq, limiteDer);
}

void drawPlayer(int state) {

  if (state != 0) {
    if (frameCount % animationSpeed == 0) {
      currentFrame = (currentFrame + 1) % steve.length;
    }
  }
  pushMatrix();
  translate(personajeX, height/2);
  rotateZ(PI);
  rotateY(PI/2);
  rotateZ(PI/6);
  translate(-250, 70, 0);
  scale(50);
  shape(steve[currentFrame]);
  popMatrix();
}
