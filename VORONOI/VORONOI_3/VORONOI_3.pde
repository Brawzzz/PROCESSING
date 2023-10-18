import java.util.Collections;
//=================== TOOLS =========================
color red = color(255 , 0 , 0);
color green = color(0 , 255 , 0);
color blue = color(0 , 0 , 255);

color black = color(0 , 0 , 0);
color white = color(255 , 255 , 255);

//=============== PARAMETERS ===================
int window_width = 1050;
int window_height = 850;

boolean full = false;

color lines_color = black;
color points_color = red;
color centers_color = black;

float points_radius = 5; // square lentgth
float stroke_weight = 1;

//===================//
int NB_POINTS = 2;

Triangle super_triangle = new Triangle();
Circle super_triangle_circumcircle = new Circle();

ArrayList <Triangle> triangles = new ArrayList();
ArrayList <Triangle> real_triangles = new ArrayList();

ArrayList <Point> PointsList = new ArrayList();

ArrayList <PVector> points = new ArrayList();
ArrayList <PVector> centers = new ArrayList();
ArrayList <PVector> super_triangle_points = new ArrayList();

FloatList rayons = new FloatList();

PVector x = new PVector(1, 0, 0);
PVector y = new PVector(0, 1, 0);
PVector z = new PVector(0, 0, 1);

float k = 2.0f;

float min = 0.f;
float max = 0.f;

float x_max = 0.f;
float x_min = 0.f;

float y_max = 0.f;
float y_min = 0.f;

float x_mid = 0.f;
float adjust = 0.f;

boolean ok = true;

//=================== FUNCTIONS ======================
void show_points(PVector p, color c) {
  fill(c);
  stroke(c);
  // circle(p.x, p.y, points_radius);
  rect(p.x, p.y, points_radius , points_radius);
}

float compute_distance(PVector p1, PVector p2) {
  float distance = sqrt(((p1.x - p2.x) * (p1.x - p2.x)) + ((p1.y - p2.y) * (p1.y - p2.y)));
  return distance;
}

ArrayList <PVector> place_random_points() {

  ArrayList <PVector> points = new ArrayList();
  
  for (int i = 0; i < NB_POINTS ; i++){

    PVector p = new PVector();
    Point p_i = new Point();
    
    p.x = random(min, max);
    p.y = random(min, max);
    p_i = new Point(p , 0);
    
    points.add(p);
    PointsList.add(p_i);
  }
  return points;
}

/////////////////  SUPER TRIANGLE  /////////////////
Triangle make_super_triangle(){
  
  PVector p1 = new PVector();
  PVector p2 = new PVector();
  PVector p3 = new PVector();
  
  Triangle t = new Triangle();
  
  x_min = x_max;
  y_min = y_max;
  
  x_max = 0;
  y_max = 0;
  
  for(PVector p : points){
    
    if(p.y < y_min){
      y_min = p.y;
    }
    if(p.y > y_max){
      y_max = p.y;
    }
    if(p.x < x_min){
      x_min = p.x;
    }
    if(p.x > x_max){
      x_max = p.x;
    }
  }
  
  // println(x_min , x_max , y_min);
  
  float scale_x = sqrt(width*width + height*height);
  
  p1 = new PVector(scale_x/2 , -scale_x);
  p2 = new PVector(x_min - scale_x , y_max + scale_x);
  p3 = new PVector(x_max + scale_x , y_max + scale_x);  
  
  points.add(p1);
  points.add(p2);
  points.add(p3);
  
  int s1 = points.size() - 1;
  int s2 = points.size() - 2;
  int s3 = points.size() - 3;
  
  t = new Triangle(s1,s2,s3);
 
  t.a1 = new Edge(s1 , s2);
  t.a2 = new Edge(s2 , s3);
  t.a3 = new Edge(s3 , s1);
  
  t.triangles_edges[0] = t.a1;
  t.triangles_edges[1] = t.a2;
  t.triangles_edges[2] = t.a3;
  
  triangles.add(t);
  return t;
}

boolean is_in_circumcircle(PVector p , Triangle t){
  
  boolean ok = false;
  
  if(compute_distance(p , t.circumcircle_center) <= t.circumcircle_rayon){
    ok = true; 
  }
  return ok;
}

ArrayList <Edge> compute_polygone(ArrayList <Triangle> illegal_triangles){
 
  ArrayList <Edge> edges = new ArrayList();
  
  for(int i = 0 ; i < illegal_triangles.size() ; i++){
    
    Triangle t_1 = illegal_triangles.get(i);
    
    t_1.fill_triangle_edge();
    
    for(Edge e : t_1.triangles_edges){
      boolean found = false;
      for(int j = 0 ; j < illegal_triangles.size() ; j++){
        if(i != j){
        
          Triangle t_2 = illegal_triangles.get(j);
          
          if(e.is_equal(t_2.a1) || e.is_equal(t_2.a2) || e.is_equal(t_2.a3)){
            found = true;
            break; 
          }
         }
       }
       if (!found) {
         edges.add(e);
       }
    }
  }
  return edges;
}

void settings(){
  if(full){
   fullScreen(); 
  }
  else{
    size(window_width , window_height);
  }
  
}

void setup(){
  
  background(255);
  
  x_max = width;
  x_min = 0;

  y_max = height;
  y_min = 0;
  
  min = 50.f;
  max = width - 50.f;
  
  points = place_random_points(); //<>//
}

void draw(){
  
  if(ok){ 
    
    background(255);
    
    centers = new ArrayList();
    real_triangles = new ArrayList();
    triangles = new ArrayList();
    
    //// New random points set for each iterations ////
    // points = place_random_points();
    
    super_triangle = make_super_triangle();
    super_triangle.compute_circumcircle(points);
    
    ////////// Show the super triangle and his circum circle //////////
    //super_triangle.show(red);
    //super_triangle.show_circumcircle(red);
    
    for(int i = 0 ; i < points.size()-3 ; i++){
      PVector p = points.get(i); 
      show_points(p , points_color); 
    }
 
  ////////////////////    DELAUNAY TRAINGULATION  //////////////////
    
    for(int i = 0 ; i < points.size()-3 ; i++){ //<>//
      
      ArrayList <Triangle> illegal_triangles = new ArrayList();
      ArrayList <Edge> edges = new ArrayList();
      
      PVector p = points.get(i);
      
      for(Triangle t : triangles){
        
        if(is_in_circumcircle(p , t)){
          
          t.a1 = new Edge(t.s1 , t.s2);
          t.a2 = new Edge(t.s2 , t.s3);
          t.a3 = new Edge(t.s3 , t.s1);
          
          illegal_triangles.add(t);
        }
      }
      
      edges = compute_polygone(illegal_triangles);
    
      for(Triangle t : illegal_triangles){
        triangles.remove(t);
      }
    
      for(Edge e : edges){  
        Triangle t = new Triangle(e.s1 , i , e.s2);
        t.compute_circumcircle(points);
        triangles.add(t);
      }
    }
    
    for(Triangle t : triangles){
      
      int s1 = points.size() - 1;
      int s2 = points.size() - 2;
      int s3 = points.size() - 3;
    
      if( (t.s1 != s1 && t.s1 != s2 && t.s1 != s3) && (t.s2 != s1 && t.s2 != s2 && t.s2 != s3) && (t.s3 != s1 && t.s3 != s2 && t.s3 != s3) ){
        real_triangles.add(t);
      }
    }
    
    for(Triangle t : real_triangles){
      //===== SHOW DELAUNAY TRIANGULATION =====//
      // t.show(blue);
      // t.show_circumcircle(red);
      centers.add(t.circumcircle_center);
    }

  ////////////////////    VORONOI DIAGRAM    //////////////////
    
    //for(PVector p : centers){
    //  show_points(p , centers_color);
    //}
    
    for(int j = 0 ; j < triangles.size() ; j++){
      Triangle t = triangles.get(j); 
      
      t.a1 = new Edge(t.s1 , t.s2);
      t.a2 = new Edge(t.s2 , t.s3);
      t.a3 = new Edge(t.s3 , t.s1);
      
      t.fill_triangle_edge();
      
      for(int k = 0 ; k < triangles.size() ; k++){
        Triangle t1 = triangles.get(k);
        
        t1.a1 = new Edge(t1.s1 , t1.s2);
        t1.a2 = new Edge(t1.s2 , t1.s3);
        t1.a3 = new Edge(t1.s3 , t1.s1);
        
        t1.fill_triangle_edge();
        
        for(Edge e : t.triangles_edges){
          for(Edge e1 : t1.triangles_edges){
            
            if(j != k){
              if(e.is_equal(e1)){
                stroke(lines_color);
                strokeWeight(stroke_weight);
                line(t.circumcircle_center.x , t.circumcircle_center.y , t1.circumcircle_center.x , t1.circumcircle_center.y);
              }   
            }
          }
        }
      } 
    } 
    ok = false;   //<>//
  }
}

void mousePressed(){
  
  if(mouseButton == LEFT){
    int size = points.size();
    for(int i = 1 ; i <= 3 ; i++){
      if(size >= 3){
        PVector p = points.get(size-i); 
        points.remove(p);
      }
    }  
    PVector p_ = new PVector(mouseX , mouseY);
    Point i = new Point(p_ , 0);
    
    points.add(p_);
    PointsList.add(i);
 
    ok = true;
  } 
  
  else if(mouseButton == RIGHT){
    NB_POINTS *= 2;
    ok = true;
  }  
}
