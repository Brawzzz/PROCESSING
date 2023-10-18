import peasy.*;
PeasyCam cam;

/////////
PShape globe;
PShape terre;
PShape lune;
PShape jupiter;
PShape mars;
////////

/////
PImage sun;
PImage Terre;
PImage Lune;
PImage starfield;
PImage Jupiter;
PImage Mars;
////

boolean ok = true;

//////
PVector u;
PVector v;
PVector r;
PVector k;
PVector w;
//////

float rx;
float rx1;
float rx2;

float rx_T;
float rx_L;
float rx_J;
float rx_M;


void setup(){
  size(1000,1000,P3D);
  
  sun = loadImage("sun.jpg");
  Terre = loadImage("Terre.jpg");
  Lune = loadImage("Lune.jpg");
  starfield = loadImage("starfield.png");
  Jupiter = loadImage("Jupiter.jpg");
  Mars = loadImage("Mars.jpg");
  
  cam = new PeasyCam(this,width/2);
  
  noStroke();
  globe = createShape(SPHERE,700); 
  
  noStroke();
  terre = createShape(SPHERE,100);
  
  noStroke();
  lune = createShape(SPHERE,30); 
  
  noStroke();
  jupiter = createShape(SPHERE,200); 
  
  noStroke();
  mars = createShape(SPHERE,100); 
  
  u = new PVector(0,100,0);
  v = new PVector(300,0,500);
  r = new PVector(100,0,0);
  k = new PVector(-1500,-100,0);
  w = new PVector(1200,0,0);
  
  
}


void draw(){
  
  background(starfield);
  ok = false;
  
  if (!ok){
    rx += 0.01;
    rx1 += 0.02;
    rx2 -= 0.001;
    
    rx_T += 0.05;
    rx_L += 0.1;
    rx_J += 0.03;
    rx_M += 0.05;
  }
  
  globe.setTexture(sun); 
  rotate(rx,u.x,u.y,u.z);
  shape(globe);
  
  pushMatrix();
  
  rotate(rx1,u.x,u.y,u.z);
  
  translate(v.x*3,v.y*3,v.z*3);
  terre.setTexture(Terre); 
  rotate(rx_T,u.x,u.y,u.z); 
  shape(terre);
    
  translate(r.x*3,r.y*3,r.z*3);
  lune.setTexture(Lune);
  rotate(rx_L,u.x,u.y,u.z);
  shape(lune);
 
  popMatrix();

  pushMatrix();
  
  rotate(rx2,u.x,u.y,u.z);
  
  translate(k.x*2,k.y*2,k.z*2);
  jupiter.setTexture(Jupiter);
  rotate(rx_J,u.x,u.y,u.z);
  //rotateX(0.2);
  shape(jupiter);
  
  popMatrix();
  
  pushMatrix();
  
  translate(w.x*2,w.y*2,w.z*2);
  mars.setTexture(Mars);
  rotate(rx_M,u.x,u.y,u.z);
  shape(mars);
  
  popMatrix();
  
  
  
  
  
  
  /*
  stroke(255);
  line(0,0,0,v.x,v.y,v.z);
  
     stroke(255,0,0);
   line(0,0,0,w.x,w.y,w.z);
   
   stroke(255);
   line(0,0,0,u2.x,u2.y,u2.z);
   
   PVector u2;
   PVector w;
   
   u2 = new PVector(0.3,200,0);
   w = v.cross(u2);
   
   rotate(PI/3,u2.x,u2.y,u2.z);
  */
  
  
}
