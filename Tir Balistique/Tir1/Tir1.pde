float V0 = 100; // m/s
float Xa = 730; // m
float Za = 200; // m

float g = 9.81;

float a;
float Ca;
float Sa;

int xo = 100;
int yo = 500;

//============
void setup() {
 
  float U = 2 * Xa;
  float V = 2 * Za;
  float W = g * Xa * Xa;

  float A = V * V + U * U;
  float B = 2 * V * W - U * U * V0 * V0;
  float C = W * W;

  float delta = B * B - 4 * A * C;
  float X = ( -B + sqrt(delta) ) / ( 2 * A );
  //float a = acos( sqrt(X) / V0 ) * 180.0 / PI;
  
  float X1 = (Xa * Xa * (V0 * V0 - g * Za + sqrt(V0 * V0 * V0 * V0 - g * ( g * Xa * Xa + 2 * Za * V0 * V0 )))) / ( 2 * ( Xa * Xa + Za * Za ) * V0 * V0 );
  float a = acos( sqrt(X1) ) * 180.0 / PI;
  println(a);
  
  Ca = V0 * cos(a*PI/180.);
  Sa = V0 * sin(a*PI/180.);
  
  size(1000, 1000);
  background(255,255,255);
}

void draw() {
  
  translate(xo,yo);
  
  line(0,0,Xa,0);
  
  circle(0,0,5);
  circle(Xa,-Za,5);
  fill(0);
  
  float z;
  for(int x = 0 ; x < Xa ; x++){
    
    z = x * ( Sa/Ca - x * g/(2*Ca*Ca) ); 
    circle(x,-z,1);
  }
}
