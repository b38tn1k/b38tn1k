//int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787, #D0CBC3, #87B6C4, #EA4140, #5A5787};
//green = #7FB800
//int colors[] = {#F6511D, #FFB400, #00A6ED, #7FB800, #E56399, #FFFFFF};
int colors[] = {#F6511D, #FFB400, #00A6ED, #E56399, #FFFFFF};
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
  background(0);
  noStroke();
  //flower(width/4, height/2);
  flower(width/2, height/3);
  //flower(3*width/4, height/2);
  
  
}

void flower(int x, int y) {
  int radius = int(random(80, 400));
  float centerbit = random(0.2, 0.8);
  
  //leafs
  for (int i = 0; i < random(5); i++) {
    
    ellipseMode(CORNER);
    int angle = randint(-30);
    int tip = int(random(radius/5, radius/3));
    float leafw = random(0.3, 0.5);
    int leafy = int(random((y + radius/2), height - radius));
    //right
    if (coin()) {
      pushMatrix();
      translate(x, leafy);
      rotate(radians(angle));
      fill(#7FB800);
      ellipse(0, 0, tip, leafw*tip);
      fill(255, 255, 255, 40);
      ellipse(0, 0, tip, leafw*tip*centerbit);
      popMatrix();
    }
    
    if (coin()) {
      //left
      angle = randint(30) + 180;
      tip = tip = int(random(radius/5, radius/3));
      leafy = int(random((y + radius/2), height - radius));
      leafw = random(0.3, 0.5);
      pushMatrix();
      translate(x, leafy);
      rotate(radians(angle));
      fill(#7FB800);
      ellipse(0, 0, tip, leafw*tip);
      fill(255, 255, 255, 40);
      ellipse(0, 0, tip, leafw*tip*centerbit);
      popMatrix();
    }
  }
  
  // the stem
  int stemwidth = int(random(4, 10));
  fill(#7FB800);
  rect(x, y, stemwidth, height);
  
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
  size(1080, 1080, P3D);
  smooth(8);
  pixelDensity(2);
  background(0);
  generate();
  noStroke();
}

void mouseClicked() {
 flower(mouseX, mouseY); 
}

void draw() {
}
