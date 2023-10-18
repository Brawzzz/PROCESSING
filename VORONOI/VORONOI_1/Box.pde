class Box{
 
  float x;
  float y;
  float size;
  
  color col;
  
  Box make_box(float x , float y , float size , color c){ 
    
    Box b = new Box();
    
    b.x = x;
    b.y = y;
    b.size = size;
    b.col = c;
    
    return b;
  }
  
  void show(Box b){
    noStroke();
    fill(b.col);
    rect(b.x , b.y , b.size , b.size); 
  }
}
