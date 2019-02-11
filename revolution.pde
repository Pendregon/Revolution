PShape obj;
ArrayList<Point> array;
boolean transition;

void setup(){
   size(900,900,P3D);
   transition = false;
   array = new ArrayList<Point>();
}

void draw(){
  background(255); 
  if(!transition){
    printLines();
    printTextPreShape();
  }else if(transition){
    printTextPostShape();
    translate(mouseX,mouseY-height/2);
    shape(obj);
  }
}

void mouseClicked() {
  if(mouseButton == LEFT && !transition){
    array.add(new Point(mouseX,mouseY));
    
  }else if(mouseButton == RIGHT && !transition){
    translateXAxis();
    createCustomShape();
    transition=true;
  }else if(mouseButton == RIGHT && transition){
    transition = false;
    array = new ArrayList<Point>();
  }
}

void createCustomShape(){
   obj=createShape();
   
   obj.beginShape(TRIANGLE_STRIP);
   obj.fill(150);
   int desp = 20;
   for (int j = 0; j < array.size()-1;j++) {
     for(int i = 0;i<361;i+=desp){
       obj.vertex(array.get(j).getX()*cos(radians(i)), array.get(j).getY(), array.get(j).getX()*sin(radians(i)));
       obj.vertex(array.get(j+1).getX()*cos(radians(i)), array.get(j+1).getY(), array.get(j+1).getX()*sin(radians(i)));
     }
   }
   obj.endShape();
}

void printLines(){
  for (int i = 0;i<array.size();i++) {
    if(i>0){
      line(array.get(i-1).getX(),array.get(i-1).getY(),array.get(i).getX(),array.get(i).getY()); 
    }
  }
}

void printTextPreShape(){
  fill(0);
  text("Click en botón izquierdo para definir los puntos necesarios del perfil de la forma a revolucionar\nClick en botón derecho para generar la forma deseada",width/10,20);
}

void printTextPostShape(){
  fill(0);
  text("Click en botón derecho para volver al inicio",width/10,20);
}

void translateXAxis(){
  int aux = array.get(0).getX();
  for (Point p: array) {
    p.setX( p.getX()-aux < 0? 0: p.getX() - aux);
  }
  array.get(array.size()-1).setX(0);
}

class Point{
    int xCord,yCord;
    Point(int x, int y){
       xCord=x;
       yCord=y;
    }
    int getX(){
       return xCord; 
    }
    int getY(){
       return yCord; 
    }
    void setX(int value){
       xCord = value;
    }
}
