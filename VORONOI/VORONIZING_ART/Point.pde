class Point{
  
  PVector pvector;
  color c;
  
  public Point(){
   this.pvector = new PVector(0 , 0);
   this.c = 0;
  }
  
  public Point(PVector p , color c){
   this.pvector = p;
   this.c = c;
  }
}
