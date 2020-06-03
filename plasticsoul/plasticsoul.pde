String title = "PLASTIC SOUL";

int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787, #D0CBC3, #87B6C4, #EA4140, #5A5787};

int rcol() {
  return colors[int(random(colors.length))];
};

void keyPressed() {
  if (key == 's') {
    saveImage(); 
  } else {
    randomSeed(second());
    generate();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  println(timestamp);
  saveFrame(timestamp+".png");
}

PFont font;
int dim = 720;
int xSquareDim = 400;
int ySquareDim = 500;
float xoffset;
float yoffset;
int bg;

void setup() {
  randomSeed(millis());
  randomSeed(millis());
  randomSeed(millis());
  size(720, 720);
  smooth(8);
  font = createFont("Sen-ExtraBold.ttf", 64);
  textFont(font);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  generate();
}

void generate() {
  randomSeed(millis());
  noiseSeed(millis());
  bg = rcol();
  bg = rcol();
  background(bg);
  int col = rcol();
  while (col == bg) {
    col = rcol();
  }
  fill(col);
  stroke(col);

  // describe the art area
  xoffset = (dim - xSquareDim)/2.0;
  yoffset = (dim - ySquareDim)/2.0;
  
  //draw art
  drawMap();
  //float coin = random(1);
  //println(coin);
  //if (coin >= 0.5) {
  //  drawMap();
  //} else {
  //  recGrid();
  //}
  ////title
  //col = rcol();
  //while (col == bg) {
  //  col = rcol();
  //}
  //fill(col);
  //stroke(col);
  //text("ROYAL CHANT", dim/2, 50);
  //text(title, dim/2, dim-70);
}

void recGrid(){
  randomSeed(millis());
  randomSeed(millis());
  randomSeed(millis());
  bg = rcol();
  background(bg);
  float step = xSquareDim / int(random(5, 20));
  float dim = step*random(0.3, 0.75);
  for (int y = 0; y <= ySquareDim; y+=step) {
    for (int x = 0; x <= xSquareDim; x+=step) {
      float r1 = x + xoffset;
      float r2 = y + yoffset;
      float r3 = dim;
      float r4 = dim;
      int col = rcol();
      fill(col);
      stroke(col);
      rect(r1, r2, r3, r4, random(40), random(40), random(40), random(40) );
    }
  }
}

void drawMap(){
  // make some noise
  float res =random(0.0001, 0.009);
  float yoff = 0; 
  float[][] noiseField = new float[xSquareDim][ySquareDim];
  for (int y = 0; y < ySquareDim; y++) {
    float xoff = 0;
    for (int x = 0; x < xSquareDim; x++) {
      noiseField[x][y] = noise(xoff, yoff);
      xoff+=res;
    }
    yoff+=res;
    if (yoff > 1080/200){
      yoff = 0;
    }
  }
  //draw result
  int c1 = rcol();
  int c2 = rcol();
  while (c2 == c1) {c2 = rcol();}
  int cc = c1;
  float levelHeight = 0.1;
  float level = levelHeight;
  while (level < 1.0) {
    stroke(cc);
    for (int y = 0; y < ySquareDim; y++) {
      for (int x = 0; x < xSquareDim; x++) {
        if (noiseField[x][y] > level) {
          point(y + yoffset, x + xoffset);
        }
      }
    }
    level += levelHeight;
    cc = rcol();
  }
  
  
}

void draw(){
   generate();
   //saveFrame();
}
