Particule current;

ArrayList<Particule> flocon;

void setup(){
  //size(1000,1000);
  fullScreen();
  
  current = new Particule (width/2, random(10));
  flocon = new ArrayList<Particule>();
}

void draw(){
  translate(width/2, height/2);
  rotate(PI/6);
  background(0);
  current.update(); 

  while(!current.finished() && !current.touched(flocon)){
      current.update();
        } 
     
  //if(current.finished() || current.touched(flocon)){

    flocon.add(current);
    current = new Particule (width/2, 0); 
  
  //}
 
    for( int i = 0 ; i < 6; i++){
      rotate(PI/3);
  
    current.show();
    for( Particule p : flocon ){
      p.show();
    }
    
    pushMatrix();
    
    scale(1,-1);
    current.show();
     for( Particule p : flocon ){
       p.show();
    }
    popMatrix();
  }
}
