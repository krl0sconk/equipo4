class HitboxPlayer {
  float w, h;
  float offsetX, offsetY;
  float posX, posY;
  int collisionCounter = 0;
  float debugBoxW = 0.5;
  float debugBoxH = 2.5;
  float debugBoxD = 0.5;
  float debugBoxYOffsetLocal = -0.5;

  HitboxPlayer(float initialX, float initialY, float width, float height, float ox, float oy) {
    this.posX = initialX + ox;
    this.posY = initialY + oy;
    this.w = width;
    this.h = height;
    this.offsetX = ox;
    this.offsetY = oy;
  }

  void actualizar(float newPersonajeX, float newPersonajeY) {
    this.posX = newPersonajeX + this.offsetX;
    this.posY = newPersonajeY + this.offsetY;
  }

  void mostrar3D() {
    pushStyle();
    noFill();
    if (collisionCounter > 0) {
      stroke(255, 0, 0);
    } else {
      stroke(0, 255, 0);
    }
    strokeWeight(1 / 50.0);
    translate(0, this.debugBoxYOffsetLocal, 0);
    box(this.debugBoxW, this.debugBoxH, this.debugBoxD);
    popStyle();
  }

  boolean colisionaCon(float otherX, float otherY, float otherW, float otherH) {
    float r1x = this.posX - (this.w / 2);
    float r1y = this.posY - (this.h / 2);
    float r1w = this.w;
    float r1h = this.h;
    float r2x = otherX;
    float r2y = otherY;
    float r2w = otherW;
    float r2h = otherH;
    boolean hit = (r1x + r1w >= r2x && r1x <= r2x + r2w && r1y + r1h >= r2y && r1y <= r2y + r2h);
    if (hit) {
      this.collisionCounter++;
    } else {
      this.collisionCounter = 0;
    }
    return hit;
  }
}
