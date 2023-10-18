int width = 1000;
int height = 1000;

int n_min = 0;
int n_max = 2;
int Un_min = 0;
int Un_max = 2;

int i_min = -10;
int i_max = 10;
int yi_min = -10;
int yi_max = 10;

int x_min = 1 * (-width/2);
int x_max = 1 * width/2;
int y_min = 1 * (-height/2);
int y_max = 1 * height/2;

int N_iterations = 15;
  
void setup(){
  
  size(1000 ,1000 , P3D);
  background(255);
  
  translate(width/2,height/2);
  rotateX(-PI);
  
   // red = x
  stroke(0,0,0);
  line(-width/2,0,width/2,0);
  //green = y
  stroke(0,0,0);
  line(0,-height/2,0,height/2);
  
  // TORK
  for(int i = -height/2 ; i < height/2 ; i += 100){ 
    fill(0);
    stroke(0);
    circle(i,0,2);
    circle(0,i,2);
  }
 
  //SUITES de FONCTIONS
  float forward_i = 0;
  float forwards_fn_i = 0;
  
  float fn_i = 0;
  
  float forward_x = 0;
  float forwards_fn = 0;
  
  float x = 0;
  float fn = 0;
  
  float incr = 0.001;
  
  int k = 3;
  
  for(int n = 1 ; n < N_iterations ; n += 1){  //<>//
    forwards_fn_i = 0;
    
    color c = color(random(40 , 255) , random(40 , 255) , 0);
    
    for(float i = i_min ; i < i_max ; i += incr){  //<>//
      
      forward_i = i + incr;
      
      fn_i = 1 / pow(n , i);
      forwards_fn_i = 1 / pow(n , forward_i);
      
      //println(fn_i);
      x = x_min + (x_max - x_min) * ( (i - i_min)/(i_max - i_min) );
      fn = y_min + (y_max - y_min) * ( (fn_i - yi_min)/(yi_max - yi_min) );
      
      forward_x = x_min + (x_max - x_min) * ( (forward_i - i_min)/(i_max - i_min) );
      forwards_fn = y_min + (y_max - y_min) * ( (forwards_fn_i - yi_min)/(yi_max - yi_min) );
      
      //println(fn);
      
      stroke(c);
      fill(c);
      //circle(x , fn , 1.5);
      line(x , fn , forward_x , forwards_fn);
    }
  }
  

}

void draw(){
  

  /*
  // SUITES
    for(int n = 0 ; n < n_max ; n += 1){ 
    float Un = n * n;
    
    float x = x_min + (x_max - x_min) * ( (float(n - n_min)) / (n_max - n_min) ) ; 
    float y = y_min + (y_max - y_min) * ( (Un - Un_min) / (Un_max - Un_min) ) ; 
    
    println("x : " + x + "y : " + y);
    fill(0);
    circle(x , y , 3);
  }
  
  // FONCTION
  for(float i = i_min ; i < i_max ; i += 0.01){  
    
    float yi = i * i;
    
    float x = x_min + (x_max - x_min) * ( (i - i_min)/(i_max - i_min));
    float y = y_min + (y_max - y_min) * ( (yi - yi_min)/(yi_max - yi_min));
   
    fill(0);
    circle(x , y , 3);
  }
  */


  
}
