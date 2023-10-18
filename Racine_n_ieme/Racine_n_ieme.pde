Complex center = new Complex();
Complex z = new Complex();

int n = 3;
int r = 400;

void setup() {
  
  size(1000, 1000);
  background(255,255,255);
  
  z.real = 1.0;
  z.img = 0.0;
  
}

void draw() {
  
  int xo = width/2;
  int yo = height/2;
  
  strokeWeight(3);
  circle(xo , yo , 800); 
  
  strokeWeight(1);
  line(xo, 0, xo, height);
  line(0, yo, width, yo);
  
  ArrayList <Complex> roots = z.sqrt_complex_1(n); 
  
  for( Complex z : roots){
    
    strokeWeight(6);
    
    double x = xo + r * z.real;
    double y = yo - r * z.img;
    
    circle((float)x , (float)y , 10);
    
  }
  
  for( int i = 0 ; i < n ; i++){
    
    Complex z1 = roots.get(i);
    Complex z2 = roots.get((i+1)%n);
    
    stroke(0);
    strokeWeight(2);
    
    float x1 = (float)xo + (float)z1.real * (float)r;
    float y1 = (float)yo - (float)z1.img * (float)r;
    
    float x2 = (float)xo + (float)z2.real * (float)r;
    float y2 = (float)yo - (float)z2.img * (float)r;
    
    line(x1,y1,x2,y2);  

  } 
}

void mousePressed() {
   
  if ( mouseButton == LEFT ) {
    n += 1;
    background(255);
  }
  else if ( mouseButton == RIGHT ) {
     n -= 1;
     if (n < 3 ) {
       n = 3;
     }
     background(255);
  }
  println(n);
}
