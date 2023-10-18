//============================= //<>//
int Niterations = 0;
int IterationMax = 50;

double conv = 0.05;
double div = 50.0;
double size = 2.0; 

Complex center = new Complex();
//=============================

double xmin; 
double xmax; 
double ymin; 
double ymax;
double zmin; 
double zmax;

boolean ok = true;
boolean go = true;

//
void setup() {
  //fullScreen();
  size(1000, 1000);
  background(0);

  center.real = 0.0;
  center.img = 0.0;
}

void draw() {

  if (!ok) {
    return;
  }
  
  if(go == true){
    Niterations += 1;
  }

  xmin = center.real - size / 2.0;
  xmax = center.real + size / 2.0;
  ymin = center.img - size / 2.0;
  ymax = center.img + size / 2.0;

  Complex z = new Complex();
  Complex c = new Complex();

  for (int i = 0; i < width; i++) {
    double x = xmin + ( xmax - xmin ) * (double)i / 1000.0;

    for (int j = 0; j < height; j++ ) {
      double y = ymin + ( ymax - ymin ) * (double)j / 1000.0;

      z.real = 0.0;
      z.img = 0.0;

      c.real = x;
      c.img = y;

      int k = 0;
      double mod = 1.0;

      do {  
        z = (z.mult(z)).add(c);  
        mod = z.mod();   
        k++;
      } while (( k < Niterations ) && ( mod > conv ) && ( mod < div ));

      if ( mod < conv ) {
        int v = (int)( mod * Niterations / 255 );
        v *= 5;
        
        set (i, j, color(v, v, v));
      }
      else if ( mod > div ) {
        int v = (int)( mod * Niterations / 255 );
        v *= 5;
        
        set (i, j, color(255, 255, 255));
      } 
      else {
        int v = (int)( mod * Niterations / 255 );
        v *= 5;
        
        set (i, j, color(v, v, v));
      }
    }
  }

  println(Niterations + " " + IterationMax );
  
  if (Niterations > IterationMax) {
    go = false;
    ok = false;
  }
}

void mousePressed() {

  if ( mouseButton == LEFT ) {

    center.real = xmin + ( xmax - xmin ) * (double)mouseX / 1000.0;
    center.img = ymin + ( ymax - ymin ) * (double)mouseY / 1000.0;

    size *= 0.6;
    ok = true;
  } else if ( mouseButton == RIGHT ) {

    center.real = xmin + ( xmax - xmin ) * (double)mouseX / 1000.0;
    center.img = ymin + ( ymax - ymin ) * (double)mouseY / 1000.0;

    size *= 1.1;
    ok = true;
  }
}
