class Point{
  
 float x;
 float y;
 color point_color;
 
 Point create_point(float x , float y , color color_point){
   
   Point p = new Point();
   
   p.x = x;
   p.y = y;
   p.point_color = color_point;
   
   return p;
 }
 
 void show(Point p){
     fill(p.point_color);
     circle(p.x , p.y , 5);
 }
}
