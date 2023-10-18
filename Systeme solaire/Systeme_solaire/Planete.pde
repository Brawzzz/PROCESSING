class Planete{
  
  float rayon;
  float distance;
  float angle;
  PVector u;
  PShape globe;
  
  float orbitspeed;
  Planete[] planets;
   
  Planete(float r , float d , float o, PImage img ){
   
    u = PVector.random3D();
    rayon = r; 
    distance = d;
    angle = random(TWO_PI);
    u.mult(distance);
    orbitspeed = o;
    
    noStroke();
    globe = createShape(SPHERE,rayon);
    globe.setTexture(img);
  }
  
  
  void createGlobe(int total , int lvl){
    
    planets = new Planete[total];
    
    for(int i = 0 ; i < planets.length ; i++){    
      float r = rayon/(lvl*2);
      float d = ((rayon + r) + random(500,1000))/(lvl*2) ;
      float o = random(-0.005 , 0.05);
      int ind = int(random(texture.length));
      planets[i] = new Planete(r, d , o , texture[ind]);
      
     
      if (lvl < 2){
        int number = int(random(1,3));
        planets[i].createGlobe(number, lvl+1);   
        
      }
    }
  }
  
    void orbit(){
     angle = angle + orbitspeed;
     if(planets != null){ 
       for(int i = 0 ; i < planets.length ; i++){
         planets[i].orbit();
       } 
     }
   }
  
  void show(){
    
   pushMatrix();
   
   PVector u2 = new PVector(0,0,1); 
   PVector p = u.cross(u2);
   
   rotate(angle,p.x,p.y,p.z);
   
     
   
   //dessine la shepre au bout du vecteur
   translate(u.x,u.y,u.z);
   noStroke();
   fill(255);
   shape(globe);
   
   //sphere(rayon);
 
   if(planets != null){ 
     for(int i = 0; i < planets.length;i++){
       planets[i].show();
    }
   }
   popMatrix();
  } 
 }
 
 
 /*
  rotate(angle,p1.x,p1.y,p1.z);
   
   stroke(255);
   strokeWeight(1);
   line(0,0,0,u.x*10,u.y*10,u.z*10);
   
   
   stroke(0,0,255);
   strokeWeight(1);
   line(0 , 0 , 0 , u2.x*10 , u2.y*10 , u2.z*10);
    
    
   stroke(255,0,0);
   strokeWeight(1);
   line(0,0,0,p.x*10,p.y*10,p.z*10);
 
 */
 
 
