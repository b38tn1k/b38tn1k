//int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787, #D0CBC3, #87B6C4, #EA4140, #5A5787};
//green = #7FB800
//int colors[] = {#F6511D, #FFB400, #00A6ED, #7FB800, #E56399, #FFFFFF};
int colors[] = { #0D0D0D, #343434, #69450F, #A14111, #BB3F11, #BB2C38, #E73876, #A635A6, #DF46E2, #FC7DAC, #FBA076, #FAB265, #FBD99E, #EAF494, #C6F393, #CCCDCE, #D6D4D3, #F6DCC6, #FBE4C5, #F6D1E8, #FACCFD, #E1CBFC, #CBCFFC, #B7E6FB, #C1F1E5, #FDFAFD, #FFFFFF, #F59CFC, #A99AFA, #85ADFA, #4FBFF8, #13DEF7, #12D7E6, #139AF7, #138FF7, #1855F7, #1544CD, #5552CC, #7971F9, #969696, #6F6F6F, #0F5070, #118EA5, #11B270, #11B21D, #11BF1E, #108A19, #107D17, #0F6E16, #BA8711, #E7852F, #F96B13, #F8B013, #D5F02D, #71D87E, #6FF2BC};
int new_colors[][] = {{13,13,13},{52,52,52},{105,69,15},{161,65,17},{187,63,17},{187,44,56},{231,56,118},{166,53,166},{223,70,226},{252,125,172},{251,160,118},{250,178,101},{251,217,158},{234,244,148},{198,243,147},{204,205,206},{214,212,211},{246,220,198},{251,228,197},{246,209,232},{250,204,253},{225,203,252},{203,207,252},{183,230,251},{193,241,229},{253,250,253},{255,255,255},{245,156,252},{169,154,250},{133,173,250},{79,191,248},{19,222,247},{18,215,230},{19,154,247},{19,143,247},{24,85,247},{21,68,205},{85,82,204},{121,113,249},{150,150,150},{111,111,111},{15,80,112},{17,142,165},{17,178,112},{17,178,29},{17,191,30},{16,138,25},{16,125,23},{15,110,22},{186,135,17},{231,133,47},{249,107,19},{248,176,19},{213,240,45},{113,216,126},{111,242,188}};

void get_cs() {
  print("{ #");
  for (int i = 0; i < new_colors.length; i++) {
    int c = (color(new_colors[i][0], new_colors[i][1],new_colors[i][2]));
    print(hex(c, 6));
    print(", #");
  }
  print('}');
}

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
  saveImage();
  clear();
  background(255, 0, 255);
  noStroke();
  //flower(width/4, height/2);
  for (int i = 0; i < 10; i++) {
    flower(int(random(30, width-30)), int(random(30, height - 30)));
  }
  //flower(3*width/4, height/2);
  
  
}

void flower(int x, int y) {
  int radius = int(random(15, 20));
  float centerbit = random(0.2, 0.8);
  
  //leafs
  for (int i = 0; i < random(5); i++) {
    
    ellipseMode(CORNER);
    int angle = randint(-30);
    int tip = int(random(radius/5, radius/3));
    float leafw = random(0.3, 0.5);
    int leafy = int(random((y + radius/2), 15));
    //right
    if (coin()) {
      pushMatrix();
      translate(x, leafy);
      rotate(radians(angle));
      fill(#11BF1E);
      ellipse(0, 0, tip, leafw*tip);
      fill(255, 255, 255, 40);
      ellipse(0, 0, tip, leafw*tip*centerbit);
      popMatrix();
    }
    
    if (coin()) {
      //left
      angle = randint(30) + 180;
      tip = tip = int(random(radius/5, radius/3));
      leafy = int(random((y + radius/2), 15));
      leafw = random(0.3, 0.5);
      pushMatrix();
      translate(x, leafy);
      rotate(radians(angle));
      fill(#11BF1E);
      ellipse(0, 0, tip, leafw*tip);
      fill(255, 255, 255, 40);
      ellipse(0, 0, tip, leafw*tip*centerbit);
      popMatrix();
    }
  }
  
  // the stem
  int stemwidth = 1;// int(random(1, 3));
  fill(#11BF1E);
  rect(x, y, stemwidth, 15);
  
  // petals
  ellipseMode(CENTER);
  int petalCount = int(random(4, 20));
  float petalAngle = 180/petalCount;
  int colorcount = int(random(1, 4));
  int thisFlower[] = {rcol(), rcol(), rcol(), rcol(), rcol()};
  for (int i = 180; i >= 0; i-=petalAngle) {
    fill(rcolsub(thisFlower, colorcount));
    pushMatrix();
    translate(x, y);
    rotate(radians(i));
    ellipse(0, 0, radius, radius/petalCount);
    ellipse(0, 0, radius/petalCount, radius);
    fill(255, 255, 255, 40);
    ellipse(0, 0, radius, centerbit*(radius/petalCount));
    ellipse(0, 0, centerbit*(radius/petalCount), radius);
    popMatrix();
  } 
  // the pollen bit
  int pollen = int(random(1.2*radius/petalCount, radius/2));
  fill(rcol());
  ellipse(x, y, pollen, pollen);
  fill(255, 255, 255, 40);
  int pollenCount = int(random(5, 40));
  float px;
  float py;
  for (int i = 0; i < pollenCount; i++) {
    px = random(x - pollen/3, x + pollen/3);
    py = random(y - pollen/3, y + pollen/3);
    //if ((sqrt(px-x)*(px-x) + (py-y)*(py-y)) < pollen) {
      ellipse(px, py, 5, 5);
    //}
  }
}

void setup() {
  size(1080, 128, P3D);
  smooth(0);
  pixelDensity(1);
  background(0);
  generate();
  noStroke();
  get_cs();
}

void mouseClicked() {
 flower(mouseX, mouseY); 
}

void draw() {
}
