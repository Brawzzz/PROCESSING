int n = 1; 
float x = 500;
float y = 500;
float z = 10;

void Triangle(float x1, float y1, float x2, float y2, float x3, float y3, int n) {
  if( n > 0){ 
    fill(255/n , 255/n , 255/n);
    triangle(x1 , y1 , x2 , y2 , x3 ,y3);
 
  
  
    float x4 = (x1+x2)/2.0;
    float y4 = (y1+y2)/2.0;
    float x5 = (x2+x3)/2.0;
    float y5 = (y2+y3)/2.0;
    float x6 = (x3+x1)/2.0;
    float y6 = (y3+y1)/2.0;

      
    Triangle(x1, y1, x4, y4, x6, y6, n-1);
    Triangle(x4, y4, x2, y2, x5, y5, n-1);
    Triangle(x6, y6, x5, y5, x3, y3, n-1);
    
  }
}
  
void setup(){
  
  size(1000,1000);
  background(255,255,255); 
}

  
void draw(){

  noStroke(); 
  translate(x , y);
  scale(z);
  
    
  float x1 = 0.;
  float y1 = -43.;
  float x2 = -50.;
  float y2 = 43;
  float x3 = 50;
  float y3 = 43;

  Triangle(x1, y1, x2, y2, x3, y3, n);
  
}

void mousePressed(){
  
 if(mousePressed && mouseButton == LEFT){
   n += 1;
 }
 
  else if(mousePressed && mouseButton == RIGHT){ 
   n -= 1;
 }
}
