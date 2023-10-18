int iterations_max = 15;
int rest = 0;

float b = 5;
float angle = 0;

double k = 0;
double a = 0;

boolean ok = false;

final double PHI = (1+sqrt(5))/2;

void make_square(float x , float y , float x1 , float y1 , float size){
  
  noFill();
  strokeWeight(1);
  stroke(255);
  rect(x,y,size,size);
  
  strokeWeight(3);
  stroke(255);
  arc(x1,y1,2*size,2*size,PI,3*PI/2);
  
}

void setup() {
  fullScreen(); 
}

void draw() { 
  background(0);
  
  k = (width+height)/3;
  rest = (int)k / 3;
 
  noFill();
  translate(rest/2.5 , rest/8);
  
  for(int i = 0 ; i < iterations_max ; i++){
    make_square(0 , 0 , (float)k , (float)k , (float)k); 
    translate((float)(k*PHI) , 0);
    rotate(PI/2);
    k /= PHI; 
  }
}

void mousePressed(){
  
 if(mousePressed && mouseButton == LEFT){
   iterations_max++;
 }
 
  else if(mousePressed && mouseButton == RIGHT){ 
   iterations_max--;
 }
}
