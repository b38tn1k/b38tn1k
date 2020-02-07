int cols, rows;
int scl = 40;
int w = 5000;
int h = 5000;
float[][] terrain;
float res = 0.05;
float amp = 400;
int color1 = #F6511D;
int color2 = #FFB400;
float flying = 0;



void setup() {
    size(1920, 1080, P3D);
    cols = w / scl;
    rows = h / scl;
    terrain = new float[cols+1][rows+1];
}

float noiseVal = 0;
float noiseGain = 0;
float speed = 0.01;

void draw() {
  noiseVal += 0.001;
  noiseGain = map((sin(noiseVal)), -1, 1, 0, 1);
  noiseGain -= 0.6;
  if (noiseGain < 0) {noiseGain = 0;}
  println(noiseGain);
  background (0);
  flying -= speed;
  speed *= 1.01;
  float yoff = flying;
  for (int y = 0; y < rows; y++) {
      float xoff = 0;
        for (int x = 0; x < cols; x++) {
          float valley = (1.0 - sin(PI*((1.0*x)/cols))) * amp*3;
          //println(valley);
          terrain[x][y] = map(noise(xoff, yoff), 0, 1, -amp, amp) + valley;// + random(amp * noisGain);
          xoff += res;
        }
        yoff += res;
    }
    
    fill(0);
    //noStroke();
    //stroke(255);
    translate(width/2,7*height/8);
    rotateX(PI/2);
    translate(-w/2, -h/2);
    stroke(100, 255, 100);
    for (int y = 0; y < rows; y++) {
      beginShape(TRIANGLE_STRIP);
      for (int x = 0; x < cols; x++) {
        //fill(lerpColor(color1, color2, map(terrain[x][y], 0, 1.0, -amp, amp)));
         vertex(x * scl, y*scl, terrain[x][y]);
         vertex(x * scl, (y+1)*scl, terrain[x][y+1]);
       }
       endShape();
     }
     saveFrame();
       
}
    
