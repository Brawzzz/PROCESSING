double K = (double)(2.0 / 3.0);
float angle = 0 ;
float theta = 0;

boolean ok = false;

/*//////////////////////////
Click on the left button to see the animation and click
on the right button in order to stop it
You can use the mouse's wheel to increment the angle manualy
*///////////////////////////

void branche(float h){
  
  stroke(255);
  h *= K;
  
  if(h > 5){
    
    pushMatrix();
    
    rotate(angle);
    line(0, 0 , 0 , -h);
    translate(0,-h);
    branche(h);
     
    popMatrix(); 
    
    pushMatrix();
    
    rotate(-angle);
    line(0, 0 , 0 , -h);
    translate(0,-h);
    branche(h);
    
    popMatrix();

  }
}

void setup(){
  //fullScreen();
  size(1000,1000);
  
  stroke(255);
  strokeWeight(2);
  
  theta = 0;
  
}

void draw(){
  
  background(0);
  //angle = radians((mouseX / float(width)) * 90.0); // l'angle depend de la position de la souris
  
  if(ok){
    angle += PI/15;    // l'angle s'incremente automatiquement et attend avec delay
    
    translate(width/2 , height);
    line(0 , 0 , 0 , -height/4);
    translate(0,-height/4);
    branche(height/4);
    
    delay(150);
  }
  else if(!ok){
    
    println(angle);
    
    translate(width/2 , height);
    line(0 , 0 , 0 , -height/4);
    translate(0,-height/4);
    branche(height/4);   
  }
}

void mousePressed(){
  if(mouseButton == LEFT){
    ok = true;
  }
  
  else if(mouseButton == RIGHT){
    ok = false;
 }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e == -1){
    angle += PI/15; 
  }
  else if(e == 1){
    angle -= PI/15;
  }
}
