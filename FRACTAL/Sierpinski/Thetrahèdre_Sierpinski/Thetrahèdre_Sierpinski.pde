import peasy.*;
PeasyCam cam;

boolean ok;

float rx = 0;
float ry = 0;
float rz = 0;
float X , Y;
float Xmax , Xmin;

int n = 4;
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

//////////////////////////////////
void build(float x1 , float y1 , float z1 , float x2 , float y2 , float z2 , float x3 , float y3 , float z3 , float x4 , float y4 , float z4 ){
  
    pushMatrix();
    
    fill(255);
    stroke(255);
    lights();
    
    beginShape(TRIANGLES);
    
    //face 1
    vertex(x1, y1, z1);
    vertex(x2, y2, z2);
    vertex(x3, y3, z3 );    
    
    //face 2
    vertex(x1, y1, z1);
    vertex(x4, y4, z4);
    vertex(x3, y3, z3 );
    
    //face 4
    vertex(x3, y3, z3 );
    vertex(x4, y4, z4);
    vertex(x2, y2, z2 );
    
    //face 3
    vertex(x1, y1, z1);
    vertex(x4, y4, z4);
    vertex(x2, y2, z2 );

    endShape();
    
    popMatrix();
}

void Pyramide(float x1 , float y1 , float z1 , float x2 , float y2 , float z2 , float x3 , float y3 , float z3 , float x4 , float y4 , float z4 , int k , int n){
  
 if( k == n){
   build(x1 , y1 , z1 , x2 , y2 , z2 , x3 , y3 , z3 , x4 , y4 , z4);
  }
  
  else{
    
  //petite pyramide en haut 
    x5 = (x1 + x4) / 2;
    y5 = (y1 + y4) / 2;
    z5 = (z1 + z4) / 2;
    
    x6 = (x2 + x4) / 2;
    y6 = (y2 + y4) / 2;
    z6 = (z2 + z4) / 2;
    
    x7 = (x3 + x4) / 2; 
    y7 = (y3 + y4) / 2;
    z7 = (z3 + z4) / 2;
    
    /*BIG SOMMET
    x4;
    y4;
    z4;
    */

    Pyramide(x5 , y5 , z5 , x6 , y6 , z6 , x7 , y7 , z7 , x4 , y4 , z4 , k+1 , n);
    
    //PYRAMIDE BAS
    
    //PYRAMIDE 1

    /*POINT EXISTANT
    x1 ; 
    y1 ;
    z1 ;
    */
    
    x8 = (x1 + x2) / 2; 
    y8 = (y1 + y2) / 2;
    z8 = (z1 + z2) / 2;
    
    x10 = (x3 + x1) / 2; 
    y10 = (y3 + y1) / 2;
    z10 = (z3 + z1) / 2;
    
    //SOMMET
    x5 = (x4 + x1) / 2;
    y5 = (y4 + y1) / 2;
    z5 = (z4 + z1) / 2;
    
    Pyramide(x1 , y1 , z1 , x8 , y8 , z8 , x10 , y10 , z10 , x5 , y5 , z5 , k+1 , n);
    
    //PYRAMIDE 2
    x8 = (x1 + x2) / 2; 
    y8 = (y1 + y2) / 2;
    z8 = (z1 + z2) / 2;
    
   /*POINT EXISTANT
    x2 ; 
    y2 ;
    z2 ;
    */
    
    x9 = (x2 + x3) / 2; 
    y9 = (y2 + y3) / 2;
    z9 = (z2 + z3) / 2;
    
    //SOMMET
    x6 = (x4 + x2) / 2; 
    y6 = (y4 + y2) / 2;
    z6 = (z4 + z2) / 2;
      
    Pyramide(x8 , y8 , z8 , x2 , y2 , z2 , x9 , y9 , z9 , x6 , y6 , z6 , k+1 , n);
    
    //PYRAMIDE 3
  
    x9 = (x3 + x2) / 2; 
    y9 = (y3 + y2) / 2;
    z9 = (z3 + z2) / 2;
    
    /*POINT EXISTANT
    x3;
    y3;
    z3;
    */
    
    x10 = (x3 + x1) / 2; 
    y10 = (y3 + y1) / 2;
    z10 = (z3 + z1) / 2;
  
    //SOMMET
    x7 = (x4 + x3) / 2; 
    y7 = (y4 + y3) / 2;
    z7 = (z4 + z3) / 2;
    
    Pyramide(x9 , y9 , z9 , x3 , y3 , z3 , x10 , y10 , z10 , x7 , y7 , z7 , k+1 , n);
  }
}

void setup() {
  //fullScreen(P3D);
  size(1000, 1000, P3D);
  ok = false;
  X = 0;
  Y = 0;

 // cam = new PeasyCam(this,2*width);
  
  x1 = 0;
  y1 = 0;
  z1 = 0;
  
  x2 = 200;
  y2 = 0;
  z2 = 0;
  
  x3 = 100;
  y3 = 0;
  z3 = 175;
  
  x4 = 100;
  y4 = -165;
  z4 = 60;

}


void draw(){
  
  translate(width/2,height/2);
  Xmax = 500;
  Xmin = 0;
  background(0);
  scale(1.5);
 
//  translate(X,0,0);
  rotateX(rx);
  rotateY(ry);
  rotateZ(rz);
  
  Pyramide(x1 , y1 , z1 , x2 , y2 , z2 , x3 , y3 , z3 , x4 , y4 , z4 , 0 , n);
  
  rx += 0.012;
  ry += 0.01;
  rz += 0.024;
  X += 2;
    

}
