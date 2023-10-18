float r = 300;
double pi = 0;

ArrayList<PVector> points_in = new ArrayList();
ArrayList<PVector> points_out = new ArrayList();

boolean is_in_circle(double rayon , PVector p){

    boolean ok = false;

    if(((double)p.x * (double)p.x + (double)p.y * (double)p.y) <= rayon * rayon){
        ok = true;
    }
    return ok;
}

void show(PVector p , color c){
  fill(c);
  stroke(c);
  circle(p.x , p.y , 1);
}

void setup(){
  
  size(800 , 800);
  background(255);
  
  translate(width/2 , height/2);
  
  noFill();
  stroke(0);
  
  square(-r , -r , 2*r);
  circle(0,0,2*r);
  
}

void draw(){
  
  translate(width/2 , height/2);
  
  for (int i = 0 ; i < 500 ; i++){
  
    PVector p = new PVector(random(-r , r) , random(-r , r));
  
    if(is_in_circle(r , p)){
        points_in.add(p);
    }
    else{
        points_out.add(p);
    }
    int total = points_in.size() + points_out.size(); 
    pi = ((double)points_in.size() / total)*4.0; 
  }
  
  println(pi);
  
  for(PVector p : points_in){
   show(p , color(255 , 0 , 0)); 
  }
  for(PVector p : points_out){
   show(p , color(0 , 0 , 255)); 
  }
}
