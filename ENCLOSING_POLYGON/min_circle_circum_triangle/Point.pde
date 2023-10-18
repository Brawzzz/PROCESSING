class Point{
  
  PVector pvector;
  float angle;
  
  public Point(){
   this.pvector = new PVector(0 , 0);
   this.angle = 0;
  }
  
  public Point(PVector p , float angle){
   this.pvector = p;
   this.angle = angle;
  }
}
