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
  String timestamp = "monster_" + str(random(1.0));
  saveFrame(timestamp+".png");
  generate();
}


void generate() {
  background(bg);
  fill(green);
  stroke(green);
  noStroke();
  invader((width/4), (height/2), 3, random(5.0, 7.0), 8.0);
}

void invader(int x, int y, int pixelSize, float invLength, float invHeight) {
  invLength = float(int(invLength));
  invHeight = float(int(invHeight));
  //crab 8 x 11
  //squid 8 x 8
  //octopus 8 x 12
  //float invLength = 4.0; // use these to calculate translation later
  //float invLength = 6.0; // use these to calculate translation later
  //float invHeight = 8.0;
  float grid[][] = new float[int(invLength)][int(invHeight)];
  float grid2[][] = new float[int(invLength)][int(invHeight)];
  float max = 0.0;
  //generate
  for (int i = 0; i < invLength; i++) {
    for (int j = 0; j < invHeight; j++) {
      // probability of pixel decreases radiating from grid[6][4]
      // random component
      //grid[i][j] = 0;
      grid[i][j] = random(2);
      grid2[i][j] = random(2.5);
      // increase density towards horizontal center
      grid[i][j] = grid[i][j] + sin(radians(90*i/invLength));
      //grid2[i][j] = grid[i][j] + sin(radians(90*i/invLength));
      
      // increase density towards vertical center
      grid[i][j] = grid[i][j] + sin(radians(180*(j/invHeight)));
      //grid2[i][j] = grid[i][j] + sin(radians(180*(j/invHeight)));
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
      grid2[i][j] = grid2[i][j]/max;
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
    for (int j = 0; j < invHeight; j++) {
      if (grid[i][j] > threshhold) {
        rect(xpos, ypos, pixelSize, pixelSize);
        rect(xpos + width/2, ypos, pixelSize, pixelSize);
      }
      
      if (grid2[i][j] > threshhold) {
        rect(xpos + width/2, ypos, pixelSize, pixelSize);
      }
      
      ypos += pixelSize;
    }
    ypos = 0;
    xpos += pixelSize;
  }
  int invlen = int(invLength) - 1;
  for (int i = 0; i < invLength; i++) {
    for (int j = 0; j < invHeight; j++) {
      if (grid[invlen- i][j] > threshhold) {
        rect(xpos, ypos, pixelSize, pixelSize);
        rect(xpos + width/2, ypos, pixelSize, pixelSize);
      }
      
      if (grid2[invlen- i][j] > threshhold) {
        rect(xpos + width/2, ypos, pixelSize, pixelSize);
      }
      ypos += pixelSize;
    }
    ypos = 0;
    xpos += pixelSize;
  }
  popMatrix();
}

void setup() {
  size(100, 50, P3D);
  //noSmooth();
  //pixelDensity(1 );
  background(bg);
  generate();
}

void mouseClicked() {
 //invader(mouseX, mouseY, 10, 6.0, 8.0); 
}

void draw() {
  //generate();
}
