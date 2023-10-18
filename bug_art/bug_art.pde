final int offset = 0;
  
void draw_rain(PVector pos , int rain_lenth , int rain_width , color rain_color){
  
  for(int i = 0 ; i < rain_width ; i++){ 
    for(int j = 0 ; j < rain_lenth ; j++){ 
      set(int(pos.x + i) , int(pos.y + j) , rain_color);
    }
  }
}

void setup(){
  size(650 , 900);
}

void draw(){
  background(0);
  
  final int nmb_drop = int(random(100 , 200));
  final int rain_lenth = int(random(15 , 100));
  final int rain_width = int(random(1 , 3));
    
  for(int i = 0 ; i < nmb_drop ; i++){ 
    PVector pos = new PVector(random(offset , width - offset) , random(offset , height - offset)); 

    draw_rain(pos , rain_lenth , rain_width , color(random(150 , 255)));
  }
  
  delay(75);
}
