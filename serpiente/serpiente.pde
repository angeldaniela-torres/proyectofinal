int filas = 40;
int columnas = 40;
int bs = 20;

ArrayList<Integer> posX = new ArrayList<Integer>();
ArrayList<Integer> posY = new ArrayList<Integer>();

int dir = 1;
int[] dx = {0, 0, -1, 1};
int[] dy = {-1, 1, 0, 0};

int appleX;
int appleY;

boolean gameOver = false;

void setup(){
  size (600, 600); //Aqui cambio solo el tamaño
  fill(0);
  posX.add(10);
  posY.add(10);
  frameRate(7);//se mueve la serpiente
  appleX = (int) random (0, 20); //Aqui se cambia el tamaño de lo que se comera y sera aleatorio
  appleY = (int) random (0, 20);
}

void draw (){
  background (25);
  if(gameOver == true){
   fill(75);
   textSize(20);
   text("Preciona ESPACIO para comenzar", 20, height/2);
   appleX = -1;
   appleY = -1;
   posX.clear();
   posY.clear();
   posX.add(-10);
   posY.add(-10);
   
  }else{
    stroke(50);
    for(int i =0; i < filas; i++){
      line(0, i*bs, width, i*bs);
    }
    for(int j = 0; j < columnas; j++) {
    line (j*bs, 0, j*bs, height);
    }
    
  
  }
  mover();
  eat();
  detectarBordes();
  detectarSnake();
  drawApple();
  drawSnake();

} 

void detectarBordes(){
  if((posX.get(0) < 0) || (posX.get(0) >  columnas -1) || (posY.get(0) < 0) || (posY.get(0) > filas -1)){
    gameOver = true;
  }
}

void detectarSnake (){ //morir cuando choca consigo misma
  for (int i = 2; i < posX.size(); i++){
  for (int j = 2; j < posY.size(); j++){
   if((posX.get(0) == posX.get(i)) && (posY.get(0) == posY.get(i))){
     gameOver = true;
   }
    }
  }
}

void mover(){
  posX.add(0, posX.get(0)+dx[dir]);
  posY.add(0, posY.get(0)+dy[dir]);
  posX.remove(posX.size()-1);
  posY.remove(posY.size()-1);
}

void drawSnake(){
  fill(40,50, 230);
  for(int i = 0; i < posX.size(); i++){
    rect(posX.get(i)*bs, posY.get(i)*bs, bs, bs);
  }
}

void eat(){
  if((posX.get(0) == appleX) && (posY.get(0) == appleY)){
  appleX = (int) random (0, 20); 
  appleY = (int) random (0, 20);
  posX.add(posX.get (posX.size()-1));
  posY.add(posY.get (posY.size()-1));
  }
}

void drawApple(){
  fill(215, 0, 75);
rect(appleX * bs, appleY * bs, bs, bs); //funcion para dibujar manzana
}

void restart(){
  gameOver = false;
  posX.clear();
  posY.clear();
  posX.add(5);
  posY.add(5);
  appleX = (int) random (0,20);
  appleY = (int) random (0,20);
}

void keyPressed(){
  if(key == 'w' || keyCode == UP) dir = 0;//arriba
  if(key == 's' || keyCode == DOWN) dir = 1;//abajo
  if(key == 'a' || keyCode == LEFT) dir = 2;//izquierda
  if(key == 'd' || keyCode == RIGHT) dir = 3;//derecha
  if(key == ' '){
    restart();
  }
}
