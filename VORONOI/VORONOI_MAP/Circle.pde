class Circle{
  
  PVector center;
  float radius;
  
  public Circle(){
   this.center = new PVector(0 , 0);
   this.radius = 0;
  }
  
  public Circle(PVector center , float radius){
   this.center = center;
   this.radius = radius;
  }
}
