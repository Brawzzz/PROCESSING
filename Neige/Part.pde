class NEIGE{
  
  PVector location;
  PVector vitesse;
  PVector accell;
  float r;
  
  float life = 255; 
  
  NEIGE(PVector l){
    vitesse  = new PVector(random(-4,4),random(-4,4));
    accell   = new PVector(0,0.1);  
    location = l.copy();
    r = 10;
    
  }
  
  void update(){
    vitesse.add(accell);
    location.add(vitesse); 
    
    life -= 2; 
  }
  
  
    boolean Dead(){
      if( life <= 0){
        return true;
      }
      else{
       return false;        
      }      
    }    
  
  void show(){
    stroke(255, life);
    fill(255,life);
    ellipse(location.x, location.y, r*2, r*2);
  }
}
