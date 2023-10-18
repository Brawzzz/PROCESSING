class Particule {
  
  PVector p ;
  float r;
 
 Particule(float x , float y){
   p = new PVector(x,y);
   r = 3;
}

  void update(){
    p.x -= 2;
    p.y += random(-3,3); 
    
    float angle = p.heading();
    angle = constrain(angle , 0, PI/6);
    float magnitude = p.mag();
    p = PVector.fromAngle(angle); 
    p.setMag(magnitude);
    
    
  }
  
  void show(){
    stroke(255);
    fill(255);
    ellipse(p.x ,p.y , r*2,r*2);
  }
  
   boolean finished(){
     return (p.x < 2); 
   }
   
   boolean touched(ArrayList<Particule>flocon){
     boolean result = false;
     for ( Particule k : flocon){ 
      float d = dist(k.p.x, k.p.y, p.x, p.y);
      if ( d < r*2){
        result = true;
        break; 
      }  
     }
     return result;      
   }
}
