int count = 0;
int boum = 0;

float box_size;

boolean ok = false;

Box box = new Box();
Mode mode = new Mode();

ArrayList<Box> boxes = new ArrayList<Box>();

PImage BOX_;
PImage BEGIN;

PImage UN;
PImage DEUX;
PImage TROIS;
PImage QUATRE;
PImage CINQ;
PImage SIX;
PImage SEPT;
PImage HUIT;

PImage FLAG;
PImage BOMB;
PImage DKNOW;

PImage GAME_OVER;
PImage VICTORY;
PImage BUTTON;

/////////////////////////////////////////////////

int control(ArrayList<Box> boxes , int current_index , int line , int column , int current_line , int current_column){
  
  int control = 0;
  
  if(current_index >= boxes.size() || current_index < 0 || boxes.get(current_index).item == 9 || boxes.get(current_index).state == 1  ){
    control = 1;
  }
  else if(current_line >= line + 2 || current_line <= line - 2 || current_column >= column + 2 || current_column <= column - 2 ){
    control = 2;
  }
  else{
   control = 0; 
  }
  
  return control; 
}

void place_the_bomb(ArrayList<Box> boxes){
  
 int random_index = 0;
 int curent_index = 0;
 
 int control = 0;
 
 int line = 0;
 int column = 0;
 
 int curent_line = 0; 
 int curent_column = 0;

 for(int i = 0 ; i < mode.nmb_bomb ; i++){
   
   do{
     random_index = int(random(boxes.size()));
   }while(boxes.get(random_index).item > 8 );
   
   boxes.get(random_index).item = 9;
   
   line = random_index / int(mode.side);
   column = random_index % mode.side;
   
   for(int j = -mode.side ; j <= mode.side ; j += mode.side){
     for(int k = -1 ; k <= 1 ; k ++){
       
       curent_index = random_index+j+k; 
       
       curent_line = (random_index+j+k) / int(mode.side); 
       curent_column = (random_index+j+k) % int(mode.side); 
      
       control = control(boxes , curent_index , line , column , curent_line , curent_column);
  
       if(control == 0){        
         boxes.get(random_index+j+k).item += 1;
       }
     }
   }
 }
}

void fill_board(ArrayList<Box> boxes , float box_size){
    
  Box box = new Box();
  boxes.clear();
  
  for(int j = 0 ; j < mode.side ; j++){
    for(int i = 0 ; i < mode.side ; i++){

    box = box.create_box(i , j , box_size);
    boxes.add(box);
      
    }
  }
  place_the_bomb(boxes);
}

void discover(Box box , int index , ArrayList<Box> boxes){
  
  int control = 0;
  Box curent_box = new Box();
   
  int curent_index = 0;
  
  int line = index / int(mode.side);
  int column = index % mode.side;
 
  int curent_line = 0; 
  int curent_column = 0;
  
  if(box.state == 1){
   return; 
  }
  
  else if(box.state == 0){
    return;
  }
  
  else if(box.state == -1){
    
    if(box.item == 9){
      box.state = 0;
      boum = 1;
    }
    
    else if(box.item > 0 && box.item < 9){
      box.state = 0;
      return;
    }
    
    else if(box.item == 0){
      
      box.state = 0;
      
      for(int j = -mode.side ; j <= mode.side ; j += mode.side){
        for(int k = -1 ; k <= 1 ; k ++){
          
          curent_index = index + (j+k);
         
          curent_line = curent_index / int(mode.side); 
          curent_column = curent_index % int(mode.side); 
          
          control = control(boxes , curent_index , line , column , curent_line , curent_column);
          
          if(control == 0){
           curent_box = boxes.get(curent_index);
           discover(curent_box , curent_index , boxes);
           
          }
        }
      }  
    }
  }
} 

void flag(Box box){
  
  if(mode.nmb_flag > 0){
    if(box.state == -1){
     box.state = 1;
     mode.nmb_flag--;
    }
    else if(box.state == 1){
       box.state = 2;
       mode.nmb_flag++;
    }
    else if(box.state == 2 ){
      box.state = -1;
    }
  }
}

void click_on_a_box(Box box , ArrayList<Box> boxes){
  
  int posX = 0;
  int posY = 0;
  int index = 0;
  
  posX = (mouseX/int(box_size));
  posY = (mouseY/int(box_size));
  
  index = posX + posY * mode.side;
  box = boxes.get(index);
  
  if(mouseButton == LEFT ){
    discover(box , index , boxes);
  }
    
  else if(mouseButton == RIGHT ){
    flag(box);
  }
}

void get_mode(){
  
  mode.side = 0;
  mode.nmb_bomb = 0;
  
  if(mouseX > 60 && mouseX < 375 && mouseY > 443  && mouseY < 538){
    mode.side = 9;
    mode.nmb_bomb = 10;
    mode.nmb_flag = mode.nmb_bomb;
    
    box_size = width/float(mode.side);
    fill_board(boxes , box_size);
    
    ok = true;
  }
  else if(mouseX > 495 && mouseX < 765 && mouseY > 443 && mouseY < 815){
    mode.side = 16;
    mode.nmb_bomb = 40;
    mode.nmb_flag = mode.nmb_bomb;
    
    box_size = width/float(mode.side);
    fill_board(boxes , box_size);
    
    ok = true;
  }
}

int is_finish(ArrayList<Box> boxes){
  
  int count = 0;
  
  for(Box box : boxes){
    if(box.state == -1 && (box.item >= 0 && box.item < 9) ){
      count ++;
    } 
  }
  return count;
}

void choice(){
  
  if(mouseX > 55 && mouseX < 375 && mouseY > 443  && mouseY < 538){
    boum = 0;
    ok = false;
  }
  else if(mouseX > 480 && mouseX < 805 && mouseY > 445 && mouseY < 540){
    exit();

  } 
}

void setup(){
  
  BOX_ = loadImage("BOX.png");
  BEGIN = loadImage("BEGIN.png");
  
  UN = loadImage("UN.png");
  DEUX = loadImage("DEUX.png");
  TROIS = loadImage("TROIS.png");
  QUATRE = loadImage("QUATRE.png");
  CINQ = loadImage("CINQ.png");
  SIX = loadImage("SIX.png");
  SEPT = loadImage("SEPT.png");
  HUIT = loadImage("HUIT.png");
  
  BOMB = loadImage("BOMB.png");
  FLAG = loadImage("FLAG.png");
  DKNOW = loadImage("DKNOW.png");
  
  GAME_OVER = loadImage("GAME_OVER.png");
  VICTORY = loadImage("VICTORY.png");
  BUTTON = loadImage("PLAY_AGAINouEXIT.png");
  
  size(850, 850);
  background(255);
  
}

void draw(){
  
  float rest = 0;  //<>//
  
  if(ok == false){
    image(BEGIN,0,0);
  }
  
  //println(box_size);
  //println(ok);
  //println("boxes : " + boxes.size());
    
  if(ok == true){
  
    rest = width%mode.side; 
  
    if(rest != 0){
      translate(rest/2 , rest/2);
    }
    
    count = is_finish(boxes);
    //println("count : " + count + " nmb_flag : " + mode.nmb_flag);
  
    if(count > 0){
      
      for(Box box : boxes){
        box.show(box);
      }
    }
    
    else if(count == 0){
      for(Box box : boxes){
        box.show(box);
      }
      image(VICTORY , 0 , 0); 
      image(BUTTON , 0 , 0);
    }
    
    if(boum == 1){
      for(Box box : boxes){
        if(box.item == 9){
          box.state = 0;
        }
      }
      image(GAME_OVER , 0 , 0);
      image(BUTTON , 0 , 0);
    }
  }
}

void mouseReleased(){
  
  if(!ok){
    get_mode();
  }
  
  else{
    if(count > 0 && boum != 1){
      click_on_a_box(box , boxes);
    }
    
    else if( count == 0 || boum == 1){
      choice();
    }
  }
}
