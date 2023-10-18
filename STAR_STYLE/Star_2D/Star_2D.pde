int size = 50;

float k = 0;
float angle = 0;

color c =  color(255,255,255);

boolean ok = false;

//////////////////////////////////////////////////

ArrayList <Point> make_x_axis(){
  
  ArrayList <Point> x_axis = new ArrayList<Point>();
  
  Point p1 = new Point();

  for(int x = -size/2 ; x <= size/2 ; x++){
    p1 = p1.create_point(x*k , 0 , c);
    x_axis.add(p1);
    p1.show(p1);
  }
  return x_axis;
}

ArrayList <Point> make_y_axis(){
  
  ArrayList <Point> y_axis = new ArrayList<Point>();
  
  Point p2 = new Point();
  
  for(int y = -size/2 ; y <= size/2 ; y++){
    p2 = p2.create_point(0 , y*k , c);
    y_axis.add(p2);
    p2.show(p2);
  }
  return y_axis;
}

void relate_points(ArrayList <Point> x_axis , ArrayList <Point> y_axis){
  
  Point p1 = new Point();
  Point p2 = new Point();
  
  int c1 = y_axis.size()/2;
  int c2 = y_axis.size()/2;
  
  for(int i = 0 ; i < x_axis.size() ; i++){
    if(i < x_axis.size()/2){
      p1 = x_axis.get(i);
      p2 = y_axis.get(c1-1);
      stroke(255);
      line(p1.x,p1.y,p2.x,p2.y);
      c1--;
    }
    else if (i > x_axis.size()/2){
      p1 = x_axis.get(i);
      p2 = y_axis.get(c1);
      stroke(255);
      line(p1.x,p1.y,p2.x,p2.y);
      c1++;
    }
  }
  
  for(int j = 0 ; j < x_axis.size() ; j++){
    if(j > x_axis.size()/2){
      p1 = x_axis.get(j);
      p2 = y_axis.get(c2);
      stroke(255);
      line(p1.x,p1.y,p2.x,p2.y);
      c2--;
    }
    else if (j < x_axis.size()/2){
      p1 = x_axis.get(j);
      p2 = y_axis.get(c2+1);
      stroke(255);
      line(p1.x,p1.y,p2.x,p2.y);
      c2++;
    }
  }
}

void setup(){
  size(1000,1000);
}

void draw(){
  
  k = width/size;
  
  background(0);
  
  translate(width/2 , height/2);
  rotate(angle);
  
  ArrayList <Point> x_axis;
  ArrayList <Point> y_axis;
  
  x_axis = make_x_axis();
  y_axis = make_y_axis();
  
  relate_points(x_axis , y_axis);
  
  angle += 0.00;
}

void mousePressed(){
 if(mousePressed && mouseButton == LEFT){
   size += 10; 
 }
 else if(mousePressed && mouseButton == RIGHT){
   if(size != 10){
     size -= 10;
   }
 }
}
