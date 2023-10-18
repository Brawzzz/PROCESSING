import java.util.Collections;
//================== VARIABLES =======================
final float ROOT_2 = 1.41421356237;

PVector inertie_center = new PVector();
PVector A  = new PVector();
PVector B  = new PVector();
PVector C  = new PVector();
    
int NB_POINTS = 50;

boolean ok = true;

ArrayList <Point> points = new ArrayList();
ArrayList <PVector> Triangle = new ArrayList();
  
Circle min_circle = new Circle();
Circle min_circle_bis = new Circle();
  
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

float r = 0;

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

//================== Computr the circum circle of a triangle define by 3 PVector ======================
Circle compute_circumcircle(PVector u , PVector v , PVector w){
  
  PVector z = new PVector(0 , 0 , 1);
  
  PVector p1 = u.copy();
  PVector p2 = v.copy();
  PVector p3 = w.copy();

  PVector p1_p2 = new PVector();
  PVector p2_p3 = new PVector();
  PVector p3_p1 = new PVector();

  PVector mid_1 = new PVector();
  PVector mid_2 = new PVector();
  PVector mid_3 = new PVector();
  
  PVector cross_1 = new PVector();
  PVector cross_2 = new PVector();
  PVector cross_3 = new PVector();
  
  Circle c = new Circle();
  
  p1_p2 = p2.copy().sub(p1);
  p2_p3 = p3.copy().sub(p2);
  p3_p1 = p1.copy().sub(p3);

  mid_1 = p1.copy().add(p1_p2.copy().div(k));
  mid_2 = p2.copy().add(p2_p3.copy().div(k));
  mid_3 = p1.copy().add(p3_p1.copy().div(k));

  cross_1 = mid_1.copy().add(p1_p2.copy().cross(z));
  cross_2 = mid_2.copy().add(p2_p3.copy().cross(z));
  cross_3 = mid_3.copy().add(p3_p1.copy().cross(z));
  
  float a1 = (cross_1.y - mid_1.y) / (cross_1.x - mid_1.x);
  float b1 = mid_1.y - (a1 * mid_1.x);

  float a2 = (cross_2.y - mid_2.y) / (cross_2.x - mid_2.x);
  float b2 = mid_2.y - (a2 * mid_2.x);

  float x1 = (b2 - b1) / (a1 - a2);
  float y1 = a1 * x1 + b1;

  PVector center = new PVector(x1, y1);
  float radius = dist(center.x , center.y , p1.x , p1.y);
  
  c = new Circle(center , radius);
  
  return c;
}

//======================== Convex hull computations functions =======================
ArrayList <Point> convex_hull_Graham(ArrayList <Point> points){

  ArrayList <Point> convex_hull = new ArrayList<Point>(); //<>//
  
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
  quickSort(points , 0 , points.size()-1); //<>//

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
      line(p.x , p.y , p_.x , p_.y);
    }
    else{
      p = convex_hull.get(count).pvector;
      p_ = convex_hull.get(count+1).pvector;
      
      stroke(c);
      line(p.x , p.y , p_.x , p_.y);
    }
  }
}

//======================== Compute the min circle of a points cloud =======================
Circle compute_min_circle(ArrayList <Point> p_list){
  
  ArrayList <Point> convex_hull = new ArrayList(); //<>//
  
  PVector triangle_p1 = new PVector();
  PVector triangle_p2 = new PVector();
  PVector triangle_p3 = new PVector();
  
  Point p0 = new Point();
  Point p1 = new Point();
  Point current_point = new Point();
  Point p_angle_min = new Point();
  
  Circle min_circle = new Circle();
  
  int size = 0;
  
  int first = 0;
  int second = 1;
  int third = 0;
  
  float current_angle = 0;
  
  float angle0 = 0;
  float angle1 = 0;
  float angle2 = 0;
  
  boolean found = false;

  convex_hull = convex_hull_Graham(p_list); //<>//
  size = convex_hull.size();
  
  do{
    
    p0 = convex_hull.get(first);
    p1 = convex_hull.get(second);
  
    for(int i = 2 ; i < size ; i++){
      current_point = convex_hull.get(i);
      
      current_angle = compute_angle(p0.pvector.copy() , current_point.pvector.copy() , p1.pvector.copy());
      
      if(current_angle < angle_min){
        angle_min = current_angle;
        p_angle_min = current_point;
        third = i;
      }
    }
    
    angle0 = compute_angle(p_angle_min.pvector.copy() , p0.pvector.copy() , p1.pvector.copy());
    angle1 = compute_angle(p_angle_min.pvector.copy() , p1.pvector.copy() , p0.pvector.copy());
    angle2 = angle_min;
    
    triangle_p1 = p0.pvector.copy();
    triangle_p2 = p1.pvector.copy();
    triangle_p3 = p_angle_min.pvector.copy();
    
    // println(angle0 , angle1 , angle2);
    
    if(angle_min >= PI/2){
      min_circle.radius = 0.5 * dist(p0.pvector.x , p0.pvector.y , p1.pvector.x , p1.pvector.y);
      min_circle.center = new PVector((p1.pvector.x + p0.pvector.x)/2 , (p1.pvector.y + p0.pvector.y)/2);
      
      found = true;
    }
    else if( (angle0 < PI/2) && (angle1 < PI/2) && (angle2 < PI/2) ){
      min_circle = compute_circumcircle(triangle_p1 , triangle_p2 , triangle_p3);
    
      found = true;
    }
    else{
      if(angle0 >= PI/2){
        first = second;
        second = third;
        angle_min = TWO_PI;
        
        found = false;
      }
      else if(angle1 >= PI/2){
        second = third;
        angle_min = TWO_PI;
        
        found = false;
      }
    }
  }while(!found);
  
  return min_circle; 
}

//======================== Compute the circum triangle of a circle c =======================
ArrayList <PVector> compute_circum_triangle(Circle c){
  
  float x = 2 * c.radius;
  float y =  c.radius * sqrt(3);
  // float y = ((ROOT_2 + 1 ) * c.radius) / ROOT_2;
  
  ArrayList <PVector> triangle_points = new ArrayList();
  
  PVector A  = new PVector(c.center.x + y , c.center.y + c.radius);
  PVector B  = new PVector(c.center.x - y , c.center.y + c.radius);
  PVector C  = new PVector(c.center.x , c.center.y - x);
  
  triangle_points.add(A);
  triangle_points.add(B);
  triangle_points.add(C);
  
  return triangle_points;
}

void plot_circle(Circle circle , color center_color , color circle_color){
  fill(center_color);
  stroke(center_color);
  circle(circle.center.x , circle.center.y , 5);
  
  noFill();
  stroke(circle_color);
  circle(circle.center.x , circle.center.y , 2*circle.radius);
}

//=========================== Compute min circle with inertie center ===============================
Circle min_circle_inertie_center(ArrayList <Point> points){
  
  Circle c = new Circle();
  
  for(int i = 0 ; i < points.size() ; i++){
    
    PVector p = points.get(i).pvector;
    
    sum_x += p.x;        
    sum_y += p.y;
  }
  
  averrage_x = sum_x / NB_POINTS;
  averrage_y = sum_y / NB_POINTS;
  
  fill(255 , 0 , 0);
  circle(averrage_x , averrage_y , 5);
  
  inertie_center.x = averrage_x;
  inertie_center.y = averrage_y;
  
  for(int i = 0 ; i < points.size() ; i++){
    
    PVector p = points.get(i).pvector;
    
    float dist = dist(p.x , p.y , inertie_center.x , inertie_center.y);
    
    if(dist > dist_max){
      dist_max = dist;
      r = dist_max;
    }
  }
  
  c.center = new PVector(averrage_x , averrage_y);
  c.radius = r;
  
  return c;
}

//=================================================================

void setup(){
  
  size(850,850,P3D);
  
  min = -100.f;
  max = 100.f;
  
  for(int i = 0 ; i < NB_POINTS ; i++){
    PVector p = new PVector(random(min , max) , random(min , max));
    Point p_i = new Point(p , 0);
    
    points.add(p_i);
  } //<>// //<>//
}

void draw(){
  
  if(ok){
    background(255);
  
    translate(width/2 , height/2 , 0);
    rotateX(-PI);
    
    //=================== min circle with convex hull =====================
    min_circle = compute_min_circle(points);
    plot_circle(min_circle , red , red);
    Triangle = compute_circum_triangle(min_circle);
    
    A  = Triangle.get(0);
    B  = Triangle.get(1);
    C  = Triangle.get(2);
    
    noFill();
    stroke(red);
    triangle(A.x , A.y , B.x , B.y , C.x , C.y);
    
    //=================== min circle with inertie center =====================
    min_circle_bis = min_circle_inertie_center(points);
    plot_circle(min_circle_bis , blue , blue);
    Triangle = compute_circum_triangle(min_circle_bis);
    
    A  = Triangle.get(0);
    B  = Triangle.get(1);
    C  = Triangle.get(2);
    
    noFill();
    stroke(blue);
    triangle(A.x , A.y , B.x , B.y , C.x , C.y); 
    
    //============= Display the defaults points =============
    for(Point p : points){
      PVector p_ = p.pvector;
      
      fill(black);
      stroke(black);
      circle(p_.x , p_.y , 5);
    }
  } 
  ok = false;
}
