class Triangle{
  
  int s1;
  int s2;
  int s3;
  
  Edge a1;
  Edge a2;
  Edge a3;
  
  Edge[] triangles_edges = new Edge[3];
  
  PVector circumcircle_center;
  float circumcircle_rayon;
  
  public Triangle(){
    this.s1 = 0;
    this.s2 = 0;
    this.s3 = 0;
  }
  
  public void show_circumcircle(color c){
    fill(c);
    stroke(c);
    circle(this.circumcircle_center.x , this.circumcircle_center.y , 5);
    noFill();
    stroke(c);
    circle(this.circumcircle_center.x , this.circumcircle_center.y , this.circumcircle_rayon * 2);
  }
  
  public Triangle(int s1 , int s2 , int s3) {
    this.s1 = s1;
    this.s2 = s2;
    this.s3 = s3;
  }
  
  public void show(color c){
    noFill();
    stroke(c);
    triangle(points.get(this.s1).x , points.get(this.s1).y , points.get(this.s2).x , points.get(this.s2).y , points.get(this.s3).x , points.get(this.s3).y);
    
  }
  
  public void fill_triangle_edge(){
    this.triangles_edges[0] = this.a1;
    this.triangles_edges[1] = this.a2;
    this.triangles_edges[2] = this.a3; 
  }
  
  public void compute_circumcircle(ArrayList <PVector> points){
    
    int s1 = this.s1;
    int s2 = this.s2;
    int s3 = this.s3;
    
    PVector p1 = points.get(s1);
    PVector p2 = points.get(s2);
    PVector p3 = points.get(s3);
  
    PVector p1_p2 = new PVector();
    PVector p2_p3 = new PVector();
    PVector p3_p1 = new PVector();

    PVector mid_1 = new PVector();
    PVector mid_2 = new PVector();
    PVector mid_3 = new PVector();
    
    PVector cross_1 = new PVector();
    PVector cross_2 = new PVector();
    PVector cross_3 = new PVector();
    
    float a1 = 0;
    float a2 = 0;
    float a3 = 0;
    
    float b1 = 0;
    float b2 = 0;
    float b3 = 0;
    
    float x1 = 0;
    float y1 = 0;

    p1_p2 = p2.copy().sub(p1.copy());
    p2_p3 = p3.copy().sub(p2.copy());
    p3_p1 = p3.copy().sub(p1.copy());
  
    mid_1 = p1.copy().add(p1_p2.copy().div(k));
    mid_2 = p2.copy().add(p2_p3.copy().div(k));
    mid_3 = p1.copy().add(p3_p1.copy().div(k));
  
    cross_1 = mid_1.copy().add(p1_p2.copy().cross(z.copy()));
    cross_2 = mid_2.copy().add(p2_p3.copy().cross(z.copy()));
    cross_3 = mid_3.copy().add(p3_p1.copy().cross(z.copy()));
    
    
    if(cross_1.x == mid_1.x){ //<>//
      a2 = (cross_2.y - mid_2.y) / (cross_2.x - mid_2.x);
      b2 = mid_2.y - (a2 * mid_2.x);
      
      a3 = (cross_3.y - mid_3.y) / (cross_3.x - mid_3.x);
      b3 = mid_3.y - (a3 * mid_3.x);
      
      x1 = (b3 - b2) / (a2 - a3);
      y1 = a3 * x1 + b3;
    }
    
    else if(cross_2.x == mid_2.x){
      a1 = (cross_1.y - mid_1.y) / (cross_1.x - mid_1.x);
      b1 = mid_1.y - (a1 * mid_1.x);
      
      a3 = (cross_3.y - mid_3.y) / (cross_3.x - mid_3.x);
      b3 = mid_3.y - (a3 * mid_3.x);
      
      x1 = (b3 - b1) / (a1 - a3);
      y1 = a1 * x1 + b1;
    }
      
    else if(cross_3.x == mid_3.x){
      a1 = (cross_1.y - mid_1.y) / (cross_1.x - mid_1.x);
      b1 = mid_1.y - (a1 * mid_1.x);
      
      a2 = (cross_2.y - mid_2.y) / (cross_2.x - mid_2.x);
      b2 = mid_2.y - (a2 * mid_2.x);
      
      x1 = (b2 - b1) / (a1 - a2);
      y1 = a1 * x1 + b1;
    }
    else{
      a1 = (cross_1.y - mid_1.y) / (cross_1.x - mid_1.x);
      b1 = mid_1.y - (a1 * mid_1.x);
      
      a2 = (cross_2.y - mid_2.y) / (cross_2.x - mid_2.x);
      b2 = mid_2.y - (a2 * mid_2.x);
      
      x1 = (b2 - b1) / (a1 - a2);
      y1 = a1 * x1 + b1;
    }
  
    PVector center = new PVector(x1, y1);
    float rayon = compute_distance(center, p1);
    
    this.circumcircle_center = center;
    this.circumcircle_rayon = rayon;
  }
  
}
