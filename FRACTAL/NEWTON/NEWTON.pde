//=============================
ArrayList <Complex> roots = new ArrayList<Complex>();

int Niterations = 70;
int deg = 3;

double size = 2.0;
double e = 0.000001;

boolean ok = true;
boolean sol_1 = false;

boolean[] sols = new boolean[deg];

Complex center = new Complex();

Complex z = new Complex();
Complex z_ = new Complex();

Complex c1 = new Complex();
Complex c2 = new Complex();

Complex f_z = new Complex();
Complex f_z_dz = new Complex();

double xmin = -1.0; 
double xmax = 1.0; 
double ymin = -1.0; 
double ymax = 1.0;
double zmin = -1.0; 
double zmax = 1.0;

//=============================

boolean is_converge(float x , float y , double e){
  
  boolean conv = false;
  
  if(( y - e <= x ) && ( x <= y + e) ){
    conv = true;
  }
  return conv;
}

Complex compute_fonction(Complex z , int deg){
  
  Complex z_1 = new Complex(1,0);
  
  for(int i = 0 ; i < deg ; i++){
    z_1 = z_1.mult(z);
  }
  return(z_1);
}

Complex compute_derive(Complex z , int deg){
  
  Complex z_1 = new Complex(1,0);
  Complex complex_deg = new Complex(deg,0);
  
  for(int i = 0 ; i < deg-1 ; i++){
    z_1 = z_1.mult(z);
  }
  
  z_1 = z_1.mult(complex_deg);
  return(z_1);
}

void setup() {

  size(850 , 850);
  background(255);
  
  center.real = 0.0;
  center.img = 0.0;
  
  roots = z.sqrt_complex_1(deg);
    
  c1.real = -1.0;
  c1.img = 0.0;
  
  c2.real = 3.0;
  c2.img = 0.0; 
  
}

void draw() {
  
  if(ok){
    
    xmin = center.real - size / 2.0;
    xmax = center.real + size / 2.0;
    ymin = center.img - size / 2.0;
    ymax = center.img + size / 2.0;
  
    for (int i = 0 ; i < width ; i++) {
      double x = xmin + ( xmax - xmin ) * (double)i / width;
  
      for (int j = 0 ; j < height ; j++ ) {
        double y = ymin + ( ymax - ymin ) * (double)j / height;
  
        z.real = x;
        z.img = y;
        
        int k  = 0;
        
        do{
          
          f_z = compute_fonction(z , deg);
          f_z = f_z.add(c1);
          
          f_z_dz = compute_derive(z , deg);
          
          z = z.sub(f_z.div(f_z_dz));
          k++;
          
          for(int m = 0 ; m < deg ; m++){
            Complex z_i = roots.get(m);
            sols[m] = is_converge((float)z.real , (float)z_i.real , e) && is_converge((float)z.img , (float)z_i.img , e);
          }
          
          for(int l = 0 ; l < deg ; l++){
            if(sols[l] == true){
              sol_1 = sols[l];
            }
          }
          
        }while(k < Niterations && !sol_1);
        
        sol_1 = false;
        
        float k_min = 0.0f;
        float k_max = Niterations;
        
        float color_min = 50;
        float color_max = 255;
        
        float r = (float)(k - k_min) / (k_max - k_min);
        float level = color_min + (color_max - color_min) * (r);
       
       int rep = 0;
       
       for(int m = 0 ; m < deg ; m++){
         
         boolean sol_i = sols[m];
         
         if(sol_i){
           
           if(m == 0){
             set(i,j,color(level , 0 , 0)); 
           }
           else if(m == 1){
             set(i,j,color(0 , level , 0));
           }
           else if(m == 2){
             set(i,j,color(0 , 0 , level));
           }
           else if(m == 3){
             set(i,j,color(level , level , 0));
           }
           else if(m == 4){
             set(i,j,color(level / 2 , 0 , level/2));
           }
           else if(m == 5){
             set(i,j,color(level  , level / 2 , level));
           }
           else if(m == 6){
             set(i,j,color(level / 3 , level/2 , level / 2));
           }
           else if(m == 7){
             set(i,j,color(level / 3 , level / 3, level / 3));
           }
           else if(m == 8){
             set(i,j,color(level / 4 , level / 8 , level));
           }
           else if(m == 9){
             set(i,j,color((level + 10) / 2 , level / 5 , level));
           }
           rep = 1;
         }
       }
       
       if(rep == 0){
          set(i,j,color(255 , 255 , 255));
       }
      }
    }
    ok = false;
  }
}

void mousePressed() {

  if ( mouseButton == LEFT ) {

    center.real = xmin + ( xmax - xmin ) * (double)mouseX / 1000.0;
    center.img = ymin + ( ymax - ymin ) * (double)mouseY / 1000.0;

    size *= 0.5;
    ok = true;
  } else if ( mouseButton == RIGHT ) {

    center.real = xmin + ( xmax - xmin ) * (double)mouseX / 1000.0;
    center.img = ymin + ( ymax - ymin ) * (double)mouseY / 1000.0;

    size *= 1.1;
    ok = true;
  }
}
