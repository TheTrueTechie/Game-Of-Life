class Block {
  final int blockSize = 10;
  int x; 
  int y;
  boolean alive;


  Block(int x, int y) {
    this.x = x;
    this.y = y;
  }
  void display() {
    if (alive == true) {
      fill(0);
    }
    if (alive == false) {
      fill(255);
    }
    rect(x*blockSize, y*blockSize, blockSize, blockSize);
  }
  void setAlive(boolean alive) {
    this.alive = alive;
  }

  public boolean isAlive() {


    return alive;
  }

  int getX() {
    return x;
  }
  int getY() {
    return y;
  }
}






Block[][] Grid = new Block[100][100];




void setup() {
  size(1000, 1000);
  for (int i = 0; i<Grid.length; i++) {
    for (int j = 0; j<Grid.length; j++) {
      Grid[i][j] = new Block(i, j);
      int x = (int)random(2);
      if (x == 0) {
        Grid[i][j].setAlive(true);
      }
      
    }
  }
  frameRate(30); 
}

ArrayList<Block> alive = new ArrayList<Block>(); 
ArrayList<Block> dead = new ArrayList<Block>(); 

void draw() { //<>//
rulesOfGame(); 
  int livingNeighbors = 0; 
  for (int row = 0; row< Grid.length-1; row++) {
    for (int col = 0; col< Grid.length-1; col++) {
      Grid[row][col].display();
      livingNeighbors = countNeighbors(getNeighbors(Grid[row][col]));
      if (livingNeighbors<2) {
        dead.add(Grid[row][col]);
      }
      if (livingNeighbors>3) {
        dead.add(Grid[row][col]);
      }


      if (livingNeighbors==3) {
        alive.add(Grid[row][col]);
      }
    }
  }
}


//Counts neighbors
public int countNeighbors(Block[] a) {
  int liveCount = 0; 
  for (Block b : a) {


    if (!(b==null)) {
      if (b.isAlive()) {
        liveCount ++;
      }
    }
  }

  return liveCount;
}
Block[] getNeighbors(Block a) {
  Block[] neighbors = new Block[8];
  int x = a.getX();
  int y = a.getY();
  int index = 0;
  if (!(x - 1 < 0 || y - 1 < 0 || x + 1 >= Grid.length || y + 1 >= Grid.length)) { //<>//
    for (int i = x-1; i<=x+1; i++) {
      for (int j = y-1; j<=y+1; j++) {
        if (!(x == i && y == j)) 
        {
          neighbors[index] = Grid[i][j];
          index++;
        }
      }
    }
  }
  return neighbors;
}


public void rulesOfGame() {
  for(Block a : dead) {
    a.setAlive(false); 
  }
  for(Block b : alive) {
   b.setAlive(true); 
  }
  
  alive = new ArrayList(); 
  dead.clear(); 
}

