int colors[] = {#F6511D, #FFB400, #00A6ED, #7FB800, #E56399, #FFFFFF};
int rcol() {
  return colors[int(random(colors.length))];
};
int cols, rows;
int scl = 20;
int w = 10000;
int h = 7000;
float[][] terrain;
float res = 0.05;
float amp = 5000;
int color1 = #F6511D;
int color2 = #FFB400;
float flying = 0;
float min, max;
boolean pause = true;

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
  int bg = rcol();
  background(bg);
  translate(width/2,7*height/8);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  fill(rcol());
  stroke(rcol());
  //strokeWeight(2);
  for (int y = 0; y < rows; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      fill(rcol());
      stroke(100, 255, 100);
      stroke(rcol());
      //noStroke();
      vertex(x * scl, y*scl, terrain[x][y]);
      vertex(x * scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
   }
}



void setup() {
    smooth(8);
    size(1080, 1080, P3D);
    pixelDensity(2);
    //size(1080, 1080, P3D);
    cols = w / scl;
    rows = h / scl;
    terrain = new float[cols+1][rows+1];
    generate();
}


void draw() {
    
}
