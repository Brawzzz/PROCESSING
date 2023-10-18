void Square(PVector u, PVector v, PVector w, PVector z, int n) {
  if( n > 0){ 
    
    stroke(0);
    fill(0);
    line(u.x, u.y, v.x, v.y);
    line(v.x, v.y, w.x, w.y);
    line(w.x, w.y, z.x, z.y);
    line(z.x, z.y, u.x, u.y);
    
    float a = 1.f/3.f;
    float b = 2.f/3.f;
    
    // on copy les vecteurs pour ne pas les utilser changé après
    
    PVector uv = v.copy().sub(u);
    PVector c1 = u.copy().add(uv.copy().mult(a));
    PVector c2 = u.copy().add(uv.copy().mult(b));
    
    PVector vw = w.copy().sub(v);
    PVector c3 = v.copy().add(vw.copy().mult(a));
    PVector c4 = v.copy().add(vw.copy().mult(b));
    
    PVector wz = z.copy().sub(w);
    PVector c5 = w.copy().add(wz.copy().mult(a));
    PVector c6 = w.copy().add(wz.copy().mult(b));    
   
    PVector zu = u.copy().sub(z);
    PVector c7 = z.copy().add(zu.copy().mult(a));
    PVector c8 = z.copy().add(zu.copy().mult(b));
    
    PVector c8c3 = c3.copy().sub(c8);
    PVector c9  = c8.copy().add(c8c3.copy().mult(a));
    PVector c10 = c8.copy().add(c8c3.copy().mult(b));
    
    PVector c7c4 = c4.copy().sub(c7);
    PVector c11 = c7.copy().add(c7c4.copy().mult(b));
    PVector c12 = c7.copy().add(c7c4.copy().mult(a));


    Square( u, c1, c9, c8, n-1);
    Square( c1, c2, c10, c9, n-1); 
    Square( c2, v, c3, c10, n-1);
    Square( c8, c9, c12, c7, n-1);
    Square( c10, c3, c4, c11, n-1);
    Square( c7, c12, c6, z, n-1);
    Square( c12, c11, c5, c6, n-1);
    Square( c11, c4, w, c5, n-1);
  }
}

void setup(){
  //fullScreen();
  //scale(2);
  //translate(-20,-252.5);

  size(1000,1000);
  background(255);
  
  PVector u = new PVector(0,0);
  PVector v = new PVector(width,0);
  PVector w = new PVector(width,height);
  PVector z = new PVector(0,height);
  
  int n = 5;
  Square(u,v,w,z,n);
  
} 
  
void draw(){
  
 
}

//pushMatrix();
//popMatrix();

/*

    PVector uv = v.copy().sub(u);
    PVector c1 = u.copy().add(uv.copy().mult(a));
    PVector c2 = u.copy().add(uv.copy().mult(b));
    
    PVector vw = w.copy().sub(v);
    PVector c3 = v.copy().add(vw.copy().mult(a));
    PVector c4 = v.copy().add(vw.copy().mult(b));
    
    PVector wz = z.copy().sub(w);
    PVector c5 = w.copy().add(wz.copy().mult(a));
    PVector c6 = w.copy().add(wz.copy().mult(b));    
   
    PVector zu = u.copy().sub(z);
    PVector c7 = z.copy().add(zu.copy().mult(a));
    PVector c8 = z.copy().add(zu.copy().mult(b));
    
    PVector c8c3 = c3.copy().sub(c8);
    PVector c9  = c8.copy().add(c8c3.copy().mult(a));
    PVector c10 = c8.copy().add(c8c3.copy().mult(b));
    
    PVector c7c4 = c4.copy().sub(c7);
    PVector c11 = c7.copy().add(c7c4.copy().mult(b));
    PVector c12 = c7.copy().add(c7c4.copy().mult(a));

*/



  
