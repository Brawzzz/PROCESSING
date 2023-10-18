import processing.video.*;
//======================================
ArrayList <PVector> points = new ArrayList();
ArrayList <PVector> caracteristics_points = new ArrayList();

ArrayList <Point> stream = new ArrayList();

Capture cam;

int nmb_points = 1300;

float k = 50;

float dist_min = 0;
float dist_max = 0;

float c_min = 0;
float c_max = 255;

color c = color(255,255,255);
boolean ok = true;
//======================================

void show_points(PVector p){
  fill(255, 255 , 255);
  circle(p.x , p.y , 10);
}

float compute_distance(PVector p1, PVector p2){
  float distance = sqrt((p1.x - p2.x) * (p1.x  - p2.x) + (p1.y - p2.y) * (p1.y - p2.y));
  return distance;
}

ArrayList <Point> place_random_points(){
  
  for(int i = 0 ; i < nmb_points ; i++){
    
    PVector p_ = new PVector();
    
    p_.x = random(0 , width);
    p_.y = random(0 , height);
    
    int index = (int)p_.x + (int)p_.y * width;
    color c = color(cam.pixels[index]);
    
    Point p = new Point(p_ , c);
    stream.add(p);
    
  }
  return stream;
}

ArrayList <PVector> fill_caracteristics_points(){
  
  ArrayList <PVector> caracteristics_points = new ArrayList();
  
  for(int i = 0 ; i < nmb_points ; i++){
    PVector p = new PVector(random(0 , width) , random(0 , height));
    
    caracteristics_points.add(p); 
  }
  return caracteristics_points;
}

ArrayList <Point> place_caracteristics_points(ArrayList <PVector> caracteristics_points){
  
  for(int i = 0 ; i < caracteristics_points.size() ; i++){
    
    PVector p_ = caracteristics_points.get(i);
    
    int index = (int)p_.x + (int)p_.y * width;
    color c = color(cam.pixels[index]);
    
    Point p = new Point(p_ , c);
    stream.add(p);  
  }
  return stream;
}

void make_voronoi(){
  
  dist_max = sqrt(width*width + height*height);
  // dist_max /= 2;
  
  for(int i = 0 ; i < width ; i++){
    for(int j = 0 ; j < height ; j++){
      
      Point this_point = new Point();
      
      PVector p_ij = new PVector(i , j);
      dist_min = dist_max;
 
      for(Point p : stream){
        float distance = compute_distance(p_ij , p.pvector);
        if(distance < dist_min){
          dist_min = distance;
          this_point = p;
        }
      }
      set(i , j , this_point.c);
    }
  } 
}

void captureEvent(Capture video) {
  video.read();
}

void setup() {
  size(700, 450);
  //fullScreen();
  background(0);
  
  String[] devices = Capture.list();
  println(devices);
  
  frameRate(24);
  
  cam = new Capture(this, width, height, devices[1]);
  cam.start();
  
}

void draw(){
  
  background(0);
  caracteristics_points = fill_caracteristics_points();
    
  cam.loadPixels();
  
  stream = place_caracteristics_points(caracteristics_points);
  make_voronoi();
  save("voronoi.png");
    
  stream.clear();
}
