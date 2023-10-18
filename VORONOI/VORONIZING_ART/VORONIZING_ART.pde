//======================================
ArrayList <PVector> points = new ArrayList();

ArrayList <Point> mona_lisa = new ArrayList();

PImage Mona_Lisa = new PImage();

int nmb_points = 5000;
int dimensions_Mona_Lisa = Mona_Lisa.width * Mona_Lisa.height;

int month = 0;
int day = 0; 
int min = 0; 
int hour = 0;

float k = 50;

float dist_min = 0;
float dist_max = 0;

float c_min = 0;
float c_max = 255;

color white = color(255,255,255);
color red = color(255,0,0);
color green = color(0,255,0);
color blue = color(0,0,255);
color black = color(0,0,0);

boolean ok = true;
boolean save = false;

StringList art_list = new StringList();
String image;

String art_file = "C:/YA TROP DE CHOSE/PROCESSING/VORONOI/VORONIZING_ART/ART/";
//======================================

void show_points(PVector p , color c){
  fill(c);
  circle(p.x , p.y , 5);
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
    color c = color(Mona_Lisa.pixels[index]);
    
    Point p = new Point(p_ , c);
    mona_lisa.add(p);
    
  }
  return mona_lisa;
}

void make_voronoi(){
  
  dist_max = sqrt(width*width + height*height);
  // dist_max /= 2;
  
  for(int i = 0 ; i < width ; i++){
    for(int j = 0 ; j < height ; j++){
      
      Point this_point = new Point();
      
      PVector p_ij = new PVector(i , j);
      dist_min = dist_max;
 
      for(Point p : mona_lisa){
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

void setup(){
  background(255);
}

void settings() {
  
  art_list.append("Mona_Lisa.jpg"); // 0
  art_list.append("Grande_Vague.jpg"); // 1
  art_list.append("Le_Voyageur.jpg"); // 2
  art_list.append("La_Liberté_guidant_le_peuple.jpg"); // 3
  art_list.append("croco.jpg"); // 4
  art_list.append("Daft_Punk_RAM.jpg"); // 5
  art_list.append("Daft_Punk_Discovery.png"); // 6
  art_list.append("lascaux_bull.jpg"); // 7
  art_list.append("Lascaux_Cheval.jpg"); // 8
  art_list.append("Mona_Lisa.png"); // 9
  
  Mona_Lisa = loadImage(art_list.get(9));
  Mona_Lisa.loadPixels();
  
  size(Mona_Lisa.width , Mona_Lisa.height);
}

void draw(){   //<>//
  
  if(ok){
    
    mona_lisa = place_random_points();
    
    save = true;
    
    month = month();
    day = day(); 
    min = minute(); 
    hour = hour();
  }
  
  long start = millis();
  make_voronoi();
  long end = millis();
  
  float time_stamp = (end - start)/1000.0;
    
  println(time_stamp + "seconds");
  // println("Iterations Done !");
  
  if(save){ 
    save(art_file + month + "_" + day + "_" + hour + "_" + min + ".jpg");
    save = false;
  }
  
  ok = false;

  //for(Point p : mona_lisa){
  //  show_points(p.pvector , black);
  //}
  
}

void mousePressed(){
  
  if(mouseButton == LEFT){
    PVector p_ = new PVector(mouseX , mouseY);
    
    int index = mouseX + mouseY * width;
    color c = color(Mona_Lisa.pixels[index]);
    
    Point p = new Point(p_ , c);
    mona_lisa.add(p);
    save = true;
  }
  
  else if(mouseButton == RIGHT){
    nmb_points += 500;
    ok = true;
  }
}
