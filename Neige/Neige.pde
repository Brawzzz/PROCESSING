ArrayList<NEIGE>flocon;

void setup(){
  
  //size(1000,1000);
  fullScreen();
  flocon = new ArrayList<NEIGE>();

  
}

void draw(){
  
  background(0);
  
  flocon.add(new NEIGE(new PVector(width/2,100)));
  flocon.add(new NEIGE(new PVector(width/3,100)));
  flocon.add(new NEIGE(new PVector(width/1.5,100)));
  flocon.add(new NEIGE(new PVector(width/1.25,100)));
  flocon.add(new NEIGE(new PVector(width/5,100)));
  flocon.add(new NEIGE(new PVector(width/10,100)));
  flocon.add(new NEIGE(new PVector(width/1.10,100)));
  
  for( int i =0 ; i < flocon.size(); i++){  
    NEIGE p = flocon.get(i);
    p.update(); 
    p.show();
    
    
    if(p.Dead()){ 
      flocon.remove(i);   
    }    
  }
}
  
  
  
  
  
  
  
  
  
  
  
    
