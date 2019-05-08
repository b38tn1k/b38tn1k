//int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787, #D0CBC3, #87B6C4, #EA4140, #5A5787};
//int colors[] = {#F6511D, #FFB400, #00A6ED, #7FB800, #E56399};
//int colors[] = {#845EC2, #D65DB1, #FF6F91, #FF9671, #FFC75F, #F9F871};
int colors[] = {#A534C9, #F327A2, #FF5478, #FF8F58, #FFC650, #F9F871};


int rcol() {
  return colors[int(random(colors.length))];
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
  float rotate = random(0, PI);
  int colors2[] = {#845EC2, #D65DB1, #FF6F91, #FF9671, #FFC75F, #F9F871};
  colors = colors2;
  //grid(16, rotate);
  //column(5, rotate, 0);
  
  //column(10, rotate, 2);
  //column(10, rotate, 3);
  
  //column(20, rotate, 8);
  //column(20, rotate, 9);
  //column(20, rotate, 10);
  //column(20, rotate, 11);
  
  //column(40, rotate, 24);
  //column(40, rotate, 25);
  //column(40, rotate, 26);
  //column(40, rotate, 27);
  //column(40, rotate, 28);
  //column(40, rotate, 29);
  //column(40, rotate, 30);
  //column(40, rotate, 31);
  
  //column(80, rotate, 64);
  //column(80, rotate, 65);
  //column(80, rotate, 66);
  //column(80, rotate, 67);
  //column(80, rotate, 68);
  //column(80, rotate, 69);
  //column(80, rotate, 70);
  //column(80, rotate, 71);
  //column(80, rotate, 72);
  //column(80, rotate, 73);
  //column(80, rotate, 74);
  //column(80, rotate, 75);
  //column(80, rotate, 76);
  //column(80, rotate, 77);
  //column(80, rotate, 78);
  //column(80, rotate, 79);
  
  //int colors2[] = {#845EC2, #D65DB1, #FF6F91, #FF9671, #FFC75F, #F9F871};
  //colors = colors2;
  
  
  grid(20, rotate);
}

void column(int number, float rotate, int off) {
  
  for (int i = 0; i< number; i++) {
    for (int j = 0; j<number; j++) {
      if (i == off) {
        pushMatrix();
        translate(i*width/number + (width/(number*2)), j*height/number + (height/(number*2)), 0);
        rotateX(rotate);
        rotateY(rotate);
        fill(rcol());
        //noFill();
        box(width/(number));
        popMatrix();
      }
    }
  }
}

void grid(int number, float rotate) {
  for (int i = 0; i< number; i++) {
    for (int j = 0; j<number; j++) {
      pushMatrix();
      rotate = random(0, PI);
      translate(i*width/number + (width/(number*2)), j*height/number + (height/(number*2)), 200);
      //rotateX(rotate);
      //rotateY(rotate);
      fill(rcol());
      box(width/(2*number));
      popMatrix();
    }
  }
}

void setup() {
  size(1080, 1080, P3D);
  smooth(8);
  pixelDensity(2);
  background(255);
  generate();
}

void draw() {
}
