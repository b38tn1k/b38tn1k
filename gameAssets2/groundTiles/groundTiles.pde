//int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787, #D0CBC3, #87B6C4, #EA4140, #5A5787};
int green = #7FB800;
int bg = #FF00FF;
int colors[] = {#F6511D, #FFB400, #00A6ED, #7FB800, #E56399, #FFFFFF};
//int colors[] = {#845EC2, #D65DB1, #FF6F91, #FF9671, #FFC75F, #F9F871};
//int colors[] = {#F6511D, #FFB400, #00A6ED, #E56399, #FFFFFF};

//int colors[] = {#FFFFFF, #1F4979, #AAC4CE, #D1D4D4, #919091, #F2822C, #F1F2F3}; //ford
int rcol() {
  return colors[int(random(colors.length))];
};

int rcolsub(int colors[], int len) {
  return colors[int(random(len))];
};

boolean coin() {
  return random(1) > .5;
}

int randint(int x) {
  return int(random(x));
}

void keyPressed() {
  if (key == 's') {
    saveImage();
  } else {
    generate();
  }
}

void saveImage() {
  String timestamp = "border_" + str(random(1.0));
  saveFrame(timestamp+".png");
  generate();
}

void generate() {
  background(bg);
  fill(green);
  stroke(green);
  noStroke();
  invader(30, (height/2), 3, 10, 10);
}

void invader(int x, int y, int pixelSize, float invLength, float invHeight) {
  invLength = float(int(invLength));
  invHeight = float(int(invHeight));
  float grid[][] = new float[int(invLength)][int(invHeight)];
  float max = 0.0;
  //generate
  for (int i = 0; i < invLength; i++) {
    for (int j = 0; j < invHeight; j++) {
      // probability of pixel decreases radiating from grid[6][4]
      // random component
      grid[i][j] = random(2);
      // increase density towards middle
      //grid[i][j] = grid[i][j] + sin(radians(i/invLength));
      // increase density towards vertical bottom
      grid[i][j] = grid[i][j] + sin(radians(90*(j/invHeight)));
      // reduce density near eye areas
      // end of generating
      if (grid[i][j] > max) {
        max = grid[i][j];
      }
    }
  }
  //scale and prepare for threshold
  float sum = 0;
  int count = 0;
  for (int i = 0; i < invLength; i++) {
    for (int j = 0; j < invHeight; j++) {
      grid[i][j] = grid[i][j]/max;
      sum += grid[i][j];
      count++;
    }
  }
  float average = sum/count;
  float threshhold = average;
  int xpos = 0;
  int ypos = 0;
  pushMatrix();
  translate(x - pixelSize*int(invLength), y - pixelSize*int(invHeight/2));
  
  //translate(x, y);
  //translate etc
  for (int i = 0; i < invLength; i++) {
        //for (int j = 0; j < invHeight; j++) {
    for (int j = int(invHeight-1); j > 0; j--) {
      if (grid[i][j] > threshhold) {
        for (int thisx = xpos; thisx <= width; thisx+=pixelSize*invLength*2){  
          rect(thisx, ypos, pixelSize, pixelSize);
        }
      }
      
      ypos += pixelSize;
    }
    ypos = 0;
    xpos += pixelSize;
  }
  int invlen = int(invLength) - 1;
  for (int i = 0; i < invLength; i++) {
    //for (int j = 0; j < invHeight; j++) {
    for (int j = int(invHeight-1); j > 0; j--) {
      if (grid[invlen- i][j] > threshhold) {
        for (int thisx = xpos; thisx <= width; thisx+=pixelSize*invLength*2){  
          rect(thisx, ypos, pixelSize, pixelSize);
        }
      }

      ypos += pixelSize;
    }
    ypos = 0;
    xpos += pixelSize;
  }
  popMatrix();
}

void setup() {
  size(1000, 30, P3D);
  smooth(8);
  pixelDensity(2);
  background(bg);
  generate();
}

void mouseClicked() {
 //invader(mouseX, mouseY, 10, 6.0, 8.0); 
}

void draw() {
  //generate();
}
