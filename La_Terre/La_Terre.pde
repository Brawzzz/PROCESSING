PImage img;
PImage picture;

PShape terre;
PShape sun;

float rx = 0;
float ry = 0;

float rayon1 = 100;
float rayon2 = 300;
boolean ok = true;

void setup() {

  size(1200,1000,P3D);
  background(0);
  img = loadImage("Terre.jpg");
  picture = loadImage("sun.jpg");
  
}

void draw() {
  
  ok = false;
  
  terre = createShape(SPHERE,rayon1);
  terre.setTexture(img);
  
  sun = createShape(SPHERE,rayon2);
  sun.setTexture(picture);
  
    //float r = (float)mouseX / (float)width;
    //rx = -PI + r * (PI-(-PI));
    //rx = map(mouseX, 0, width, -PI, PI);
    //ry = map(mouseY, 0, height, PI, -PI);
    noStroke();
    fill(255);
    
    
    
    if(!ok){
      rx += 0.03;
      ry += 0.01;
    }
    
    pushMatrix();
    
    translate(width-200,height/2);
    rotateX(-0.8); 
    rotateY(rx);
    shape(terre);
    
    popMatrix();
    
    
    pushMatrix();
    
    translate(500,height/2);
    rotateX(-0.8);
    rotateY(ry);
    shape(sun);
      
    popMatrix();   
 
}
  
