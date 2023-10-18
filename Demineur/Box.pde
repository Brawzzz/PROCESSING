class Box {
  
  int state; // -1 not discovered ; 0 discovered ; 1 flag ; 2 incertain
  int item;
  float size;
  int x;
  int y;
  
  Box create_box(int x , int y , float size){
     
    Box box = new Box();
    
    box.x = x * int(size);
    box.y = y * int(size);
    box.size = size; 
    
    box.item = 0;
    box.state = -1;
    
    return box;
  }
  
  void show(Box box){

    if(state == -1){
      square(box.x , box.y , box.size);
      image(BOX_, box.x , box.y , box.size , box.size);
    }
    
    else if(state == 2){
      square(box.x , box.y , box.size);
      image(DKNOW , box.x , box.y  , box.size , box.size);
    }
    
    else if(state == 1){
      fill(150);
      square(box.x , box.y , box.size);
      image(FLAG, box.x , box.y , box.size , box.size);
    } 
    
    else if(state == 2){
      fill(255 , 255 , 0);
      square(box.x , box.y , box.size);

    }
    
    else if(state == 0){
      
      stroke(255);
      
      if(box.item == 9){
        fill(255 , 0 , 0);
        square(box.x , box.y , box.size);
        image(BOMB, box.x , box.y , box.size , box.size);
      }
      
      else if(box.item == 0){
        fill(150);
        square(box.x , box.y , box.size);
      }
      
      //// NUMERO ///
      
      if(box.item == 1){
        fill(150);
        square(box.x , box.y , box.size);
        image(UN, box.x , box.y , box.size , box.size);
      }
      
      else if(box.item == 2){
        fill(150);
        square(box.x , box.y , box.size);
        image(DEUX, box.x , box.y , box.size , box.size);
      }
      
      else if(box.item == 3){
        fill(150);
        square(box.x , box.y , box.size);
        image(TROIS , box.x , box.y , box.size , box.size);
      }
      
      else if(box.item == 4){
        fill(150);
        square(box.x , box.y , box.size);
        image(QUATRE , box.x , box.y , box.size , box.size);
      }
      
      else if(box.item == 5){
        fill(150);
        square(box.x , box.y , box.size);
        image(CINQ , box.x , box.y , box.size , box.size);
      }
      
      else if(box.item == 6){
        fill(150);
        square(box.x , box.y , box.size);
        image(SIX, box.x , box.y , box.size , box.size);
      }
      
      else if(box.item == 7){
        fill(150);
        square(box.x , box.y , box.size);
        image(SEPT, box.x , box.y , box.size , box.size);
      }
      
      else if(box.item == 8){
        fill(150);
        square(box.x , box.y , box.size);
        image(HUIT, box.x , box.y , box.size , box.size);
      }
    }
  }
}
