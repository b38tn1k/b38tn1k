//int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787, #D0CBC3, #87B6C4, #EA4140, #5A5787};
//green = #7FB800
//int colors[] = {#F6511D, #FFB400, #00A6ED, #7FB800, #E56399, #FFFFFF};
//int colors[] = {#845EC2, #D65DB1, #FF6F91, #FF9671, #FFC75F, #F9F871};
//int colors[] = {#F6511D, #FFB400, #00A6ED, #E56399, #FFFFFF};

//int colors[] = {#FFFFFF, #1F4979, #AAC4CE, #D1D4D4, #919091, #F2822C, #F1F2F3}; //ford
//int colors[] = {#ff71ce, #05ffa1, #b967ff, #fffb96}; //vaporwave
int colors[] = {#B48277, #837C99, #8B6267, #A8264E, #ACA4A6}; //wb

PFont mono;
PFont smallfont;
  
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
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  background(#090E35);
  noStroke();
  int vert = 10;
  int hor = 10;
  
  char water[] = {'W', 'A', 'T', 'E', 'R'};
  char and[] = {'A', 'N', 'D'};
  char bridges[] = {'B', 'R', 'I', 'D', 'G', 'E', 'S'};
  char vs[] = {'V', 'S'};
  char b38tn1k[] = {'B', '3', '8', 'T', 'N', '1', 'K'};
  char free[] = {'F', 'R', 'E', 'E'};
  textFont(mono);
  textAlign(CENTER, CENTER);
  //int mycolor = #01cdfe;
  //int mycolor = #B31460;
  int mycolor =   #C67762;
  int subx = 0;
  int suby = 0;
  
  for (int j = 0; j < vert; j++) {
    for (int i = 0; i < hor; i++) {
      if (j == 0  && i < 5) {
        fill(mycolor);
        text(water[i], i*(width/hor) + width/(2*hor), j*(height/vert) + height/(2*vert));
      } else if  (j == 1  && i < 3){
        fill(mycolor);
        text(and[i], i*(width/hor) + width/(2*hor), j*(height/vert) + height/(2*vert));
      } else if  (j == 2  && i < 7){
        fill(mycolor);
        text(bridges[i], i*(width/hor) + width/(2*hor), j*(height/vert) + height/(2*vert));
      } else if  (j == 4  && i < 2){
        fill(mycolor);
        text(vs[i], i*(width/hor) + width/(2*hor), j*(height/vert) + height/(2*vert));
      } else if  (j == 6  && i < 7){
        fill(mycolor);
        text(b38tn1k[i], i*(width/hor) + width/(2*hor), j*(height/vert) + height/(2*vert));
      } else if  (j == 8  && i < 4){
        if (i == 0) {
          subx = i*(width/hor) + width/(2*hor);
          suby = j*(height/vert) + height/(2*vert);
        }
        fill(mycolor);
        text(free[i], i*(width/hor) + width/(2*hor), j*(height/vert) + height/(2*vert));
      } else {
        fill(rcol());
        invader(i*(width/hor) + width/(2*hor), j*(height/vert) + height/(2*vert), 6, random(5.0, 7.0), 8.0);
      }
    }
  }
  textAlign(LEFT, CENTER);
  textFont(smallfont);
  fill(mycolor);
  text("BAJA  ALL  TERRAIN  VERSION", subx - 21, suby + 8*6);
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
  float max = 0.0;
  //generate
  for (int i = 0; i < invLength; i++) {
    for (int j = 0; j < invHeight; j++) {
      // probability of pixel decreases radiating from grid[6][4]
      // random component
      //grid[i][j] = 0;
      grid[i][j] = random(2);
      // increase density towards horizontal center
      grid[i][j] = grid[i][j] + sin(radians(90*i/invLength)); 
      // increase density towards vertical center
      grid[i][j] = grid[i][j] + sin(radians(180*(j/invHeight)));  
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
      //print(nf(grid[i][j], 1, 2));
      //print(" ");
    }
    //print("\n");
  }
  //print("Sum: ");
  //print(sum);
  //print(" Count: ");
  //print(count);
  //print(" Average: ");
  //print(average);
  //print("\n");
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
      }
      ypos += pixelSize;
    }
    ypos = 0;
    xpos += pixelSize;
  }
  popMatrix();
}

void setup() {
  size(1080, 1080, P3D);
  smooth(8);
  pixelDensity(2);
  background(0);
  mono = createFont("bit.TTF", 80);
  smallfont = createFont("bit.TTF", 40);
  generate();
  noStroke();
}

void mouseClicked() {
 invader(mouseX, mouseY, 10, 6.0, 8.0); 
}

void draw() {
  //generate();
}
