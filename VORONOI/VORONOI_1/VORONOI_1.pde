//====================================== //<>//
// We draw a grid on the sheet with square of size size
// Then we plot a line between the center of each square 
// and the closest point. The smoler the size of the 
// square the more accurate 
//======================================
ArrayList <Box> boxes = new ArrayList();
ArrayList <PVector> points = new ArrayList();

int nmb_box = 0;
int nmb_points = 20;

float size = 10; // 2 , 5 , 10
float k = 50;
float dist_min = 0;
float dist_max = 0;

color white = color(255,255,255);
//======================================

void show_points(PVector p){
  fill(255, 255 , 255);
  circle(p.x , p.y , 10);
}

float compute_distance(Box b , PVector p){
  float distance = sqrt(((b.x + size/2) - p.x) * ((b.x + size/2) - p.x) + ((b.y + size/2) - p.y) * ((b.y + size/2) - p.y));
  return distance;
}

ArrayList <PVector> place_random_points(){
  
  ArrayList <PVector> points = new ArrayList();
  
  for(int i = 0 ; i < nmb_points ; i++){
    
    PVector p = new PVector();
    
    p.x = random(k , width-k);
    p.y = random(k , height-k);
    
    points.add(p);
  }
  return points;
}

ArrayList <Box> make_grid(){  
  
  ArrayList <Box> boxes = new ArrayList();
  
  for(int i = 0 ; i < nmb_box ; i++){ 
    for(int j = 0 ; j < nmb_box ; j++){ 
      Box b = new Box();
      b = b.make_box(i*size , j*size , size , white);
      boxes.add(b);
    }
  }
  return boxes;
}

void setup(){
  
  size(800,800);
  background(0);
  
  dist_max = sqrt(width*width + height*height);
  dist_max /= 2;
  
  points = place_random_points();
 
  nmb_box = width / (int)size;
  
  boxes = make_grid();
  
  PVector ref = new PVector();
  
  for(Box b : boxes){
    dist_min = dist_max;
    for(PVector p : points){
      
      float distance = compute_distance(b , p);
      
      if(distance < dist_min){
        dist_min = distance;
        ref = p;
      }
    }
    
    float r = dist_min / dist_max;
    float level = 255 * (r); 
    
    stroke(level);
    line((b.x + size/2) , (b.y + size/2) , ref.x , ref.y);
  }
  
  for(PVector p : points){
    show_points(p); 
  }
}

void draw(){
  

}
