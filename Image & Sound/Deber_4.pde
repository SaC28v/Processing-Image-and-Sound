import processing.sound.*;
//Generacion de imagen a traves de pixeles con interactividad asbtracta//

//-----------------------//
PImage Fondo;
PImage Cometa;
SoundFile MFondo;
SoundFile MCometa;

Particulas[] particulas;
ArrayList<Cometa> cometas;
color colorCometa = color(255);

void setup(){
  size(720,720); 
  background(0);
    
  Fondo = loadImage("Fondo.jpg");
  Cometa = loadImage("Cometa.png");
  
  MFondo = new SoundFile(this, "MFondo.mp3");
  MCometa = new SoundFile(this, "MCometa1.wav");
  MFondo.loop();
 
  
  particulas = new Particulas[1500];
  for(int i = 0; i < particulas.length; i++){
    particulas[i] = new Particulas();
  }

  cometas = new ArrayList<Cometa>();
}

void draw(){
  
  for(int i = 0; i < particulas.length; i++){
    particulas[i].mostrar();
    particulas[i].mover();
  }
  
  for (int i = cometas.size() - 1; i >= 0; i--) {
    Cometa cometa = cometas.get(i);
    cometa.mostrar();
    cometa.mover();

    // Elimina el cometa de la lista cuando ya no es visible
    if (cometa.x < -Cometa.width || cometa.y > height) {
      cometas.remove(i);
    }
  }
}

class Cometa{
  float x, y, velocidad, factor, ancho, alto;
  color colorCometa;
  
  public Cometa(color c){
    this.x = random(width);
    this.y = -50;
    this.velocidad = random(1,3);
    this.ancho = Cometa.width;
    this.alto = Cometa.height;
    this.factor = 0.1;
    this.colorCometa = c;
  }
  
  public void mostrar() {
    tint(colorCometa);
    image(Cometa, x, y,ancho * factor, alto * factor);
    noTint();
  }
  
  public void mover() {
   x = x - velocidad;
   y = y + velocidad;

  }
  
  void setColor(color nuevoColor){
    colorCometa = nuevoColor;
  }
    
}
class Particulas{
  float x, y, vx, vy, i, velocidad;
  float brillo = 1.0;
  
  public Particulas(){
    this.x = width/2;
    this.y = height/2;
    this.i = random(TWO_PI);
    this.velocidad = random(1,2);
    this.vx = cos(i)*velocidad;
    this.vy = sin(i)*velocidad;
      
  }
  
  public void mostrar(){
    for(int i=0; i<5; i++){  
      color c = Fondo.get(int(x),int(y));
      fill(red(c) * brillo, green(c) * brillo, blue(c) * brillo, 25);
      noStroke();
  
      ellipse(x, y, i-(i/2), i-(i/2));  
    }
  }
   
  public void mover(){
    x = x + vx;
    y = y + vy;
    
    if(y<0){
      y = height;
    }
    
    if(y>height){
      y = 0;
    }
    
    if(x<0){
      x = width;
    }
    
    if(x>width){
      x = 0;
    }
  } 
  
  void ajustarBrillo(float cambio) {
    brillo += cambio;
    brillo = constrain(brillo, 0.0, 2.0);
  }
      
}

//-------------------INTERACTIVIDAD---------------//
void keyPressed() {
  if (keyCode == 32 ) {
    MCometa.play();
    cometas.add(new Cometa(colorCometa));
  }
  
  else if (key == 'r' || key == 'R') {
    colorCometa = color(255, 0, 0);
      for (Cometa cometa : cometas) {
        cometa.setColor(colorCometa);
      }
  }
  
  else if (key == 'g' || key == 'G') {
    colorCometa = color(0, 255, 0);
      for (Cometa cometa : cometas) {
        cometa.setColor(colorCometa);
      }
  } 
  
  else if (key == 'b' || key == 'B') {
    colorCometa = color(0, 0, 255);
    for (Cometa cometa : cometas) {
      cometa.setColor(colorCometa);
    }
  }
  
  else if (key == 'a' || key == 'A') {
    colorCometa = color(255, 255, 0);
      for (Cometa cometa : cometas) {
        cometa.setColor(colorCometa);
      }
    }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  float cambioBrillo = 0.1; // Cantidad de cambio en el brillo por rueda

  for (Particulas p : particulas) {
    p.ajustarBrillo(e * cambioBrillo);
  }
}
