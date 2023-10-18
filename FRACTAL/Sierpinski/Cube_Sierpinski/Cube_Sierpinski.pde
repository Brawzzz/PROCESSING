import peasy.*;
PeasyCam cam;

int n = 0;

float rx;
float ry;
float rz;

float K1 = (1.0 / 3.0);
float K2 = (2.0 / 3.0);

PVector a = new PVector(0 , 100 , 0);
PVector b = new PVector(100 , 100 , 0);
PVector c = new PVector(100 , 100 , -100);
PVector d = new PVector(0 , 100 ,-100);
PVector e = new PVector(0 , 0 , 0);
PVector f = new PVector(100 , 0 , 0);
PVector g = new PVector(100 , 0 , -100);
PVector h = new PVector(0 , 0 , -100);

void build_cube(PVector a , PVector b , PVector c , PVector d , PVector e , PVector f , PVector g , PVector h ){
  
  stroke(255/2);
  //stroke(0 , 150 , 175);
  strokeWeight(2);
  line(a.x , a.y , a.z , b.x , b.y , b.z);
  line(b.x , b.y , b.z , c.x , c.y , c.z);
  line(c.x , c.y , c.z , d.x , d.y , d.z);
  line(d.x , d.y , d.z , a.x , a.y , a.z);
  
  stroke(255/3);
  //stroke(0, 100, 255);
  line(e.x , e.y , e.z , f.x , f.y , f.z);
  line(f.x , f.y , f.z , g.x , g.y , g.z);
  line(g.x , g.y , g.z , h.x , h.y , h.z);
  line(h.x , h.y , h.z , e.x , e.y , e.z);
  
  stroke(255);
  //stroke(0 , 255 , 255);
  line(a.x , a.y , a.z , e.x , e.y , e.z);
  line(b.x , b.y , b.z , f.x , f.y , f.z);
  line(c.x , c.y , c.z , g.x , g.y , g.z);
  line(d.x , d.y , d.z , h.x , h.y , h.z);
}

void Cube(PVector a , PVector b , PVector c , PVector d , PVector e , PVector f , PVector g , PVector h , int k , int n){
  
  if(k == n){
    build_cube(a , b , c , d , e , f , g , h); 
  }
  
  else{
    
    //VECTEUR
    PVector ab  = b.copy().sub(a);
    PVector abK1 = ab.copy().mult(K1);
    PVector abK2 = ab.copy().mult(K2);
    
    PVector bc  = c.copy().sub(b);
    PVector bcK1 = bc.copy().mult(K1);
    PVector bcK2 = bc.copy().mult(K2);
    
    PVector ae = e.copy().sub(a);
    PVector aeK1 = ae.copy().mult(K1);
    PVector aeK2 = ae.copy().mult(K2);
    
    //FACE A
    
    PVector a1 = a.copy().add(abK1);
    PVector a2 = a.copy().add(abK2);
    
    PVector a3 = b.copy().add(bcK1);
    PVector a4 = b.copy().add(bcK2);
   
    PVector a5 = c.copy().sub(abK1);
    PVector a6 = c.copy().sub(abK2);    
   
    PVector a7 = a.copy().add(bcK2);
    PVector a8 = a.copy().add(bcK1);
    
    //FACE B
    
    PVector b1 = e.copy().add(abK1);
    PVector b2 = e.copy().add(abK2);
   
    PVector b3 = f.copy().add(bcK1);
    PVector b4 = f.copy().add(bcK2);
   
    PVector b5 = g.copy().sub(abK1);
    PVector b6 = g.copy().sub(abK2);    
   
    PVector b7 = h.copy().sub(bcK1);
    PVector b8 = h.copy().sub(bcK2);
    
    //ARRETE
    
    PVector c1 = a.copy().add(aeK1);
    PVector c2 = a.copy().add(aeK2);
    
    PVector c3 = b.copy().add(aeK1);
    PVector c4 = b.copy().add(aeK2);
    
    PVector c5 = c.copy().add(aeK1);
    PVector c6 = c.copy().add(aeK2);    
   
    PVector c7 = d.copy().add(aeK1);
    PVector c8 = d.copy().add(aeK2);
    
    //CENTRES DES FACES

    PVector m1 = c2.copy().add(abK1);
    PVector m2 = c1.copy().add(abK1);
    
    PVector m3 = c2.copy().add(abK2);
    PVector m4 = c1.copy().add(abK2);

    PVector M1 = c4.copy().add(bcK1);
    PVector M2 = c3.copy().add(bcK1);
    PVector M3 = c4.copy().add(bcK2);
    PVector M4 = c3.copy().add(bcK2);
    
    PVector i1 = b1.copy().add(bcK1);
    PVector i2 = b1.copy().add(bcK2);
    PVector i3 = b2.copy().add(bcK1);
    PVector i4 = b2.copy().add(bcK2);
    
    PVector I1 = c1.copy().add(bcK1);
    PVector I2 = c2.copy().add(bcK1);
    PVector I3 = c1.copy().add(bcK2);
    PVector I4 = c2.copy().add(bcK2);
    
    PVector o1 = c8.copy().add(abK1);
    PVector o2 = c7.copy().add(abK1);
    PVector o3 = c8.copy().add(abK2);
    PVector o4 = c7.copy().add(abK2);
    
    PVector O1 = a1.copy().add(bcK1);
    PVector O2 = a2.copy().add(bcK1);
    PVector O3 = a1.copy().add(bcK2);
    PVector O4 = a2.copy().add(bcK2);
    
    //CUBE DU CENTRE
    
    PVector X1 = m2.copy().add(bcK1);
    PVector X2 = m4.copy().add(bcK1);
    PVector X3 = m4.copy().add(bcK2);
    PVector X4 = m2.copy().add(bcK2);
    
    PVector X5 = m1.copy().add(bcK1);
    PVector X6 = m3.copy().add(bcK1);
    PVector X7 = m3.copy().add(bcK2);
    PVector X8 = m1.copy().add(bcK2);
    
    Cube(a , a1 , O1 , a8 , c1 , m2 , X1 , I1 , k+1 , n);
    Cube(a1 , a2 , O2 , O1 , m2 , m4 , X2 , X1 , k+1 , n);
    Cube(a2 , b , a3 , O2 , m4 , c3 , M2 , X2 , k+1 , n);
    Cube(O2 , a3 , a4 , O4 , X2 , M2 , M4 , X3 , k+1 , n);
    Cube(O4 , a4 , c , a5 , X3 , M4 , c5 , o4 , k+1 , n);
    Cube(O3 , O4 , a5 , a6 , X4 , X3 , o4 , o2 , k+1 , n);
    Cube(a7 , O3 , a6 , d , I3 , X4 , o2 , c7 , k+1 , n);
    Cube(a8 , O1 , O3 , a7 , I1 , X1 , X4 , I3 , k+1 , n);
    
    Cube(c1 , m2 , X1 , I1 , c2 , m1 , X5 , I2 , k+1 , n);
    Cube(m4 , c3 , M2 , X2 , m3 , c4 , M1 , X6 , k+1 , n);
    Cube(X3 , M4 , c5 , o4 , X7 , M3 , c6 , o3 , k+1 , n);
    Cube(I3 , X4 , o2 , c7 , I4 , X8 , o1 , c8 , k+1 , n);
   
    Cube(c2 , m1 , X5 , I2 , e , b1 , i1 , b8 , k+1 , n);
    Cube(m1 , m3 , X6 , X5 , b1 , b2 , i3 , i1 , k+1 , n);
    Cube(m3 , c4 , M1 , X6 , b2 , f , b3 , i3 , k+1 , n);
    Cube(X6 , M1 , M3 , X7 , i3 , b3 , b4 , i4 , k+1 , n);
    Cube(X7 , M3 , c6 , o3 , i4 , b4 , g , b5 , k+1 , n);
    Cube(X8 , X7 , o3 , o1 , i2 , i4 , b5 , b6 , k+1 , n);
    Cube(I4 , X8 , o1 , c8 , b7 , i2 , b6 , h , k+1 , n);
    Cube(I2 , X5 , X8 , I4 , b8 , i1 , i2 , b7 , k+1 , n);
  } 
}

void setup() {
  
  size(1000, 1000, P3D);
  cam = new PeasyCam(this,width/2);
  
}

void draw(){
  
  background(0);
  
  rotateX(rx);
  rotateY(ry);
  rotateZ(rz);
  
  Cube(a , b , c , d , e , f , g , h , 0 , n);
  
  rx += 0.001;
  ry += 0.015;
  rz += 0.002;

}

void mousePressed(){
  
  if(mouseButton == LEFT){
    n += 1;
    if( n > 3){
      n = 3;
    }
  }
  
  else if(mouseButton == RIGHT){
    n -= 1;
    if( n < 0){
      n = 0;
    }
  }
  
}
