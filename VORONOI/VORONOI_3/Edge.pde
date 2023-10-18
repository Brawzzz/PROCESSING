class Edge{
  
  int s1;
  int s2; 
  
  public Edge(int s1 , int s2) {
    this.s1 = s1;
    this.s2 = s2;
  }
  
  public boolean is_equal(Edge a){
    
    boolean equal = false;
    
    if((this.s1 == a.s1 && this.s2 == a.s2) || (this.s1 == a.s2 && this.s2 == a.s1) ){
      equal = true;
    }
    return equal;
  }
}
