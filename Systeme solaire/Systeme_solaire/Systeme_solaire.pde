import peasy.*;

PImage sunTexture;
PImage[] texture = new PImage[3];
PImage picture;
PImage Lune;

Planete sun;
PeasyCam cam;


void setup(){
  size(1000,1000,P3D);
  
  sunTexture = loadImage("sun.jpg");
  picture = loadImage("starfield.png");
  Lune = loadImage("Lune.jpg");
  texture[0] = loadImage("Terre.jpg");
  texture[1]= loadImage("mars.jpg");
  texture[2] = loadImage("mercure.jpg");
  
  cam = new PeasyCam(this, width/2);
  sun = new Planete(150,0,0,sunTexture);
  sun.createGlobe(3,1);
  
  
}


void draw(){
  background(picture);
  //translate(width/2 , height/2);
  lights();
  //pointLight(255,255,255,0,0,0);
  sun.show();
  sun.orbit();
  
  
}
