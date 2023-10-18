float D_min = 1.f;
float D_max = 20.f;
float D = D_min;
float D_inc = 0.1f;

int N_min = 200;
int N_max = 200;
int N = N_min;
int N_inc = 1;

float d_angle = TWO_PI / (float)N;

float cx = 0;
float cy = 0;
float r = 0;

int i = 0;

int color_b = 0;

////////////////////////////////////////////////

void KeyReleased() {
  
  if (key == ESC) {
    exit();
  }
}

void setup() {
  
  size(1000, 1000);
  
  cx = width / 2.f;
  cy = height / 2.f;
  r = height / 2.f - 100;
  
}

void draw() {
  
  background(0); 
  
  N += N_inc;
  D += D_inc;
  
  if ( D < D_min ) {
    D = D_min;
    D_inc *= -1;
    N_inc *= -1;
  }
  else if ( D > D_max) {
    D = D_max;
    D_inc *= -1;
    N_inc *= -1;
  }
  
  d_angle = TWO_PI / (float)N;
  
  //full circle
  stroke(255);
  strokeWeight(1);
  noFill();
  circle(cx,cy,2*r);
 
 // ticks
  stroke(255);
  fill(255);
  for( float angle = 0.f ; angle <= TWO_PI ; angle += d_angle) {
    float x = cx + r * cos(angle);
    float y = cy + r * sin(angle);
    circle(x,y,5);
  }
    
  // lines
  stroke(255);
  strokeWeight(1);
  noFill();

  for( int i = 0 ; i < N ; i++ ) {
  
    float u1 = (float)i;   
    float angle1 = u1 * d_angle;
    float x1 = cx + r * cos(angle1);
    float y1 = cy + r * sin(angle1);
           
    float angle2 = angle1 * D;
    float x2 = cx + r * cos(angle2);
    float y2 = cy + r * sin(angle2);
       
    line(x1,y1,x2,y2);
    
  }
}

void mousePressed() {
  
  /*
  if ( mouseButton == LEFT ) {
   D += 0.1;
  }
  else {
    D -= 1.;
  }
  
  N += 1 ;
  d_angle = TWO_PI / (float)N;
  */
  
  /*
  N_inc *= -1;
  D_inc *= -1.f;
  */
}
