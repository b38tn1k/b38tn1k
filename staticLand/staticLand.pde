int cols, rows;
int scl = 40;
int w = 10000;
int h = 7000;
float[][] terrain;
float res = 0.05;
float amp = 1000;
int color1 = #F6511D;
int color2 = #FFB400;
float flying = 0;
float min, max;

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

void generate(){
  float yoff = random(-1000, 1000);
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
      for (int x = 0; x < cols; x++) {
        float valley = (1.0 - sin(PI*((1.0*x)/cols))) * 2*amp;
        terrain[x][y] = map(noise(xoff, yoff), 0, 1, -amp/3, amp/3) + valley + map(noise(xoff/2, yoff/2), 0, 1, -amp/2, amp/2);
        xoff += res;
        if (terrain[x][y] < min) {
          min = terrain[x][y];
        }
        if (terrain[x][y] > max) {
          max = terrain[x][y];
        }
      }
      yoff += res;
  }
  
}



void setup() {
    smooth(8);
    size(3840, 2160, P3D);
    //size(1080, 1080, P3D);
    cols = w / scl;
    rows = h / scl;
    terrain = new float[cols+1][rows+1];
    generate();
}


void draw() {
  
    //sky(0.005);
    background(0);
    translate(width/2,7*height/8);
    rotateX(PI/3);
    translate(-w/2, -h/2);
    stroke(80, 255,80);
    strokeWeight(2);
    for (int y = 0; y < rows; y++) {
      beginShape(TRIANGLE_STRIP);
      for (int x = 0; x < cols; x++) {
         //float lerper =  map((terrain[x][y]), min, max, 0, 1);
         //int base = lerpColor(#1c6610, #c1cce1, lerper);
         //fill(base);
         fill(0);
         vertex(x * scl, y*scl, terrain[x][y]);
         vertex(x * scl, (y+1)*scl, terrain[x][y+1]);
       }
       endShape();
     } 
     //noLoop();
}

int skyBlue1 = #7894ef;
int skyBlue2 = #c6ffff;
int cloudWhite1 = #FFFFFF;
int cloudWhite2 = #8995b2;
int step = 3;

void sky(float noiseScale) {
  //translate(0, 0, -2*h);
  noiseSeed(int(random(1000)));
  noStroke();
  for (int x=0; x < width; x+=step) {
    for (int y=0; y < height; y+=step) {
      int skyBlue = lerpColor(skyBlue1,skyBlue2, float(y)/height * 3);
      int cloudWhite = lerpColor(cloudWhite1,cloudWhite2, float(y)/(2*height));
      float noiseVal = noise(x*noiseScale, y*noiseScale);
      //float otherNoise = noise(x*noiseScale*10, y*noiseScale*10);
      //noiseVal = noiseVal / otherNoise;
      int this_color = lerpColor(cloudWhite, skyBlue, noiseVal);
      fill(this_color);
      rect(x, y, step, step);
    }
  }
  //translate(0, 0, h);
};
    
