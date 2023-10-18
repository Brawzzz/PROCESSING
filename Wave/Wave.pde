float time = 0.0f; //<>//
float P1 = 0.0f;

void make_wave(){
  
  time = millis();
  time /= 1000;

  float w = 1;

  for(float i = 0.5 ; i < 8 ; i += 0.1){
    
    float x = i;
    float x1 = x * 100;
    float y = sin(w * x - time)*100;
    
    float u1 = (sin(w * x + time)+1)/2;
    float level = u1 * 255;
    
    stroke(0);
    fill(255); // fill(level) or fill(255)
    circle(x1 , y , 5);
    
    P1 += PI/2;
  }

}

void setup(){
  size(850 , 850);
  
}

void draw(){
 
  background(0);
  
  translate(0,height/4);
  
  make_wave();
  
  translate(0,height/4);
  
  make_wave();
}
