import peasy.*;
PeasyCam cam;

boolean ok ;
float ry;
int n = 5;
int C = 255;

float x1 , y1 , z1;
float x2 , y2 , z2;
float x3 , y3 , z3;
float x4 , y4 , z4;
float x5 , y5 , z5;
float x6 , y6 , z6;
float x7 , y7 , z7;
float x8 , y8 , z8;
float x9 , y9 , z9;
float x10 , y10 , z10;
float x11 , y11 , z11;
float x12 , y12 , z12;
float x13 , y13 , z13;
float x14 , y14 , z14;

////////////////////////////////
void build(float x1 , float y1 , float z1 , float x2 , float y2 , float z2 , float x3 , float y3 , float z3 , float x4 , float y4 , float z4 , float x5 , float y5 , float z5 ){
  
    pushMatrix();
    
    beginShape(TRIANGLES);
    
    fill(C);
    stroke(0);
    
    //face 1
    vertex(x1, y1, z1);
    vertex(x5, y5, z5);
    vertex(x4, y4, z4 );
    
    fill(C);
    stroke(0);
    
    //face 2
    vertex(x1, y1, z1);
    vertex(x5, y5, z5);
    vertex(x2, y2, z2 );
    
    fill(C);
    stroke(0);
    
    //face 3
    vertex(x2, y2, z2 );
    vertex(x5, y5, z5);
    vertex(x3, y3, z3 );
    
    fill(C);
    stroke(0);
    
    //face 4
    vertex(x4, y4, z4 );
    vertex(x5, y5, z5);
    vertex(x3, y3, z3 );
    
    endShape();
    
    beginShape(QUADS);
  
    fill(C);
    stroke(0);
    
    vertex(x1, y1, z1);
    vertex(x2, y2, z2 );
    vertex(x3, y3, z3 );
    
    endShape();
    
    popMatrix();
}
////////////////////////////////


////////////////////////////////
void Pyramide(float x1 , float y1 , float z1 , float x2 , float y2 , float z2 , float x3 , float y3 , float z3 , float x4 , float y4 , float z4 , float x5 , float y5 , float z5 , int k , int n){
  
 if( k == n){
   build(x1 , y1 , z1 , x4 , y4 , z4 , x3 , y3 , z3 , x2 , y2 , z2 , x5 , y5 , z5);
  }
  
  else{
    
    //petite pyramide en haut 
    x6 = (x1 + x5) / 2;
    y6 = (y1 + y5) / 2;
    z6 = (z1 + z5) / 2;
    
    x7 = (x4 + x5) / 2;
    y7 = (y4 + y5) / 2;
    z7 = (z4 + z5) / 2;
    
    x8 = (x3 + x5) / 2; 
    y8 = (y3 + y5) / 2;
    z8 = (z3 + z5) / 2;
    
    x9 = (x2 + x5) / 2; 
    y9 = (y2 + y5) / 2;
    z9 = (z2 + z5) / 2;
    
    /*BIG SOMMET
    x5;
    y5;
    z5;
    */
    
    Pyramide(x6 , y6 , z6 , x7 , y7 , z7 , x8 , y8 , z8 , x9 , y9 , z9 , x5 , y5 , z5 , k+1 , n);
    
    //PYRAMIDE BAS
    
    //PYRAMIDE 1
    x10 = (x1 + x4) / 2; 
    y10 = (y1 + y4) / 2;
    z10 = (z1 + z4) / 2;
    
    /*POINT EXISTANT
    x4 ; 
    y4 ;
    z4 ;
    */
    
    x11 = (x4 + x3) / 2; 
    y11 = (y4 + y3) / 2;
    z11 = (z4 + z3) / 2;
    
    x14 = (x4 + x2) / 2; 
    y14 = (y4 + y2) / 2;
    z14 = (z4 + z2) / 2;
    
    //SOMMET
    x7 = (x4 + x5) / 2;
    y7 = (y4 + y5) / 2;
    z7 = (z4 + z5) / 2;
    
    Pyramide(x10 , y10 , z10 , x4 , y4 , z4 , x11 , y11 , z11 , x14 , y14 , z14 , x7 , y7 , z7 , k+1 , n);
    
    //PYRAMIDE 2
    x11 = (x4 + x3) / 2; 
    y11 = (y4 + y3) / 2;
    z11 = (z4 + z3) / 2;
    
    /*POINT EXISTANT
    x3;
    y3;
    z3;
    */
    
    x12 = (x3 + x2) / 2; 
    y12 = (y3 + y2) / 2;
    z12 = (z3 + z2) / 2;
    
    x14 = (x4 + x2) / 2; 
    y14 = (y4 + y2) / 2;
    z14 = (z4 + z2) / 2;
    
    //SOMMET
    x8 = (x3 + x5) / 2; 
    y8 = (y3 + y5) / 2;
    z8 = (z3 + z5) / 2;
    
    Pyramide(x14 , y14 , z14 , x11 , y11 , z11 , x3 , y3 , z3 , x12 , y12 , z12 , x8 , y8 , z8 , k+1 , n);
    
    //PYRAMIDE 3
    x12 = (x3 + x2) / 2; 
    y12 = (y3 + y2) / 2;
    z12 = (z3 + z2) / 2;
    
    /*POINT EXISTANT
    x2;
    y2;
    z2;
    */
    
    x13 = (x2 + x1) / 2; 
    y13 = (y2 + y1) / 2;
    z13 = (z2 + z1) / 2;
    
    x14 = (x4 + x2) / 2; 
    y14 = (y4 + y2) / 2;
    z14 = (z4 + z2) / 2;
    
    //SOMMET
    x9 = (x2 + x5) / 2; 
    y9 = (y2 + y5) / 2;
    z9 = (z2 + z5) / 2;
    
    Pyramide(x13 , y13 , z13 , x14 , y14 , z14 , x12 , y12 , z12 , x2 , y2 , z2 , x9 , y9 , z9 , k+1 , n);
    
    //PYRAMIDE 4
    x13 = (x2 + x1) / 2; 
    y13 = (y2 + y1) / 2;
    z13 = (z2 + z1) / 2;
    
    /*POINT EXISTANT
    x1;
    y1;
    z1;
    */
    
    x10 = (x1 + x4) / 2; 
    y10 = (y1 + y4) / 2;
    z10 = (z1 + z4) / 2;
    
    x14 = (x4 + x2) / 2; 
    y14 = (y4 + y2) / 2;
    z14 = (z4 + z2) / 2;
    
    //SOMMET
    x6 = (x1 + x5) / 2;
    y6 = (y1 + y5) / 2;
    z6 = (z1 + z5) / 2;
    
    Pyramide(x1 , y1 , z1 , x10 , y10 , z10 , x14 , y14 , z14 , x13 , y13 , z13 , x6 , y6 , z6 , k+1 , n);
  }
}
////////////////////////////////

void setup() {
  
  size(1000, 1000, P3D);
  //cam = new PeasyCam(this,width/2);
  
  x1 = -100;
  y1 = 0;
  z1 = 0;
  
  x2 = -100;
  y2 = 0;
  z2 = -200;
  
  x3 = 100;
  y3 = 0;
  z3 = -200;
  
  x4 = 100;
  y4 = 0;
  z4 = 0;
  
  x5 = 0;
  y5 = -100;
  z5 = -100;

}

void draw(){
  
  background(0);
  translate(width/2 , height/1.5,200);
  
  pushMatrix();
  translate(50,50,0);
  rotateY(ry);
  translate(-50,-50,0);
  
  Pyramide(x1 , y1 , z1 , x4 , y4 , z4 , x3 , y3 , z3 , x2 , y2 , z2 , x5 , y5 , z5 , 1, n);
  ry += 0.01;
  popMatrix();
}
