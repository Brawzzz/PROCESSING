ArrayList <Segment> segments;

void addAll (Segment[] arr, ArrayList<Segment>list){
  for( Segment r : arr){
  list.add(r);
  }
}
  

void setup(){
  size(1000,500);
  
  segments = new ArrayList<Segment>();
  
  PVector a = new PVector (0,250);
  PVector b = new PVector (1000,250);
  
  Segment start = new Segment(a,b); 
  //segments.add(start);
  Segment[] children = start.generate();
  addAll(children, segments);
}
  
  
void mousePressed(){
    
    ArrayList<Segment> nextGeneration = new ArrayList <Segment>();
    for ( Segment r : segments){
      Segment[] children = r.generate();
      addAll( children, nextGeneration);
    }
    
 segments = nextGeneration;
}
    
void draw(){
  
  background(255);
  translate(0, 100);
  stroke(0);
  strokeWeight(2);
  
  for( Segment r : segments){
    r.show();
  } 
}

  
