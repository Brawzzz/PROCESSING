color c = color(255, 255 , 255);
IntList list = new IntList();

float box_size = 10;
int side = 20;

Box box = new Box();
ArrayList<Box> boxes = new ArrayList<Box>();

boolean is_prime_number(int n){
  
  boolean prime = true;
  int d = 2;
  
  if( n < 2){
   prime = false; 
  }
  else if( n == 2){
    prime = true;
  }
  else if( n % 2 == 0){
   prime = false; 
  }
  
  else{
    
   while(d < n){
     
     if(n % d == 0){
       prime = false; 
     }
     d += 1;
   }
   
  }
  return prime;
}

void setup(){
  
  size(1000,1000);
  background(255);
  
  box_size = width/float(side);
  
  for(int j = 0 ; j < side ; j++){
    for(int i = 0 ; i < side ; i++){
      box = box.create_box(i , j , box_size);
      boxes.add(box);
    }
  }
  
  println();
  
  for(int i = 0 ; i < boxes.size() ; i++){
    if(is_prime_number(i)){
      box = boxes.get(i);
      box.fill = true;
    }
  } //<>//
}

void draw(){

  for(Box box : boxes){
    box.show_box(box);
  }
}
