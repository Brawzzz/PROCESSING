//========================= CONSTANT =========================//
float g = 9.81;

//========================= VARIABLES =========================//
float m1 = 10.f;
float m2 = 10.f;

float x1 = 0.f;
float y1 = 0.f;
float x2 = 0.f;
float y2 = 0.f;

float r1 = 200.f;
float r2 = 200.f;

float a1 = PI / 4;
float a2 = 0.f;

float a1_v = 0.f;
float a2_v = 0.f;

float a1_a = 0.f;
float a2_a = 0.f;

//========================= CALCULUS VARIABLES =========================//
float denominator = 0.f;
float numerator = 0.f;

float elmt_0 = 0.f;
float elmt_1 = 0.f;
float elmt_2 = 0.f;

float elmt_3 = 0.f;
float elmt_4 = 0.f;
float elmt_5 = 0.f;

float A = 0.F;
float B = 0.F;
float C = 0.F;
float D = 0.F;
float E = 0.F;

//========================= MAIN =========================//
void setup(){
  size(850 , 850);
}

void draw(){
  
  background(255);
  stroke(0);
  fill(0);
  
  translate(width/2 , 100);
  
  line(0 , 0 , x1 , y1); 
  
  circle(x1 , y1 , 2 * m1);
  circle(x2 , y2 , 2 * m2);
  
  strokeWeight(1);
  line(x1 , y1 , x2 , y2);
  
  elmt_0 = sin(a1);
  elmt_1 = sin(a2);
  elmt_2 = sin(a2 - a1);
  
  elmt_3 = cos(a1);
  elmt_4 = cos(a2);
  elmt_5 = cos(a2 - a1);
  
  A = r2 * ( m1 + r2 * m2 * cos(2 * a1) - elmt_5 * elmt_5 );
  B = ( m1 + m2 ) * elmt_0 * g;
  C = r2 * m2 * ( a2_v * a2_v * elmt_2 - r1 * a1_v * a1_v * sin(2 * a1) );
  D = a1_v * a1_v * elmt_2;
  E = m1 + r2 * m2 * cos(2 * a1);
  
  a2_a = (1 / A) * (elmt_5 * (B + C + D) + elmt_1 * g * E);
  a2_v += a2_a;
  a2 += a2_v;
  
  A = r1 * ( m1 + r2 * m2 * cos(2 * a1) + m2 * elmt_5 * elmt_5 );
  B = (m1 + m2) * elmt_0 * g;
  C = elmt_5 * ( elmt_0 * g - r1 * a1_v * a1_v * elmt_2 ); 
  D = r2 * a2_v * a2_v * elmt_2;
  E = r1 * r2 * a1_v * a1_v * sin(2 * a1);
  
  a1_a = (1 / A) * (B + m2 * ( C + D - E ));
  a1_v += a1_a;
  a1 += a1_v;
  
  x1 = r1 * sin(a1);
  y1 = 1 - (r1 * cos(a1));
  
  x2 = x1 + r2 * sin(a2);
  y2 = y1 + r2 * cos(a2);
  

}
