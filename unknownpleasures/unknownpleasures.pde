//int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787, #D0CBC3, #87B6C4, #EA4140, #5A5787};
//int colors[] = {#F6511D, #FFB400, #00A6ED, #7FB800, #E56399};
//int colors[] = {#845EC2, #D65DB1, #FF6F91, #FF9671, #FFC75F, #F9F871};
//int colors[] = {#A534C9, #F327A2, #FF5478, #FF8F58, #FFC650, #F9F871};
//int colors[] = {#E9E4CF, #EBD662, #CB4B86, #D8B4A4, #C89741, #A29282, #913439, #A1C8C0, #5F9AAA, #5A6062};
//int colors[] = {#FFFFFF, #1F4979, #AAC4CE, #D1D4D4, #919091, #F2822C, #F1F2F3}; //ford
int colors[] = {#ff71ce, #01cdfe, #05ffa1, #b967ff, #fffb96}; //vaporwave
//https://palettegenerator.com/ 

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
  println(timestamp);
  saveFrame(timestamp+".png");
}

void generate() {
  int bg = rcol();
  int c1 = rcol();
  int c2 = rcol();
  
  background(bg);
  fill(bg);
  stroke(rcol());
  strokeWeight(2);
  
  //bg = #000000;
  //background(bg);
  //c1 = #000000;
  //c2 = #000000;
  //stroke(#FFFFFF);
  
  //beginShape();
  //vertex(0, 50);
  //bezierVertex(80, 30, 80, 75, width, 75);
  //endShape();
  
  //float subDiv = width/100;  
  //for (float y = 0; y <= height/2; y += subDiv) {
  //  float lastPoint[] = {0, random(y, y+subDiv)};
  //  for (float x = 0; x <= width; x += subDiv) {
  //    float newPoint[] = {x, random(y, y+subDiv)};
  //    line(lastPoint[0], lastPoint[1], newPoint[0], newPoint[1]);
  //    lastPoint = newPoint;
  //  }
  //}
  
  float subDiv = width/75;  
  float xsub = 2*subDiv;
  for (float y = subDiv*20; y <= height; y += 2*subDiv) {
    fill(lerpColor(c1, c2, y/height));
    beginShape();
    vertex(0, height);
    vertex(0, y+2*subDiv);
    float lastPoint[] = {0, random(y, y+subDiv)};
    vertex(lastPoint[0], lastPoint[1]);
    for (float x = 0; x <= width; x += xsub) {
      float newPoint[] = {x, 0};
      //make it get taller in the middle!
      float scale = sin(PI/width * x);
      scale = scale * scale * scale * scale * scale * scale* scale * scale * scale * scale * scale;
      scale = 1.0 - scale;
      println(scale);
      newPoint[1] = random(y- 15*subDiv * scale, y-5*subDiv* scale);
      newPoint[0] = random(x - (0.5*subDiv), x+ 0.5*subDiv);
      vertex(newPoint[0], newPoint[1]);
    }
    vertex(width, random(y, y+2*subDiv));
    vertex(width, height);
    endShape(CLOSE);
  }
  fill(rcol());
  //fill(bg);
  //fill(0);
  noStroke();
  subDiv *= 5;
  rect(0, 0, subDiv, height);
  rect(0, 0, width, subDiv);
  rect(0, height-subDiv, width, subDiv);
  rect(width-subDiv, 0, width, height);
  //stroke(#FFFFFF);
  //stroke(bg);
  //strokeWeight(2);
  noFill();
  rect(subDiv, subDiv, width-2*subDiv, height-2*subDiv);
}

void setup() {
  size(1080, 1080, P2D);
  smooth(8);
  pixelDensity(2);
  background(255);
  generate();
}

void draw() {
}
