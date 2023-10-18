//=============================
int Niterations = 200;
double conv = 0.2;
double div = 100;
Complex center = new Complex();
double size = 2.0; 
//=============================

double xmin = center.real - size / 2.0;
double xmax = center.real + size / 2.0;
double ymin = center.img - size / 2.0;
double ymax = center.img + size / 2.0;
  
boolean ok = true;

void setup() {
  //fullScreen();
  size(1000, 1000);
  background(255,255,255);
  
  center.real = 0.0;
  center.img = 0.0;
}

void draw() {
  
  if ( ! ok ) {
    return;
  }
  
  xmin = center.real - size / 2.0;
  xmax = center.real + size / 2.0;
  ymin = center.img - size / 2.0;
  ymax = center.img + size / 2.0;
 
  Complex c = new Complex(-0.4 , 0.6);
  
  for (int i = 0 ; i < width ; i++) {
    double z_real = xmin + ( xmax - xmin ) * (double)i / 1000.0;
    
    for (int j = 0 ; j < height ; j++ ) {
      double z_img = ymin + ( ymax - ymin ) * (double)j / 1000.0;
      
      Complex z = new Complex(z_real,z_img);
     
      int k = 0;
      double mod = -1.;
      double scal = 0.;
    
      do {
        
        z = (z.mult(z)).add(c); 
        mod = z.mod();
        k++;
        
      } while ( ( k < Niterations ) && ( mod > conv ) && ( mod < div ) );
     
     if ( mod > div ) {
      int v = (int)( mod * Niterations / 255 );
      // set (i , j , color(v, v, v));  
      set (i , j , color(0, 0, 0));
     }
     
     if ( mod < conv ) {
      int v = (int)(mod * Niterations);
      int C = 240 - v;
      // set (i , j , color(C, C, C));  
      v *= 5;
      set (i , j , color(v, v , v));
     }
     
      else{
        int v = (int)( mod + Niterations / Niterations );
        //set (i , j , color(v, v, v));  
        set (i , j , color(0, 0 ,0));    
      } 
    }  
   }
  ok = false;  
}

void mousePressed() {
   
  if ( mouseButton == LEFT ) {
    
    center.real = xmin + ( xmax - xmin ) * (double)mouseX / 1000.0;
    center.img = ymin + ( ymax - ymin ) * (double)mouseY / 1000.0;
    
    size *= 0.9;
    ok = true;
  }
  else if ( mouseButton == RIGHT ) {
     
    center.real = xmin + ( xmax - xmin ) * (double)mouseX / 1000.0;
    center.img = ymin + ( ymax - ymin ) * (double)mouseY / 1000.0;
    
    size *= 1.1;
    ok = true;
  }
}

  
  
