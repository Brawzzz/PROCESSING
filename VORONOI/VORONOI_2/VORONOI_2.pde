//======================================
// The closer the pixels are to a point, 
// the darker they are
//======================================
ArrayList <PVector> points = new ArrayList();

PVector this_point = new PVector();

int nmb_points = 10;
int index = 0;
int circle_size = 10;

float k = 50;

float dist_min = 0;
float dist_max = 0;

float c_min = 0;
float c_max = 255;

color c = color(255,255,255);

boolean ok = true;
boolean over_point = false;
boolean locked = false;
//======================================

void show_points(PVector p , color c1 , color c2 ){
  stroke(c2);
  fill(c);
  circle(p.x , p.y , circle_size);
}

float compute_distance(PVector p1, PVector p2){
  float distance = sqrt((p1.x - p2.x) * (p1.x  - p2.x) + (p1.y - p2.y) * (p1.y - p2.y));
  return distance;
}

ArrayList <PVector> place_random_points(){
  
  for(int i = 0 ; i < nmb_points ; i++){
    
    PVector p = new PVector();
    
    p.x = random(0 , width);
    p.y = random(0 , height);
   
    points.add(p);
    
  }
  return points;
}

void make_voronoi(){
  
  dist_max = sqrt(width*width + height*height);
  dist_max /= 2;
  
  for(int i = 0 ; i < width ; i++){
    for(int j = 0 ; j < height ; j++){
      
      PVector p_ij = new PVector(i , j);
      dist_min = dist_max;
 
      for(PVector p : points){
        float distance = compute_distance(p_ij , p);
        if(distance < dist_min){
          dist_min = distance;
        }
      }
      
      float r = dist_min / dist_max;
      float level = c_min + ((c_max - c_min) * (r)); 
  
      set(i , j , color(level));
    
    }
  }

  for(PVector p : points){
    show_points(p , c , c); 
  } 
}

void move_voronoi(int index){
  
  PVector speed = new PVector(random(-1.f , 1.f) , random(-1.f , 1.f));
  
  points.get(index).x += speed.x;
  points.get(index).y += speed.y;
  
  println(index);
  show_points(points.get(index) , color(255) , color(255 , 0 , 0));
}

void setup(){
  
  size(800,800);
  background(255);
  
  points = place_random_points();
  
  index = (int)random(0,points.size()-1);
  
  
  
}

void draw(){
  background(255);
  
  PVector speed = new PVector(random(-6.f , 6.f) , random(0.f , 0.f));
  
  points.get(index).x += speed.x;
  points.get(index).y += speed.y;
  
  make_voronoi();
}

void mousePressed(){
  
  if(mouseButton == LEFT){
    
    for(PVector p : points){
      if(mouseX > p.x - circle_size && mouseX < p.x + circle_size && mouseY > p.y - circle_size && mouseY < p.y + circle_size){
        over_point = true;  
        show_points(p , color(255) , color(255 , 0 , 0));
        this_point = p; 
      } 
    }
    
    if(over_point){ 
      locked = true; 
    } 
    else{
      locked = false;
    }
  }
  
  else if(mouseButton == RIGHT){
   PVector p = new PVector(mouseX , mouseY);
   points.add(p);
  }
}

void mouseDragged() {
  if(locked){
    this_point.x = mouseX; 
    this_point.y = mouseY; 
  }
}

void mouseReleased() {
  locked = false;
}
