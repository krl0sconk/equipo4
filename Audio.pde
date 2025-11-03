import ddf.minim.*;
Minim minim;

AudioPlayer musicaMenu;
AudioPlayer musicaSeleccionarNivel;
AudioPlayer musicaNivel1;
AudioPlayer musicaNivel2;
AudioPlayer musicaNivel3;
AudioPlayer musicaBossFight;
AudioPlayer musicaBossDone;
AudioSample sonidoChoque;
AudioSample sonidoMoneda;
AudioPlayer Gover;

void setupmusica(){
   minim = new Minim(this);
  musicaMenu = minim.loadFile("MMtheme.mp3");
  musicaSeleccionarNivel = minim.loadFile("SMtheme.mp3");
  musicaNivel1 = minim.loadFile("N1theme.mp3");
  musicaNivel2 = minim.loadFile("N2theme.mp3");
  musicaNivel3 = minim.loadFile("N3theme.mp3");
  musicaBossFight = minim.loadFile("BFtheme.mp3");
  musicaBossDone = minim.loadFile("BDtheme.mp3");
  
  Gover = minim.loadFile("GOtheme.mp3");
  sonidoChoque = minim.loadSample("golpe.wav", 512);
  sonidoMoneda = minim.loadSample("moneda.mp3", 512);
}

void actualizarVolumen() {
  float vol = moderacionVolumen[indiceVolumen];

  musicaMenu.setGain(linearToDecibels(vol));
  musicaSeleccionarNivel.setGain(linearToDecibels(vol));
  musicaNivel1.setGain(linearToDecibels(vol));
  musicaNivel2.setGain(linearToDecibels(vol));
  musicaNivel3.setGain(linearToDecibels(vol));
  musicaBossDone.setGain(linearToDecibels(vol));
  sonidoChoque.setGain(linearToDecibels(vol));
  sonidoMoneda.setGain(linearToDecibels(vol));
}

float linearToDecibels(float lin) {
  return 20 * log(lin) / log(10);
}

void reproducirMusica(AudioPlayer music){
  if(!music.isPlaying()){
    detenerTodasLasMusicas();
    music.rewind();
    music.play();
  }
}

void detenerTodasLasMusicas() {
  musicaMenu.pause();
  musicaSeleccionarNivel.pause();
  musicaNivel1.pause();
  musicaNivel2.pause();
  musicaNivel3.pause();
  musicaBossDone.pause();
  musicaBossFight.pause();
  Gover.pause();
}
