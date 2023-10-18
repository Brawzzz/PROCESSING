import java.util.Collections;
//================== VARIABLES =======================
final float ROOT_2 = 1.41421356237;

PVector inertie_center = new PVector();
PVector A  = new PVector();
PVector B  = new PVector();
PVector C  = new PVector();
    
int NB_POINTS = 5;

boolean ok = true;

ArrayList <Point> points = new ArrayList();
ArrayList <Point> convex_hull = new ArrayList();
  
int sum_x = 0;
int sum_y = 0;

float averrage_x = 0;
float averrage_y = 0;

float dist_min = 0;
float dist_max = 0;

float x_min = 0;
float x_max = 1000;
float y_min = 0;
float y_max = 1000;

float angle_min = TWO_PI;

float min = 0.f;
float max = 0.f;

float k = 2.f;

color black = color(0 , 0 , 0);
color white = color(255 , 255 , 255);

color red = color(255 , 0 , 0);
color green = color(0 , 255 , 0);
color blue = color(0 , 0 , 255);

//====================== QuickSort ========================
void quickSort(ArrayList <Point> arr, int left, int right) {  
  if (left < right) {
    int pivotIndex = partition(arr, left, right);
    quickSort(arr, left, pivotIndex - 1);
    quickSort(arr, pivotIndex + 1, right);
  }
}

int partition(ArrayList <Point> arr, int left, int right) {
  float pivotValue = arr.get(right).angle;
  int i = left - 1;
  
  for (int j = left ; j < right ; j++) {
    if (arr.get(j).angle <= pivotValue) {
      i++;
      Collections.swap(arr , i , j);
    }
  }
  
  Collections.swap(arr , i + 1 , right);
  return i + 1;
}

//================== Compute the angle between u , v , w ======================
float compute_angle(PVector u , PVector v , PVector w){
  
  PVector uv = u.copy().sub(v.copy());
  PVector vw = w.copy().sub(v.copy());

  float norm_uv = dist(u.x , u.y , v.x , v.y);
  float norm_vw = dist(v.x , v.y , w.x , w.y);
    
  float dot_product = uv.copy().dot(vw.copy());
  float angle = acos(dot_product / (norm_uv * norm_vw));
    
  return angle;
}

//================== Find the points with the min y-axis cordinate ======================
Point min_y_cordinate(ArrayList <Point> points){
  
  Point p_y_min = new Point();
  
  y_min = y_max;
  
  for(Point p : points){
    
    if(p.pvector.y < y_min){
      y_min = p.pvector.y;
      p_y_min = p;
    }
  } 
  
  println(p_y_min.pvector);
  println();
  return p_y_min;
}

//================== Find the points with the min x-axis cordinate ======================
Point min_s_cordinate(ArrayList <Point> points){
  
  Point p_x_min = new Point();
  
  x_min = x_max;
  
  for(Point p : points){
    
    if(p.pvector.x < x_min){
      x_min = p.pvector.x;
      p_x_min = p;
    }
  } 
  
  println(p_x_min.pvector);
  println();
  return p_x_min;
}


//======================== Convex hull computations functions =======================
ArrayList <Point> convex_hull_Graham(ArrayList <Point> points){

  ArrayList <Point> convex_hull = new ArrayList<Point>();
  
  Point pivot = min_y_cordinate(points);
  
  Point last = new Point();
  Point before_last = new Point();
  Point current = new Point();
  
  PVector u = new PVector(1 , 0);
  PVector v = new PVector();
  
  PVector last_vector = new PVector();
  PVector before_last_vector = new PVector();
  PVector current_vector = new PVector();
  
  int last_index = 0;
  int before_last_index = 0;
  int current_index = 0;
  
  float v_norm = 0;
  float dot_product = 0;
  float angle = 0;
  
  float sign = 0;
  
  for(int i = 0 ; i < points.size() ; i++){
    
    Point p = points.get(i);
    
    if(p != pivot){
      
      v = (p.pvector.copy()).sub(pivot.pvector.copy());
      dot_product = u.copy().dot(v.copy());
      v_norm = dist(0 , 0 , v.x , v.y);
      
      if(v_norm != 0){
        angle = acos((dot_product)/(v_norm));
      }
      
      p.angle = angle;
    }
  }
  quickSort(points , 0 , points.size()-1);

  // Iteration to compute the points on the convex hull
  convex_hull.add(points.get(0));
  convex_hull.add(points.get(1));
  
  last_index = 1;
  before_last_index = 0;
  current_index = last_index + 1;
  
  do{
    
    last = convex_hull.get(last_index);
    before_last = convex_hull.get(before_last_index);
    current = points.get(current_index);
    
    last_vector = last.pvector.copy();
    before_last_vector = before_last.pvector.copy();
    current_vector = points.get(current_index).pvector.copy();
    
    PVector a = last_vector.copy().sub(before_last_vector.copy());
    PVector b = current_vector.copy().sub(last_vector.copy());
    
    // Compute the preiantation of the angle
    // between teh two vetors a and b
    sign = (a.x * b.y) - (a.y * b.x);
    
    if(sign > 0){
      convex_hull.add(current);
      last_index++; 
      before_last_index++;
      current_index++;
    }
    else{
      convex_hull.remove(last_index);
      last_index = convex_hull.size() - 1;
      before_last_index = convex_hull.size() - 2;
    }
  }while(current_index <= NB_POINTS-1);
  
  return convex_hull;
}

void plot_convex_hull(ArrayList <Point> convex_hull , color c){
  for(int count = 0 ; count < convex_hull.size() ; count++){
    
    PVector p = new PVector();
    PVector p_ = new PVector();
    
    if(count == convex_hull.size() - 1){
      p = convex_hull.get(count).pvector;
      p_ = convex_hull.get(0).pvector;
      
      stroke(c);
      strokeWeight(2);
      line(p.x , p.y , p_.x , p_.y);
    }
    else{
      p = convex_hull.get(count).pvector;
      p_ = convex_hull.get(count+1).pvector;
      
      stroke(c);
      strokeWeight(2);
      line(p.x , p.y , p_.x , p_.y);
    }
  }
}

//============= Display the defaults points =============
void display_points_cloud(ArrayList <Point> points){
    for(Point p : points){
      PVector p_ = p.pvector;
      
      fill(black);
      stroke(black);
      circle(p_.x , p_.y , 5);
    }
}

void setup(){
  
  size(850,850,P3D);
  
  min = 200.f;
  max = 600.f;
  
  for(int i = 0 ; i < NB_POINTS ; i++){
    PVector p = new PVector(random(min , max) , random(min , max));
    Point p_i = new Point(p , 0);
    
    points.add(p_i);
  }
}

void draw(){
  
  if(ok){
      
      background(white); //<>//
  
      convex_hull = convex_hull_Graham(points);
      plot_convex_hull(convex_hull , red);
      
      display_points_cloud(points);
      
      convex_hull.clear();
      NB_POINTS ++;
      
      ok = false;
  }
}

void mousePressed(){
  
  if(mouseButton == LEFT){
    
    convex_hull.clear();
    
    PVector p_ = new PVector(mouseX , mouseY);
    Point p_i = new Point(p_ , 0);
    points.add(p_i);
    
    ok = true;
  } 
  
  else if(mouseButton == RIGHT){
    PVector p = new PVector(random(min , max) , random(min , max));
    Point p_i = new Point(p , 0);
    
    points.add(p_i);
    
    ok = true;
  }  
}
