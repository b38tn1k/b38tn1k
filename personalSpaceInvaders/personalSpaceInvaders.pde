//int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787, #D0CBC3, #87B6C4, #EA4140, #5A5787};
//green = #7FB800
int colors[] = {#F6511D, #FFB400, #00A6ED, #7FB800, #E56399, #FFFFFF};
//int colors[] = {#F6511D, #FFB400, #00A6ED, #E56399, #FFFFFF};
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
  // 11x5 grid of invaders
  // bunkers
  // tank
  
  background(0);
  noStroke();
  //for (int j = 0; j < 25; j++) {
  //  for (int i = 0; i < 25; i++) {
  //    fill(rcol());
  //    invader(i*(width/25) + width/50, j*(height/25) + height/50, 3, random(5.0, 7.0), 8.0);
  //  }
  //}
  
  int vert = 5;
  int hor = 5;
  
  for (int j = 0; j < vert; j++) {
    for (int i = 0; i < 25; i++) {
      fill(rcol());
      invader(i*(width/hor) + width/(2*hor), j*(height/vert) + height/(2*vert), 10, random(5.0, 7.0), 8.0);
    }
  }
  
  ///////
  //int count = 0;
  //for (int j = 0; j < 5; j++) {
  //  fill(rcol());
  //  for (int i = 0; i < 11; i++) {
  //    //fill(#FFFFFF);
      
  //    if (count == 0) {
  //      invader(i*(width/11) + width/22, j*(height/14) + height/5, 5, 7.0, 8.0);
  //    }
      
  //    if (count > 0 && count <= 2) {
  //      invader(i*(width/11) + width/22, j*(height/14) + height/5, 5, 6.0, 8.0);
  //    }
      
  //    if (count > 2) {
  //      invader(i*(width/11) + width/22, j*(height/14) + height/5, 5, 5.0, 8.0);
  //    }
  //  }
  //  count++;
  //}
  //fill(#7FB800);
  //for (int i = 0; i < 4; i++) {
  //  bunker(i*width/4 + width/8, 4*height/6, 5);
  //}
  //tank(width/2, 5*height/6, 5);
}

void tank(int x, int y, int pixelSize) {
  pushMatrix();
  translate(x - (pixelSize * 6), (y + (pixelSize * 6)));
  int xpos = 0;
  int ypos = 0;
  for (int i = 0; i <=12; i++) {
    xpos = i*pixelSize;
    for (int j = 0; j <=6; j++) {
      if (j >= 3) {
        if (j == 3) {
          if (i != 0 && i != 12) {
            rect(xpos, ypos, pixelSize, pixelSize);
          }
        } else {
          rect(xpos, ypos, pixelSize, pixelSize);
        }
      }
      if (j <= 3 && j != 0) {
        if (j == 1) {
          if (i == 6) {
            rect(xpos, ypos, pixelSize, pixelSize);
          }
        } else {
          if (i > 4 && i < 8) {
           rect(xpos, ypos, pixelSize, pixelSize); 
          }
        }
      }
      ypos = j*pixelSize;
    }
    ypos = 0;
  }
  popMatrix();
}

void bunker(int x, int y, int pixelSize) {
  pushMatrix();
  int _width = 24;
  int _height = 18;
  int corner = 8;
  int hheight = 9;
  int hwidth = 3;
  int hheight1 = 10;
  int hwidth1 = 4;
  int hheight2 = 11;
  int hwidth2 = 5;
  int hheight3 = 12;
  int hwidth3 = 6;
  int hheight4 = 13;
  int hwidth4 = 6;
  
  translate(x - (pixelSize * _width/2), (y + (pixelSize * _height/2)));
  int xpos = 0;
  int ypos = 0;
  boolean paint = true;
  for (int i = 0; i <=_width; i++) {
    xpos = i*pixelSize;
    for (int j = 0; j <=_height; j++) {
      if ((j < corner) && (j < (corner-i) || (j+ _width - corner < i))) paint = false;
      if ((j > hheight) && (i > (_width/2 - hwidth)) && (i < (_width/2 + hwidth))) paint = false;
      if ((j > hheight1) && (i > (_width/2 - hwidth1)) && (i < (_width/2 + hwidth1))) paint = false;
      if ((j > hheight2) && (i > (_width/2 - hwidth2)) && (i < (_width/2 + hwidth2))) paint = false;
      if ((j > hheight3) && (i > (_width/2 - hwidth3)) && (i < (_width/2 + hwidth3))) paint = false;
      //if ((j > hheight4) && (i > (_width/2 - hwidth4)) && (i < (_width/2 + hwidth4))) paint = false;
      if (paint) rect(xpos, ypos, pixelSize, pixelSize);
      paint = true;
      ypos = j*pixelSize;
    }
    ypos = 0;
  }
    popMatrix();
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
  generate();
  noStroke();
}

void mouseClicked() {
 invader(mouseX, mouseY, 10, 6.0, 8.0); 
}

void draw() {
  //generate();
}
