int cols, rows;
int scl = 40;
int w = 5000;
int h = 10000;
float[][] terrain;
float res = 0.05;
float amp = 400;
float flying = 0;
int colors[] = {#F6511D, #FFB400, #00A6ED, #7FB800, #E56399, #FFFFFF};
int rcol() {
  return colors[int(random(colors.length))];
};

PImage logo, mask;

void setup() {
    size(1080, 1080, P3D);
    cols = w / scl;
    rows = h / scl;
    terrain = new float[cols+1][rows+1];
    //logo = loadImage("logo.png");
    //mask = loadImage("mask.png");
    //logo.mask(mask);
    
}

float speed = 0.01;

void draw() {
  background (0);
  flying -= 0.1;
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
    
    
    
    fill(0, 0, 0);
    stroke(100, 255, 100);
    translate(width/2,height);
    rotateX(PI/4);
    translate(-w/2, -h/2);
    strokeWeight(2);
    
    for (int y = 0; y < rows; y++) {
      beginShape(TRIANGLE_STRIP);
      for (int x = 0; x < cols; x++) {
        //stroke(rcol());
        //fill(rcol());
         vertex(x * scl, y*scl, terrain[x][y]);
         vertex(x * scl, (y+1)*scl, terrain[x][y+1]);
       }
       endShape();
     }
     
     stroke(0);
    translate(width / 2, height / 2);
    beginShape();
    texture(logo);
    vertex(-540, -540, 0, 0,   0);
    vertex( 540, -540, 0, 1080, 0);
    vertex( 540,  540, 0, 1080, 1080);
    vertex(-540,  540, 0, 0,   1080);
    endShape();
    //saveFrame();
       
}
    
