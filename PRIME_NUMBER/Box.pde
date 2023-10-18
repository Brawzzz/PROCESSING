class Box{
  
 float size;
 boolean fill;
 int x;
 int y;
 
 Box create_box(int x , int y , float size){
   
   Box box = new Box();
   
   box.x = x * int(size);
   box.y = y * int(size);
   
   box.size = size;
   box.fill = false;
   
   return box;
 }
 
 void show_box(Box box){
   if(box.fill == false){
     fill(0);
     stroke(0);
     square(box.x , box.y , size);
   }
   else{
     fill(255,0,0);
     stroke(255,0,0);
     square(box.x , box.y , size);
   }
 }
 
}
