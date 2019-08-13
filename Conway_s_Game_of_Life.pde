import java.util.Random;


Cell[][] grid;

// side length of each cell
int s = 10;

int dx[] = {1, -1, 0, 0, 1, -1, 1, -1}, dy[] = {0, 0, 1, -1, 1, -1, -1, 1};

// the start variable will allow the user to pause and start the program to add new cells or change the color of a cell
boolean start = false;


void setup(){

  size(801, 801);
  int r = width/s, c = height/s;
  System.out.println(r); 
  System.out.println(c);
  grid = new Cell[r][c];
  for(int i = 0; i < r; i++)
    for(int j = 0; j < c; j++)
      grid[i][j] = new Cell(i*s, j*s, s, s);
}


void draw(){
  
  background(0);
  int r = width/s, c = height/s;
  
  if(mousePressed){
    grid[(int)mouseX/s][(int)mouseY/s].clicked();
  }
  
  if(keyPressed){
    if(key == 'a')
      start = (!start);
    else if(key == 'c')
      clearGrid(r, c);
  }
  
  for(int i = 0; i < r; i++)
    for(int j = 0; j < c; j++)
      grid[i][j].display();
      
  if(start){
    System.out.println("working");
    update(grid, r, c);
  }

}


void clearGrid(int r, int c){
  for(int i = 0; i < r; i++)
    for(int j = 0; j < c; j++)
      {grid[i][j].r = 0; grid[i][j].g = 0; grid[i][j].b = 0;}
}


boolean valid(int a, int b, int r, int c){
  return (a >= 0) && (a < r) && (b >= 0) && (b < c); 
}

void update(Cell[][] g, int row, int col){
 
   for(int i = 0; i < row; i++)
     for(int j = 0; j < col; j++){
       int alive = 0;
       for(int k = 0; k < 8; k++){
         int ni = i + dx[k], nj = j+dy[k];
         if(valid(ni, nj, row, col) && !g[ni][nj].isBlack())
           alive++;
       }
       if(!g[i][j].isBlack()){
         if(alive < 2) g[i][j].turnOff();
         else if(alive > 3) g[i][j].turnOff();
       }
       else if(alive == 3)
          g[i][j].clicked();
     }
}


class Cell{
  
  float x, y;
  float w, h;
  int r, g, b;
  
  Cell(float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void turnOff(){
    r = 0; g = 0; b = 0;
  }
  void clicked(){ 
    Random rand = new Random();
    r = rand.nextInt(255); g = rand.nextInt(255) ; b = rand.nextInt(255);
    r++;g++;b++;
  }

  boolean isBlack(){
    if(r != 0 || g != 0 || b != 0)
      return false;
    return true;
  }

  void display(){
    stroke(105,105,105);
    fill(r, g, b);
    rect(x, y, w, h);
  }



}
