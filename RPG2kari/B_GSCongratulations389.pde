// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Julian Leeさん
// 【作品名】Fog
// https://openprocessing.org/sketch/737345
//

class GameSceneCongratulations389 extends GameSceneCongratulationsBase {
  /*
Julian Lee
   7/15/19
   I implemented Mohamed S. Ebeida's Maximal Poisson-Disk Sampling algorithm in two dimensions. Selected points are stored in a grid, and active cells are stored as children of
   a "flat quadtree". There is a vector for these "quadtrees", 1 for each square in the original grid so that the entire quadtree can be removed if a point is selected within it.
   As all active cells are the same size, these cells are simply stored as PVectors. Active cells split at each itteration after a sufficient number of misses. To determine
   if one of these cells resulting from the split is active, the algorithm checks if a single circle passes through all four corners. Only nearby circles are examined when testing if point(s) lie within a circle,
   and the algorithm terminates if there are no more active cells or if the cell size is less than the precision of the floating point.
   A weighted probability is used when picking a flat quadtree to throw a dart to ensure complete randomness.
   
   I thought the output of the algorithm would be useful to create some type of texture, so after experimenting with different ways to manipulate the points to create a background, I decided to
   create layers of "fog" by drawing translucent circles with a small radius whose centers were based of the output from the algorithm. Objects could be drawn between layers of fog to
   make these objects seem more distant in an image. I applied this concept with a "city landscape" at night where closer buildings, which were lower in the y-positions of their bottom edges,
   would be covered in less layers of fog than farther buildings. Lights for the windows of the buildings are generated at random (based on windowProbability), and the positions of the buildings
   also change with every piece. One of 2 color options is randomly chosen for every piece.
   
   If radius is reduced to 15, there is a better produced image (the edges of the circles can no longer be seen in the fog). However,
   there is a slow runtime as the frame is relatively large, the algorithm is being run multiple times, and the minimum distance between points for the algorithm is also relatively small.
   
   */

  int radius = 25;
  float windowProbability = 0.3;
  boolean bColor = false;//color option (2) chosen at random by program

  @Override void setup() {
    background(0);
    if (random(1) < 0.5)
      bColor = true;
  }
  @Override void draw() {
    push();
    randomSeed(5963);
    
    for (int y = 300; y < height; y += 40 + random(10) - 5) {//bottom y coordinate of each row of buildings: this loop runs for each row of buildings
      for (int x = 10; x < width - 10; x += 30 + random(20) - 20) {//top left corner, the value added to x creates a gap between buildings
        if (y > height - 50)
          y = height - 5;//make sure we get a row of buildings at the bottom of the screen
        int h, w = 60 + (int)random(20) - 10;//height and width of the building
        if (random(1) < 0.6)//short building
          h = 100 + (int)random(70) - 35;
        else//tall building
          h = 200 + (int)random(100) - 35;
        if (h < w)//make sure the building is taller than it is wide
          h = w + 10;
        if (h > height - 10)//stop building from going above the top edge of the screen
          h = height - 10;
        generateBuilding(x, x+w, y - h, y);
        x += w;
      }
      fill(50, 255);
      rect(0, y, width, height-y);//adds dark rectangle under the current row of buildings as "flooring"
      fog(radius);//fog created by the mps algorithm
    }
    fog(radius);
    filter(BLUR, 1);//filter to further the fog effect
    // noLoop()呼ばれるとこっちの都合が。。。(^-^;;
    // ⇒呼ばないようにしよう＼(^_^)／
    //noLoop();
    pop();

    logoRightLower(#ff0000);
  }
  PVector[][] grid;//stores points found so far
  ArrayList<QuadTree> activeCells;//stores activeCells (1 QuadTree element for each grid as specified in the paper)
  int numActive;//number of active cells
  int rad;
  int cellSize, initCellSize;
  float EPSILON = 10e-12;
  ArrayList<PVector> MPS(int radius) {//returns all points in sample
    rad = radius;
    initCellSize = (int) (rad / sqrt(2));
    cellSize = initCellSize;
    grid = new PVector[width/initCellSize+1][height/initCellSize+1];
    numActive = grid.length*grid[0].length;
    //initialize quadTree
    activeCells = new ArrayList<QuadTree>();
    for (int i = 0; i < grid.length; i++)
      for (int j = 0; j < grid[0].length; j++)
        activeCells.add(new QuadTree(new PVector(i*initCellSize, j*initCellSize)));
    //start of main algorithm
    int i = 0;
    while (numActive > 0) {
      throwDarts(0.4);//multiplier for how many misses must occur before darts stop being thrown
      if (cellSize < EPSILON)//need to break before total loss in precision
        break;
      //subdivide cells
      cellSize /= 2;
      numActive = 0;//recalculate the number of active cells
      for (int j = 0; j < activeCells.size(); j++) {
        activeCells.get(j).split();
        numActive += activeCells.get(j).size();
        if (activeCells.get(j).size() == 0)//no longer an active cell
          activeCells.remove(j--);
      }
    }
    //add all found points to an arrayList
    ArrayList<PVector> ret = new ArrayList<PVector>();
    for (i = 0; i < grid.length; i++)
      for (int j = 0; j < grid[0].length; j++)
        if (grid[i][j] != null)
          if (grid[i][j].x > i*initCellSize && grid[i][j].y > j*initCellSize && grid[i][j].x < (i+1)*initCellSize && grid[i][j].y < (j+1)*initCellSize)
            ret.add(new PVector(grid[i][j].x, grid[i][j].y));
    return ret;
  }

  void throwDarts(float a) {
    int misses = 0;
    int originalNumActive = numActive;
    while (misses < originalNumActive*a) {
      //chose cell to throw a dart
      int rand = (int)random(numActive), idx = 0;
      if (activeCells.size() == 0) //if done with algorithm
        break;
      while (rand > activeCells.get(idx).size()) {//find randomly selected cell using weights based on area (number of cells each quadtree holds)
        rand -= activeCells.get(idx).size();
        idx++;
      }
      int cellIdx = (int)random(activeCells.get(idx).size());//randomly select a cell within the qudtree
      PVector cell = activeCells.get(idx).children.get(cellIdx);//this is the selected cell
      PVector randomPt = new PVector(cell.x + random(cellSize), cell.y + random(cellSize));//getting random pt within the chosen cell
      //see if the dart is a hit or miss
      if (diskFree(randomPt, activeCells.get(idx).xIdx(), activeCells.get(idx).yIdx())) {
        grid[activeCells.get(idx).xIdx()][activeCells.get(idx).yIdx()] = randomPt;
        numActive -= activeCells.get(idx).size();
        activeCells.remove(idx);//entire cell can be removed
      } else {
        misses++;
      }
    }
  }

  float distance(float x1, float x2, float y1, float y2) {
    return sqrt(pow(abs(x1 - x2), 2) + pow(abs(y1 - y2), 2));
  }

  boolean diskFree(PVector pt, int xIdx, int yIdx) {//indicies of square of interest
    //only check close by disks
    for (int i = max(xIdx - 3, 0); i < min(xIdx + 3, grid.length); i++) {//max and min functions prevent going out of bounds
      for (int j = max(yIdx - 3, 0); j < min(yIdx + 3, grid[0].length); j++) {
        if (grid[i][j] != null) {
          if (distance(grid[i][j].x, pt.x, grid[i][j].y, pt.y) < rad) {//comparison between chosen point and a previous point on the grid
            return false;
          }
        }
      }
    }
    return true;
  }

  boolean filled(PVector pt, int xIdx, int yIdx) {//returns true if a cell is filled
    //see if any close circle hits all 4 corners of the square
    for (int i = max(xIdx - 3, 0); i < min(xIdx + 3, grid.length); i++) {
      for (int j = max(yIdx - 3, 0); j < min(yIdx + 3, grid[0].length); j++) {
        if (grid[i][j] != null) {
          if (distance(grid[i][j].x, pt.x, grid[i][j].y, pt.y) < rad && distance(grid[i][j].x, pt.x+cellSize, grid[i][j].y, pt.y) < rad && distance(grid[i][j].x, pt.x, grid[i][j].y, pt.y+cellSize) < rad && distance(grid[i][j].x, pt.x+cellSize, grid[i][j].y, pt.y+cellSize) < rad) {
            return true;
          }
        }
      }
    }
    return false;
  }

  class QuadTree {//one quadtree for each cell, stores active cells
    ArrayList<PVector> children;//holds the top left point of all active cells of the quadtree
    PVector location;//top left corner of this quadtree
    QuadTree(PVector topLeft) {
      location = new PVector(topLeft.x, topLeft.y);
      children = new ArrayList<PVector>();
      children.add(new PVector(topLeft.x, topLeft.y));
    }
    void split() {
      for (int i = children.size() - 1; i >= 0; i--) {//for each child, split into four quadrants
        PVector curr = children.get(i);
        if (!filled(new PVector(curr.x, curr.y), this.xIdx(), this.yIdx()))//top left quadrant of previous cell is not filled by a single circle
          children.add(new PVector(curr.x, curr.y));
        if (!filled(new PVector(curr.x+cellSize, curr.y), this.xIdx(), this.yIdx()))//top right
          children.add(new PVector(curr.x+cellSize, curr.y));
        if (!filled(new PVector(curr.x, curr.y+cellSize), this.xIdx(), this.yIdx()))//bottom left
          children.add(new PVector(curr.x, curr.y+cellSize));
        if (!filled(new PVector(curr.x+cellSize, curr.y+cellSize), this.xIdx(), this.yIdx()))//bottom right
          children.add(new PVector(curr.x+cellSize, curr.y+cellSize));
        children.remove(i);//remove the cell that has been examined (as all cells must have the same size after the split, so this cell's size is too large)
      }
    }
    int size() {
      return children.size();
    }
    int xIdx() {
      return (int)(location.x / initCellSize + 0.5);
    }
    int yIdx() {
      return (int)(location.y / initCellSize + 0.5);
    }
  }

  void generateBuilding(float x1, float x2, float y1, float y2) {
    noStroke();
    int w = int(x2 - x1), h = int(y2 - y1), border = 4;
    //black rectangle represents the building
    fill(50+(int)random(20));
    rect(x1-border, y1-border, w+border*2, h+border*2);
    //calculate the number of x and y windows to be displayed on the building (with some randomness)
    float numXWindow = w/7 + (int)random(5) - 2, numYWindow = h/7 + (int)random(5) - 2, windowW = ((w - numXWindow*(border-1))/numXWindow), windowH = ((h - numYWindow*(border-1))/numYWindow);
    fill(255, 255, 153);
    for (float i = x1; i < x2 - border; i+= border + windowW) {
      for (float j = y1; j < y2 - border; j+= border + windowH) {
        //only display some windows based on windowProbability
        if (random(1) < windowProbability)
          rect(i, j, windowW, windowH);
      }
    }
  }

  void fog(int rad) {
    //get points from MPS
    ArrayList<PVector> pts = MPS(rad);
    noStroke();
    if (bColor)//shows fog as tinted purple to give a nightime feel
      fill(225, 225, 255, 5);
    else
      fill(255, 10);
    for (PVector pt : pts)//display points
      ellipse(pt.x, pt.y, rad*3, rad*3);
  }
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
