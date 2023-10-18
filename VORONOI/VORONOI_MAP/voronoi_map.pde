//============================================= LIBRARY ==================================================// //<>//
import processing.svg.*; 
import java.util.Map;

//============================================= TOOLS =============================================//
color red = color(255 , 0 , 0);
color green = color(0 , 255 , 0);
color blue = color(0 , 0 , 255);

color black = color(0 , 0 , 0);
color white = color(255 , 255 , 255);

//============================================= PARAMETERS ==================================================//
color lines_color = black;
color points_color = red;
color stroke_color = red;

float stroke_weight = 1.5;

String map_name = "./MAPS/france_mapV0.1.png";
String data_file = "./DATA_FILES/Gares_TGV_France_V0.0.csv";
String render_file_path = "./RENDER/voronoi_map";
String render_file = "voronoi_map";
String render_extension = ".png";

int rendering_max = 5;

boolean render = false;
boolean diagramm = false;
boolean map = false;
boolean compute_areas = false;
boolean triangulation= false;

//============================================= CONSTANT ==================================================//
final int POINTS_RADIUS = 10;
final float EARTH_RADIUS_M = 6378137.f;

//============================================= VARIABLES ==================================================//
Table table;
Table areas_table;

PImage background;
PGraphics voronoi;

Triangle super_triangle = new Triangle();
Circle super_triangle_circumcircle = new Circle();

ArrayList <Triangle> triangles = new ArrayList();
ArrayList <Triangle> real_triangles = new ArrayList();

ArrayList <Point> PointsList = new ArrayList();

ArrayList <PVector> points = new ArrayList();
ArrayList <PVector> centers = new ArrayList();
ArrayList <PVector> super_triangle_points = new ArrayList();

IntList areas = new IntList();

FloatList rayons = new FloatList();

PVector x = new PVector(1, 0, 0);
PVector y = new PVector(0, 1, 0);
PVector z = new PVector(0, 0, 1);

float k = 2.0f;

float min = 0.f;
float max = 0.f;

float x_max_super_triangle = 0.f;
float x_min_super_triangle = 0.f;

float y_max_super_triangle = 0.f;
float y_min_super_triangle = 0.f;

float x_mid = 0.f;
float adjust = 0.f;

float bx = 0.0;
float by = 0.0;

float xOffset = 0.0; 
float yOffset = 0.0; 

float zoom = 1.0;
float tx = 0.0;
float ty = 0.0;

float dist_min = 0;
float dist_max = 0;

//==================== GEOGRAPHIC =========================
float lambda0 = 0;

float MAP_AREA_M = 0;
float MAP_AREA_PIXEL = 0;
float PIXEL_AREA = 0;

//===== IDF =====//
//float lat_min = 48.30984803150943;
//float lat_max = 49.329604537252806;
//float long_min = 1.08591471459961;
//float long_max = 3.2323235182083447;

//===== FRANCE =====//
float lat_min = 42.304822275918255;
float lat_max = 51.694743508904516;
float long_min = -4.929560281370098;
float long_max = 9.157814631265923;

PVector NW;
PVector NE;
PVector SW;
PVector SE;

float x_max;
float x_min;

float y_max;
float y_min;

PVector cartesian = new PVector(0,0);
PVector mapped_cartesian = new PVector(0,0);

//============================================= FUNCTIONS ==================================================//

float compute_distance(PVector p1, PVector p2) {
  float distance = sqrt(((p1.x - p2.x) * (p1.x - p2.x)) + ((p1.y - p2.y) * (p1.y - p2.y)));
  return distance;
}

//==================== SUPER TRIANGLE =========================
Triangle make_super_triangle(){
  
  PVector p1 = new PVector();
  PVector p2 = new PVector();
  PVector p3 = new PVector();
  
  Triangle t = new Triangle();
  
  x_min_super_triangle = x_max_super_triangle;
  y_min_super_triangle = y_max_super_triangle;
  
  x_max_super_triangle = 0;
  y_max_super_triangle = 0;
  
  for(PVector p : points){
    
    if(p.y < y_min_super_triangle){
      y_min_super_triangle  = p.y;
    }
    if(p.y > y_max_super_triangle){
      y_max_super_triangle  = p.y;
    }
    if(p.x < x_min_super_triangle){
      x_min_super_triangle  = p.x;
    }
    if(p.x > x_max_super_triangle){
      x_max_super_triangle  = p.x;
    }
  }
  
  float scale_x = sqrt(3 * background.width * 3 * background.width + 3 * background.height * 3 * background.height);
  
  p1 = new PVector(scale_x/2 , -scale_x);
  p2 = new PVector(x_min_super_triangle - scale_x , y_max_super_triangle + scale_x);
  p3 = new PVector(x_max_super_triangle + scale_x , y_max_super_triangle + scale_x);  
  
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

//==================== CIRCUMCIRCLE =========================
boolean is_in_circumcircle(PVector p , Triangle t){
  
  boolean ok = false;
  
  if(compute_distance(p , t.circumcircle_center) <= t.circumcircle_rayon){
    ok = true; 
  }
  return ok;
}

//==================== POLYGONE =========================
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

//==================== PETERS PROJECTION =========================
PVector peters_projection(float longitude , float latitude){
  
  PVector new_coordinates = new PVector();
  
  new_coordinates.x = (float)(EARTH_RADIUS_M * PI * longitude / 180.0 ) / sqrt(2);
  new_coordinates.y = (float)(EARTH_RADIUS_M * sqrt(2) * sin(latitude*PI/180.0));
  
  return new_coordinates;
}

//==================== MERCATOR PROJECTION =========================
PVector mercator_projection(float longitude , float latitude, float lambda0){
  
  PVector mapped_coordinates = new PVector();
  
  mapped_coordinates.x = EARTH_RADIUS_M * ( (longitude * PI/180.0) - (lambda0 * PI/180.0) );
  mapped_coordinates.y = EARTH_RADIUS_M * ( log( tan( (PI/4) + ( (latitude * PI/180.0) / 2) ) ) );
  
  return mapped_coordinates;
}

//==================== MAPPING PROJECTION =========================
PVector mapping_projection(PVector position){
  
  PVector mapped_cartesian = new PVector();
  
  float rx = (position.x - NW.x) / (NE.x - NW.x);
  float ry = (position.y - SW.y) / (NW.y - SW.y);
  
  mapped_cartesian.x = 0 + (background.width - 0) * rx; 
  mapped_cartesian.y = 0 + (background.height - 0) * ( 1. - ry );

  return mapped_cartesian;
}

//==================== COMPUTE CELLS AREA =========================
PVector compute_min_dist(PVector u){
  
  float dist_max = sqrt(background.width * background.width + background.height * background.height);

  PVector min_points = new PVector();
  
  dist_min = dist_max;
  
  for(PVector p : points){
    
    float distance = compute_distance(u , p);
    
    if(distance < dist_min){
      dist_min = distance;
      min_points = p;
    }
  }
  
  return min_points;
}

void compute_areas(){
  
  dist_max = sqrt(background.width * background.width + background.height * background.height);
  
  PVector p_min = new PVector();
  
  for(int i = 0 ; i < background.width ; i++){
    for(int j = 0 ; j < background.height ; j++){
      
      PVector p_ij = new PVector(i , j);
      dist_min = dist_max;
      
      p_min = compute_min_dist(p_ij);
      
      for(int k = 0 ; k < points.size() ; k++){
        if(points.get(k) == p_min){
          areas.set(k , areas.get(k)+1); 
          break;
        }
      }
    }
  } 
}

//============================================= MAIN ==================================================//

void settings(){
  background = loadImage(map_name);
  size(1050 , 900 , P2D);
}

void setup() {
  
  //===== LOAD DATA FILE =====//
  table = loadTable(data_file, "header");
  
  //===== MAKE FILE FOR AREAS =====// 
  areas_table = new Table();
  areas_table.addColumn("Name");
  areas_table.addColumn("Pixel Area");
  areas_table.addColumn("Meters Area");
  
  voronoi = createGraphics(background.width , background.height , P2D);
  
  x_max_super_triangle = 3 * background.width;
  x_min_super_triangle = -3 * background.width;

  y_max_super_triangle = 3 * background.height;
  y_min_super_triangle = -3 * background.height;
  
  lambda0 = (long_max + long_min)/2;
  
  NW = mercator_projection(long_min , lat_max, lambda0);
  NE = mercator_projection(long_max , lat_max, lambda0);
  SW = mercator_projection(long_min , lat_min, lambda0);
  SE = mercator_projection(long_max , lat_min, lambda0);
  
  MAP_AREA_M = compute_distance(NW , NE) * compute_distance(NE , SE) ;
  MAP_AREA_PIXEL = background.width * background.height;
  PIXEL_AREA = (float)(MAP_AREA_M / MAP_AREA_PIXEL);

  float latitude = 0.f;
  float longitude = 0.f;
  
  for (TableRow row : table.rows()) {
    
    latitude = row.getFloat("Lat");
    longitude = row.getFloat("Long");
    
    cartesian = mercator_projection(longitude , latitude , lambda0);
    // cartesian = peters_projection(longitude , latitude);
    
    mapped_cartesian = mapping_projection(cartesian);
    
    if(mapped_cartesian.x > background.width || mapped_cartesian.y < 0. || mapped_cartesian.y > background.height){
        //println("OUT");
    }
    else{
      points.add(mapped_cartesian); 
      areas.append(0);
    }
  }
}

void draw() { 
  
  if(!render){
    background(255);
    
    pushMatrix();
    translate(width/2,height/2);
    translate(tx,ty);
    scale(zoom);
    imageMode(CENTER);
    image(background , 0, 0);
    
    pushMatrix();
    translate(-background.width/2 , -background.height/2);
    
    //===================== DRAW IN IMAGE BASE  ==========================
    
    if(diagramm){
      
      centers = new ArrayList();
      real_triangles = new ArrayList();
      triangles = new ArrayList();
      
      super_triangle = make_super_triangle();
      super_triangle.compute_circumcircle(points);
      
      ////////////////////  DELAUNAY TRAINGULATION  //////////////////
       
      for(int i = 0 ; i < points.size()-3 ; i++){
        
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
        centers.add(t.circumcircle_center);
      }
    
      ////////////////////    VORONOI DIAGRAM    //////////////////
        
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
    }  
    
    //========== SHOW DELAUNAY TRIANGULATION ==========//
    for(Triangle t : real_triangles){
      if(triangulation){
        t.show(blue);
        // t.show_circumcircle(red); 
      }
    }
    fill(points_color);
    strokeWeight(1);
    stroke(stroke_color);
    
    if(map){
      for(PVector p : points){
        rect(p.x - POINTS_RADIUS/2 , p.y - POINTS_RADIUS/2 , POINTS_RADIUS , POINTS_RADIUS , 3);
      }
    }
    
    if(compute_areas){
      
      print("COMPUTE AREAS ... ");
      
      compute_areas();
      
      int index = 0;
      
      for (TableRow row : table.rows()) {
  
        String name = row.getString("Name");
          
        TableRow newRow = areas_table.addRow();
        newRow.setString("Name", name);
        newRow.setFloat("Meters Area", (float)(areas.get(index) * PIXEL_AREA));
        newRow.setLong("Pixel Area", areas.get(index));

        index++;
      }
      saveTable(areas_table , "./DATA_FILES/AREAS" + "_" + year() + "_" + month() + "_" + day() + "_" + hour() + "_" + minute() + ".csv");
      
      println("FINISHED");
      compute_areas = false;
    }
    
    popMatrix();
    popMatrix();
  }
  
  else{
    
    print("LAUNCH RENDER ... ");
    
    for(int rendering = 0 ; rendering < rendering_max ; rendering++){
      
      voronoi.beginDraw();
      voronoi.background(255);
      voronoi.image(background , 0, 0);
    
      //===================== DRAW IN IMAGE BASE  ==========================
      
      if(diagramm){
        centers = new ArrayList();
        real_triangles = new ArrayList();
        triangles = new ArrayList();
        
        super_triangle = make_super_triangle();
        super_triangle.compute_circumcircle(points);
        
        ////////////////////  DELAUNAY TRAINGULATION  //////////////////
         
        for(int i = 0 ; i < points.size()-3 ; i++){
          
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
          centers.add(t.circumcircle_center);
        }
      
        ////////////////////    VORONOI DIAGRAM    //////////////////
          
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
                    
                    voronoi.stroke(lines_color);
                    voronoi.strokeWeight(stroke_weight);
                    voronoi.line(t.circumcircle_center.x , t.circumcircle_center.y , t1.circumcircle_center.x , t1.circumcircle_center.y);
                  }   
                }
              }
            }
          } 
        } 
      }
    
      voronoi.fill(points_color);
      voronoi.strokeWeight(1);
      voronoi.stroke(stroke_color);
      
      if(map){
        for(PVector p : points){
          voronoi.rect(p.x - POINTS_RADIUS/2 , p.y - POINTS_RADIUS/2 , POINTS_RADIUS , POINTS_RADIUS , 3);
        }
      }
    
      voronoi.endDraw();
      voronoi.save(render_file_path + render_file + "_" + year() + "_" + month() + "_" + day() + "_" + hour() + "_" + minute() + render_extension);
    }
    
    println("RENDER DOWN");
    render = false;
  }
}

//============================================= USER EVENT ==================================================//

void mouseDragged() {
  
  float dpx = mouseX - pmouseX; 
  float dpy = mouseY - pmouseY; 
  
  float s = 0.5; 
  tx += s * dpx;
  ty += s * dpy;
}

void mouseWheel(MouseEvent event) {
  
  float dx = mouseX - width / 2 - tx; 
  float dy = mouseY - height / 2 - ty; 
  int sgn = event.getCount() > 0 ? 1 : -1;
  zoom -= float(event.getCount()) * 0.1 * zoom;
  
  float s = 0.1; 
  tx += sgn * s * dx;
  ty += sgn * s * dy;
}

void keyReleased() {
  
  if (key == 'r' || key == 'R') {
    zoom = 1.0;
    tx = 0.0;
    ty = 0.0;
  }
  
  if(key == 'c' || key == 'C'){
     save(render_file);
     println("CAPTURE !"); 
  }
  
  if(key == 'd' || key == 'D'){
    if(diagramm){
      diagramm = false;
    }
    else{
      diagramm = true;
    }
  }
  
  if(key == 'm' || key == 'M'){
    if(map){
      map = false;
    }
    else{
      map = true;
    }
  }
  
  if(key == 'r' || key == 'R'){
    if(render){
      render = false;
    }
    else{
      render = true;
    }
  }
  
   if(key == 'a' || key == 'A'){
    if(compute_areas){
      compute_areas = false;
    }
    else{
      compute_areas = true;
    }
  }
  
  if(key == 't' || key == 'T'){
    if(triangulation){
      triangulation = false;
    }
    else{
      triangulation = true;
    }
  }
}
