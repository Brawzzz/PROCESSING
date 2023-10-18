import peasy.*;
PeasyCam cam;

float rx = 0;
float ry = 0;
float rz = 0;

ArrayList<Cube> Big_Box = new ArrayList<Cube>();

void setup(){
  size(1000, 1000,P3D);
  Cube box = new Cube(0 , 0 , 0 , 200);
  Big_Box.add(box); 
  
  cam = new PeasyCam(this,width/2);
}

void mousePressed(){
  if(mouseButton == RIGHT){
    ArrayList<Cube> next = new ArrayList<Cube>();
    
    for(Cube b : Big_Box){
      
      ArrayList<Cube> boxes = b.generate();
      Big_Box = next;
  
      next.addAll(boxes);
    }
  }
}

void draw(){
  background(0);
  
  lights();
  //noFill();
  fill(150 , 150 , 150);
  stroke(100 , 100 , 100);
  
  //translate(width/2 , height/2);
  rotateX(rx);
  rotateY(ry);
  rotateZ(rz);

  
  for(Cube box : Big_Box){
    box.show();
  }
  
  rx += 0.01;
  ry += 0.0012;
  rz += 0.001;
  
}
