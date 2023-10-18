
float e = 1;
float x = 0;
float y = 150;


ArrayList< Segment> segments;

void addAll (Segment[] arr, ArrayList< Segment>list){
  for( Segment r : arr){
  list.add(r);
  }
}
  

void setup(){
  //fullScreen();
 
  size(1000,1000);
  
  segments = new ArrayList< Segment>();
  
  PVector a = new PVector (100,100);
  PVector b = new PVector (900,100);
  PVector c = new PVector (500,800);
  
  Segment s1 = new Segment(a,b); 
  Segment s2 = new Segment(c,a);
  Segment s3 = new Segment(b,c);
  segments.add(s1);
  segments.add(s2);
  segments.add(s3);
  
 
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
  
  translate(x,y);
  scale(e);
  background(0);
  stroke(255);
  strokeWeight(5);
  
  for( Segment r : segments){
    r.show();
  } 
   
 
}
