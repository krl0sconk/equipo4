class HitboxPlayer {
  float x, y;
  float w, h;   
  float offsetX, offsetY; 

  HitboxPlayer(float startX, float startY, float ancho, float alto, float offsetX, float offsetY) {
    this.w = ancho;
    this.h = alto;
    this.offsetX = offsetX;
    this.offsetY = offsetY;
    actualizar(startX, startY);
  }

  void actualizar(float personajeX, float personajeY) {
    x = personajeX + offsetX;
    y = personajeY + offsetY;
  }

  void mostrar() {
    noFill();
    stroke(255, 0, 0);
    rect(x, y, w, h);
  }

  boolean colisionaCon(HitboxPlayer otro) {
    return (x < otro.x + otro.w &&
            x + w > otro.x &&
            y < otro.y + otro.h &&
            y + h > otro.y);
  }
}
