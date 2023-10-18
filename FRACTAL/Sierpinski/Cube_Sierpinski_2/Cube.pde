class Cube{
  
  PVector pos;
  float c;
  
  Cube(float x , float y , float z , float c_){
    
    pos = new PVector(x , y , z);
    c = c_;
    
  }
  
  ArrayList<Cube> generate(){
    
    ArrayList<Cube> boxes  = new ArrayList<Cube>();
    
    for(int x = -1; x < 2 ; x++){
      for(int y = -1 ; y < 2 ; y++){
        for(int z = -1 ; z < 2 ; z++){
          
          float C = c / 3 ;
          Cube b = new Cube((x * C) + pos.x , (y * C) + pos.y , (z * C) + pos.z, C);
          
          if( (abs(x) > 0 && abs(y) > 0) || (abs(y) > 0 && abs(z) > 0) || (abs(x) > 0 && abs(z) > 0)){
              boxes.add(b);
          }
          
        }
      }
    }
    return boxes;
  }
  
  void show(){
    
    pushMatrix();
    translate(pos.x , pos.y , pos.z);
    box(c);
    popMatrix();
    
  }
}
